# xray配置模板

###  安装xray

```
bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install
```


###  安装 Xray-core 并将其升级到预发行版本

```
bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install --beta
```

###  xray配置文件

```
/usr/local/etc/xray/*.json
```


###  xray重启

```
sudo systemctl restart xray
```


###  查看xray运行状态


```
sudo systemctl status xray
```


###  xray日志

```
/var/log/xray/access.log
/var/log/xray/error.log
```
