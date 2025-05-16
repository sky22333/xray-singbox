#!/bin/bash

set -e

# 颜色定义
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
RED='\033[1;31m'
NC='\033[0m' # 无色

# 可以通过环境变量替换下载地址
MIHOMO_URL="${MIHOMO_URL:-https://github.com/MetaCubeX/mihomo/releases/download/v1.19.8/mihomo-linux-amd64-v1.19.8.gz}"
BIN_PATH="/usr/local/bin/mihomo"
CONFIG_DIR="/etc/mihomo"
CONFIG_FILE="$CONFIG_DIR/config.yaml"
SERVICE_FILE="/etc/systemd/system/mihomo.service"

install_mihomo() {
  if [ -f "$BIN_PATH" ]; then
    echo -e "${YELLOW}已检测到 $BIN_PATH 存在，Mihomo 可能已安装，跳过安装。${NC}"
    return
  fi

  echo -e "${BLUE}开始安装 Mihomo...${NC}"
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

  echo -e "${BLUE}创建 systemd 服务文件...${NC}"
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

  echo -e "${BLUE}重新加载 systemd...${NC}"
  systemctl daemon-reload

  echo -e "${BLUE}设置开机自启...${NC}"
  systemctl enable mihomo

  echo -e "${GREEN}安装完成。${NC}"
  echo -e "${GREEN}配置文件路径: ${CONFIG_FILE}${NC}"
  echo -e "${GREEN}可在菜单中启动服务。${NC}"
}

uninstall_mihomo() {
  echo -e "${RED}确定要卸载 Mihomo？这将删除所有相关文件！(y/n)${NC}"
  read -r confirm
  if [[ "$confirm" != "y" ]]; then
    echo -e "${YELLOW}已取消卸载${NC}"
    return
  fi

  systemctl stop mihomo || true
  systemctl disable mihomo || true

  rm -f "$BIN_PATH"
  rm -rf "$CONFIG_DIR"
  rm -f "$SERVICE_FILE"
  systemctl daemon-reload
  echo -e "${GREEN}已彻底卸载 Mihomo${NC}"
}

menu() {
  while true; do
    echo ""
    echo -e "${BLUE}========= Mihomo 服务管理工具 =========${NC}"
    echo -e "${GREEN}1.${NC} 安装 Mihomo"
    echo -e "${GREEN}2.${NC} 启动服务"
    echo -e "${GREEN}3.${NC} 停止服务"
    echo -e "${GREEN}4.${NC} 重启服务"
    echo -e "${GREEN}5.${NC} 查看状态"
    echo -e "${GREEN}6.${NC} 查看日志"
    echo -e "${YELLOW}7.${NC} 卸载 Mihomo"
    echo -e "${GREEN}0.${NC} 退出"
    echo -e "${BLUE}==========================================${NC}"
    read -p "请输入选项编号: " choice
    case "$choice" in
      1) install_mihomo ;;
      2) systemctl start mihomo && echo -e "${GREEN}服务已启动${NC}" ;;
      3) systemctl stop mihomo && echo -e "${YELLOW}服务已停止${NC}" ;;
      4) systemctl restart mihomo && echo -e "${GREEN}服务已重启${NC}" ;;
      5) systemctl status mihomo ;;
      6) journalctl -u mihomo -o cat -f ;;
      7) uninstall_mihomo ;;
      0) echo -e "${GREEN}再见！${NC}"; exit 0 ;;
      *) echo -e "${RED}无效选项，请重新输入。${NC}" ;;
    esac
  done
}

menu
