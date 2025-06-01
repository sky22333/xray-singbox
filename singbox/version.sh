#!/bin/bash

# 获取 GitHub releases 最新 tag 的重定向地址
tag=$(curl -sI https://github.com/SagerNet/sing-box/releases/latest \
  | grep -i '^location:' \
  | grep -oE '/tag/[^ ]+' \
  | sed 's#/tag/##')

# 输出
echo "版本号: $tag"
[[ "$tag" =~ ^v ]] && echo "纯版本号: ${tag#v}" || echo "纯版本号: $tag"
