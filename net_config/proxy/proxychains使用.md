## 安装

```bash
sudo apt-get install proxychains
```



## 配置

配置文件为 `etc/proxychains.conf` 添加配置如下

>  socks5 	127.0.0.1 1080

其中端口号参照自己配置修改即可。



## 验证

```bash
## 直接访问无法正常访问google
$ wget www.google.com 
--2021-12-22 11:11:58--  http://www.google.com/
Resolving www.google.com (www.google.com)... 115.126.100.160, 2001::c760:3f35
Connecting to www.google.com (www.google.com)|115.126.100.160|:80... 

## 通过代理可以正常访问google
$ proxychains wget www.google.com 
ProxyChains-3.1 (http://proxychains.sf.net)
--2021-12-22 11:11:31--  http://www.google.com/
Resolving www.google.com (www.google.com)... |DNS-request| www.google.com 
|S-chain|-<>-127.0.0.1:1080-<><>-4.2.2.2:53-<><>-OK
|DNS-response| www.google.com is 142.250.217.132
142.250.217.132
Connecting to www.google.com (www.google.com)|142.250.217.132|:80... |S-chain|-<>-127.0.0.1:1080-<><>-142.250.217.132:80-<><>-OK
connected.
HTTP request sent, awaiting response... 200 OK
Length: unspecified [text/html]
Saving to: ‘index.html’

index.html                 [ <=>                        ]  14.91K  --.-KB/s    in 0.01s   

2021-12-22 11:11:33 (1.50 MB/s) - ‘index.html’ saved [15264]
```

