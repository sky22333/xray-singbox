
管理命令：
```
#一键安装hy2
bash <(curl -fsSL https://get.hy2.sh/)

#一键卸载hy2
bash <(curl -fsSL https://get.hy2.sh/) --remove


#启动
systemctl start hysteria-server.service

#重启
systemctl restart hysteria-server.service

#查看状态
systemctl status hysteria-server.service

#停止
systemctl stop hysteria-server.service

#设置开机自启
systemctl enable hysteria-server.service

#查看日志
journalctl -u hysteria-server.service
```
生成自签证书：
```
openssl req -x509 -nodes -newkey ec:<(openssl ecparam -name prime256v1) -keyout /etc/hysteria/server.key -out /etc/hysteria/server.crt -subj "/CN=bing.com" -days 36500 && sudo chown hysteria /etc/hysteria/server.key && sudo chown hysteria /etc/hysteria/server.crt
```

性能优化：将发送 接收两个缓冲区都设置为 16 MB
```
sysctl -w net.core.rmem_max=16777216
sysctl -w net.core.wmem_max=16777216
```

服务端配置：
```
cat << EOF > /etc/hysteria/config.yaml
listen: :8443 #监听端口

#使用CA证书
#acme:
#  domains:
#    - example.com #你的域名，需要先解析到服务器
#  email: testexample@gmail.com

#使用自签证书
tls:
  cert: /etc/hysteria/server.crt
  key: /etc/hysteria/server.key

quic:
  initStreamReceiveWindow: 26843545
  maxStreamReceiveWindow: 26843545
  initConnReceiveWindow: 67108864
  maxConnReceiveWindow: 67108864

bandwidth:
  up: 100 mbps
  down: 20 mbps

auth:
  type: password
  password: ScTTOrcUCC2mUrITDh #设置认证密码
  
masquerade:
  type: proxy
  proxy:
    url: https://bing.com #伪装网址
    rewriteHost: true
EOF
```

节点URL格式：
```
hy2://认证密码@服务器IP:端口/?sni=bing.com&insecure=1#hy2
```
clash-meta.yaml格式：
```
proxies:
  - {name: hy2, server: 服务器IP, port: 端口, client-fingerprint: chrome, type: hysteria2, password: 认证密码, auth: 认证密码, sni: bing.com, skip-cert-verify: true}
```

---

> 回国可以去掉`masquerade`块的配置

> 官方文档 [端口跳跃](https://v2.hysteria.network/zh/docs/advanced/Port-Hopping/)
