| 参数名称(全局配置)                | 作用                                                         |
|-------------------------|--------------------------------------------------------------|
| mixed-port              | HTTP(S) 和 SOCKS4(A)/SOCKS5 代理服务共用一个端口              |
| allow-lan               | 设置为 true 以允许局域网的连接（可用来共享代理）              |
| bind-address            | 仅当 allow-lan 为 true 时有效                                |
| ipv6                    | 当设置为 false 时, 解析器不会将主机名解析为 IPv6 地址          |
| mode                    | Clash 路由工作模式                                           |
| log-level               | 日志级别: info / warning / error / debug / silent            |
| external-controller     | RESTful Web API 监听地址                                     |
| secret                  | RESTful API 的口令(可选)                                     |
| dns                     | DNS 服务设置                                                 |
| proxies                 | 代理节点                                                     |
| proxy-groups            | 策略组                                                       |
| rules                   | 分流规则                                                     |

| 参数名称(DNS配置)                 | 作用                                                        |
|------------------------|-------------------------------------------------------------|
| enable                 | 是否启动自定义dns模块                                        |
| prefer-h3              | 是否优先使用 DOH 的 http/3                                  |
| use-hosts              | 是否查询配置中的 hosts                                       |
| use-system-hosts       | 是否查询系统 hosts                                           |
| respect-rules          | dns 连接跟随 rules，需配置proxy-server-nameserver           |
| listen                 | DNS 服务监听，仅支持 udp                                     |
| ipv6                   | 是否解析 IPV6, 如为 false, 则回应 AAAA 的空解析              |
| enhanced-mode          | DNS 处理模式                                                |
| fake-ip-range          | fakeip 下的 IP 段设置                                        |
| fake-ip-filter         | fakeip 过滤，以下地址不会下发 fakeip 映射用于连接            |
| default-nameserver     | 默认 DNS, 用于解析nameserver中的加密 dns                    |
| nameserver-policy      | 指定域名查询的解析服务器，可使用 geosite                    |
| nameserver             | 默认的域名解析服务器                                        |
| proxy-server-nameserver| 代理节点域名解析服务器                                       |
| fallback               | 后备域名解析服务器                                           |
| fallback-filter        | 后备域名解析服务器筛选                                       |
| geoip                  | 是否启用 fallback filter                                     |
| geoip-code             | 可选值为 国家缩写                                           |
| geosite                | 可选值为 geosite 内包含的集合                               |
| ipcidr                 | 书写内容为 IP/掩码                                          |
| domain                 | 这些域名被视为已污染，匹配到这些域名，会直接使用 fallback解析|

| 参数名称(策略组配置)             | 作用                                                       |
|--------------------|------------------------------------------------------------|
| name               | 策略组的名字                                               |
| type               | 策略组的类型                                               |
| proxies            | 引入代理节点或其他策略组                                    |
| url                | 健康检查测试地址                                           |
| interval           | 健康检查间隔，如不为 0 则启用定时测试，单位为秒            |
| lazy               | 懒惰状态，默认为true,未选择到当前策略组时，不进行测试      |
| timeout            | 健康检查超时时间，单位为毫秒                               |
| max-failed-times   | 最大失败次数，超过则触发一次强制健康检查                   |
| tolerance          | 节点切换容差，单位 ms                                      |

> 策略组是我们选择哪个网站选用什么方式连接的前置条件，简而言之就是给你的节点如何分流进行分组。


| 匹配方式(分流规则)             | 匹配内容                                                   | 举例                          |
|--------------------|------------------------------------------------------------|-------------------------------|
| DOMAIN             | 匹配完整域名                                               | ad.com                        |
| DOMAIN-SUFFIX      | 匹配域名后缀                                               | google.com                    |
| DOMAIN-KEYWORD     | 使用域名关键字匹配                                         | google                        |
| DOMAIN-REGEX       | 域名正则表达式匹配                                         | ^abc.*com                     |
| GEOSITE            | 匹配 Geosite 内的域名                                      | youtube                       |
| IP-CIDR/IP-CIDR6   | 匹配 IP 地址范围                                           | 127.0.0.0/8                   |
| IP-SUFFIX          | 匹配 IP 后缀范围                                           | 8.8.8.8/24                    |
| IP-ASN             | 匹配 IP 所属 ASN                                           | 13335                         |
| GEOIP              | 匹配 IP 所属国家代码                                       | CN                            |
| SRC-GEOIP          | 匹配来源 IP 所属国家代码                                   | cn                            |
| SRC-IP-ASN         | 匹配来源 IP 所属 ASN                                       | 9808                          |
| SRC-IP-CIDR        | 匹配来源 IP 地址范围                                       | 192.168.1.201/32              |
| SRC-IP-SUFFIX      | 匹配来源 IP 后缀范围                                       | 192.168.1.201/8               |
| DST-PORT           | 匹配请求目标端口范围                                       | 80                            |
| SRC-PORT           | 匹配请求来源端口范围                                       | 7777                          |
| IN-PORT            | 匹配入站端口,可用端口范围                                  | 7890                          |
| IN-TYPE            | 匹配入站类型                                               | SOCKS/HTTP                    |
| IN-USER            | 匹配入站用户名，支持使用 / 分隔多个用户名                  | linuxdo                       |
| IN-NAME            | 匹配入站名称                                               | ss                            |
| PROCESS-PATH       | 使用完整进程路径匹配                                       | D:\chrome.exe                 |
| PROCESS-PATH-REGEX | 使用进程路径正则表达式匹配                                 | *bin/wget                     |
| PROCESS-NAME       | 使用进程匹配，在Android平台可以匹配包名                    | chrome.exe                    |
| PROCESS-NAME-REGEX | 使用进程名称正则表达式匹配，在Android平台可以匹配包名      | curl$                         |
| UID                | 匹配 Linux USER ID                                         | 1001                          |
| NETWORK            | 匹配tcp或者udp                                             | udp                           |
| DSCP               | 匹配DSCP标记 (仅限 tproxy udp 入站)                        | 4                             |
| RULE-SET           | 引用规则集合，需配置rule-providers                         | providername                  |
| AND/OR/NOT         | 逻辑规则，需要注意括号的使用                               | ((DOMAIN,baidu.com),(NETWORK,UDP)) |
| SUB-RULE           | 匹配至子规则,需要注意括号的使用                            | (NETWORK,tcp)                 |
| MATCH              | 匹配所有请求，无需条件                                     |                               |

> 分流规则最终决定了哪个网站选用什么方式连接，通过不同的匹配策略自由地选择自己的分流规则。
> 
> 优先级按照从上到下的顺序匹配，上面的优先级高于下面。
