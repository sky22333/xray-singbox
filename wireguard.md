## 3xui面板wireguard出站配置示例

#### 替换两个key和IP即可
```
{
  "tag": "warp",
  "protocol": "wireguard",
  "settings": {
    "mtu": 1420,
    "secretKey": "WJrzyxwl9Bd0FW5mYbjcxmcLW8OcTrEuxY/2CJ7Z9XI=",
    "address": [
      "10.0.0.2/32"
    ],
    "workers": 2,
    "domainStrategy": "ForceIP",
    "peers": [
      {
        "publicKey": "1f3atdOP+eNhKLAcTsf1o4WiY3ENeSZk63Wdi/y3Ojs=",
        "allowedIPs": [
          "0.0.0.0/0",
          "::/0"
        ],
        "endpoint": "35.72.13.16:44861",
        "keepAlive": 0
      }
    ],
    "kernelMode": false
  }
}
```


