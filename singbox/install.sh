#!/bin/bash

set -e -o pipefail

# 版本号
VERSION=1.11.5
curl -Lo sing-box.deb "https://github.com/SagerNet/sing-box/releases/download/v${VERSION}/sing-box_${VERSION}_linux_amd64.deb"
sudo dpkg -i sing-box.deb
rm sing-box.deb

echo "Sing-box ${VERSION} 安装成功!"
