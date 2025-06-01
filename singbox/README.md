-  `v1.11.5`版本安装脚本
```
bash <(curl -Ls https://raw.githubusercontent.com/sky22333/xray-singbox/main/singbox/install.sh)
```

> 支持动态传入版本号，例如：`-v 1.11.11`

- 卸载

```
dpkg --purge sing-box
rm -rf /etc/sing-box
```

---

-  `anytls`协议需要`v1.12.0`版本以上

https://github.com/SagerNet/sing-box/releases/tag/v1.12.0-beta.13


---

# sing-box

#### Dokcer安装
```
cd /home && touch config.json
```
```
docker run -d \
  --name sb \
  --network host \
  --restart always \
  --volume $PWD/:/etc/sing-box/ \
  --cap-add NET_ADMIN \
  --device /dev/net/tun \
  gzxhwq/sing-box:latest
```

#### 命令

配置文件              `/etc/sing-box/config.json`

启动	             `systemctl start sing-box`

停止	             `systemctl stop sing-box`

开机自启	             `systemctl enable sing-box`

重新启动	             `systemctl restart sing-box`

运行状态              `systemctl status sing-box`

查看日志	             `journalctl -u sing-box --output cat -e`

实时日志	             `journalctl -u sing-box --output cat -f`

生成uuid             `cat /proc/sys/kernel/random/uuid`

生成reality-key      `sing-box generate reality-keypair`

##### [配置文件示例](https://github.com/chika0801/sing-box-examples)   

##### [官方文档](https://sing-box.sagernet.org/zh/configuration/)
