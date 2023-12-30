# xray配置


<details>
<summary>Docker部署xray</summary>


###  一键安装docker

```
curl -fsSL https://get.docker.com | sh
```

###  拉取xray镜像

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
echo 'xray节点配置' > /usr/local/etc/xray/config.json
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
---
##  手动安装xray


手动安装 Xray-core 在 Ubuntu 系统上通常涉及下载二进制文件、配置服务，并创建配置文件。以下是一般步骤：

1. 下载 Xray-core
访问 Xray-core 的 GitHub 发布页面  https://github.com/XTLS/Xray-core/releases
----
下载```Xray-linux-64.zip```文件

3. 解压文件
解压下载的文件到 /usr/local/bin 或其他您希望存放二进制文件的目录：
```
sudo unzip Xray-linux-64.zip -d /usr/local/bin
```
确保 /usr/local/bin 在您的 PATH 环境变量中。

3. 赋予执行权限
赋予 Xray 可执行文件执行权限：
```
sudo chmod +x /usr/local/bin/xray
```
4. 创建配置文件
Xray 需要一个配置文件才能运行。通常，这个文件位于 /usr/local/etc/xray/config.json。
```
sudo mkdir -p /usr/local/etc/xray
```
创建一个新的 config.json 文件并编辑它。您可以使用任何文本编辑器：
```
sudo nano /usr/local/etc/xray/config.json
```
在编辑器中，输入您的 Xray 配置。您可以在 Xray-core 的官方文档中找到配置样例。

5. 运行 Xray
运行 Xray 以确保一切正常：
```
sudo xray -c /usr/local/etc/xray/config.json
```
6. 设置为系统服务（可选）
为了使 Xray 在启动时自动运行，您可以创建一个 systemd 服务文件。

创建一个新的 systemd 服务文件：
```
sudo nano /etc/systemd/system/xray.service
```
在文件中添加以下内容（您可能需要根据您的安装调整路径）：

```
[Unit]
Description=Xray Service
After=network.target

[Service]
User=nobody
ExecStart=/usr/local/bin/xray -c /usr/local/etc/xray/config.json
Restart=on-failure

[Install]
WantedBy=multi-user.target
```
启用并启动服务：
```
sudo systemctl enable xray
```
```
sudo systemctl start xray
```
检查服务状态：
```
sudo systemctl status xray
```

---
###  Reality域名推荐列表

```

addons.mozilla.org
s0.awsstatic.com
d1.awsstatic.com
images-na.ssl-images-amazon.com
m.media-amazon.com

player.live-video.net
one-piece.com
lol.secure.dyn.riotcdn.net
www.lovelive-anime.jp
www.swift.com
academy.nvidia.com
www.cisco.com
cdn-dynmedia-1.microsoft.com
update.microsoft
www.tesla.com
www.cloudflare.com

```
---
###  更多配置模板

https://github.com/XTLS/Xray-examples


###  配置文档

https://xtls.github.io/config/

### 安装文档

https://xtls.github.io/document/install.html#windows-%E5%AE%89%E8%A3%85%E6%96%B9%E5%BC%8F

#####  感谢xray团队为科学上网做出的贡献
---
