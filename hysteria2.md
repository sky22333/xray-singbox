
管理命令：
```
#一键安装Hysteria2
bash <(curl -fsSL https://get.hy2.sh/)


#启动Hysteria2
systemctl start hysteria-server.service

#重启Hysteria2
systemctl restart hysteria-server.service

#查看Hysteria2状态
systemctl status hysteria-server.service

#停止Hysteria2
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
#tls:
#  cert: /etc/hysteria/server.crt
#  key: /etc/hysteria/server.key

bandwidth:
  up: 30 m
  down: 100 m

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
hysteria2://认证密码@服务器IP:端口/?sni=bing.com&insecure=1#hy2
```
clash格式：
```
proxies:
  - {name: hy2, server: 服务器IP, port: 端口, client-fingerprint: chrome, type: hysteria2, password: 认证密码, auth: 认证密码, sni: bing.com, skip-cert-verify: true}
```

回国可以去掉`masquerade`块的配置


官方文档 [端口跳跃](https://v2.hysteria.network/zh/docs/advanced/Port-Hopping/)
