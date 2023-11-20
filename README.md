# xray配置模板

###  安装xray-core

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


###  官方文档

https://xtls.github.io/config/
