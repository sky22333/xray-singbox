# xray配置


<details>
<summary>Docker部署xray</summary>


###  一键安装docker

```
curl -fsSL https://get.docker.com | sh
```

###  拉取镜像

```
docker pull teddysun/xray
```


###  创建配置文件目录

```
mkdir -p /etc/xray
```


###  创建json文件并写入节点配置

```
cat > /etc/xray/config.json <<EOF
{
  "inbounds": [{
    "port": 9000,
    "protocol": "vmess",
    "settings": {
      "clients": [
        {
          "id": "1eb6e917-774b-4a84-aff6-b058577c60a5"
        }
      ]
    }
  }],
  "outbounds": [{
    "protocol": "freedom",
    "settings": {}
  }]
}
EOF
```


###  监听对应端口并运行

```
docker run -d -p 9000:9000 --name xray --restart=always -v /etc/xray:/etc/xray teddysun/xray
```



</details>


---

---

---


#  Liunx安装xray-core

```
bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install
```


###  安装 Xray-core 并将其升级到预发行版本

```
bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install --beta
```

###  xray配置文件路径（.json）

```
/usr/local/etc/xray
```

###  直接写入xray配置

```
echo '//xray配置' > /usr/local/etc/xray/config.json
```


###  xray重新运行

```
sudo systemctl restart xray
```


###  xray运行状态


```
sudo systemctl status xray
```


###  xray日志路径

```
/var/log/xray/access.log
/var/log/xray/error.log
```


###  指定配置文件运行

```
xray run [-c config.json] [-confdir dir]
```


###  更多配置模板

https://github.com/XTLS/Xray-examples


###  配置文档

https://xtls.github.io/config/

### 安装文档

https://xtls.github.io/document/install.html#windows-%E5%AE%89%E8%A3%85%E6%96%B9%E5%BC%8F

#####  感谢xray团队为科学上网做出的贡献
---
