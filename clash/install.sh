#!/bin/bash

set -e

# 可以通过环境变量替换下载地址
MIHOMO_URL="${MIHOMO_URL:-https://github.com/MetaCubeX/mihomo/releases/download/v1.19.8/mihomo-linux-amd64-v1.19.8.gz}"
BIN_PATH="/usr/local/bin/mihomo"
CONFIG_DIR="/etc/mihomo"
CONFIG_FILE="$CONFIG_DIR/config.yaml"
SERVICE_FILE="/etc/systemd/system/mihomo.service"

install_mihomo() {
  echo "🚀 开始安装 Mihomo..."
  curl -L "$MIHOMO_URL" -o /tmp/mihomo.gz
  gunzip -f /tmp/mihomo.gz
  mv /tmp/mihomo "$BIN_PATH"
  chmod +x "$BIN_PATH"
  rm -f /tmp/mihomo.gz
  mkdir -p "$CONFIG_DIR"

  cat > "$CONFIG_FILE" << EOF
log-level: warning

listeners:
- name: ss-in
  type: shadowsocks
  port: 10001
  listen: 127.0.0.1 
  cipher: aes-256-gcm
  password: vlmpIPSyHH6f4S8WVPdRIHIlzmB+GIRfoH3aNJ/t9Gg=

proxies:
- name: "direct"
  type: direct

rules:
- MATCH,direct
EOF

  echo "创建 systemd 服务文件..."
  cat > "$SERVICE_FILE" << EOF
[Unit]
Description=mihomo Daemon, Another Clash Kernel.
After=network.target NetworkManager.service systemd-networkd.service iwd.service

[Service]
Type=simple
LimitNPROC=500
LimitNOFILE=1000000
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_RAW CAP_NET_BIND_SERVICE CAP_SYS_TIME CAP_SYS_PTRACE CAP_DAC_READ_SEARCH CAP_DAC_OVERRIDE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_RAW CAP_NET_BIND_SERVICE CAP_SYS_TIME CAP_SYS_PTRACE CAP_DAC_READ_SEARCH CAP_DAC_OVERRIDE
Restart=always
ExecStartPre=/usr/bin/sleep 1s
ExecStart=$BIN_PATH -d $CONFIG_DIR
ExecReload=/bin/kill -HUP \$MAINPID

[Install]
WantedBy=multi-user.target
EOF

  echo "重新加载 systemd..."
  systemctl daemon-reload

  echo "设置开机自启..."
  systemctl enable mihomo

  echo "安装完成！可在菜单中启动服务。"
}

uninstall_mihomo() {
  echo "确定要卸载 Mihomo？这将删除所有相关文件！(y/n)"
  read -r confirm
  if [[ "$confirm" != "y" ]]; then
    echo "已取消卸载"
    return
  fi

  systemctl stop mihomo || true
  systemctl disable mihomo || true

  rm -f "$BIN_PATH"
  rm -rf "$CONFIG_DIR"
  rm -f "$SERVICE_FILE"
  systemctl daemon-reload
  echo "已彻底卸载 Mihomo"
}

menu() {
  while true; do
    echo ""
    echo "========= Mihomo 服务管理工具 ========="
    echo "1. 安装 Mihomo"
    echo "2. 启动服务"
    echo "3. 停止服务"
    echo "4. 重启服务"
    echo "5. 查看状态"
    echo "6. 查看日志（实时）"
    echo "7. 查看日志（末尾）"
    echo "8. 卸载 Mihomo（彻底删除）"
    echo "0. 退出"
    echo "=========================================="
    read -p "请输入选项编号: " choice
    case "$choice" in
      1) install_mihomo ;;
      2) systemctl start mihomo && echo "服务已启动" ;;
      3) systemctl stop mihomo && echo "服务已停止" ;;
      4) systemctl restart mihomo && echo "服务已重启" ;;
      5) systemctl status mihomo ;;
      6) journalctl -u mihomo -o cat -f ;;
      7) journalctl -u mihomo -o cat -e ;;
      8) uninstall_mihomo ;;
      0) echo "再见！"; exit 0 ;;
      *) echo "无效选项，请重新输入。" ;;
    esac
  done
}

menu
