#!/bin/bash

set -e -o pipefail

# 默认版本号
VERSION="1.11.5"

# 解析命令行参数
while [[ $# -gt 0 ]]; do
  case "$1" in
    -v|--version)
      VERSION="$2"
      shift 2
      ;;
    *)
      echo "用法: $0 [-v 版本号]"
      exit 1
      ;;
  esac
done

# 下载并安装 sing-box
curl -Lo sing-box.deb "https://github.com/SagerNet/sing-box/releases/download/v${VERSION}/sing-box_${VERSION}_linux_amd64.deb"
sudo dpkg -i sing-box.deb
rm sing-box.deb

echo "Sing-box ${VERSION} 安装成功!"
