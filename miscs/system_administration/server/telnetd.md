```bash
# 安装
sudo apt-get install openbsd-inetd 

sudo apt-get install telnetd 

# 重启服务
/etc/init.d/openbsd-inetd restart

# 查看telnet 是否启动
netstat -a | grep telnet

```


```bash
# 登录，按照提示输入用户名密码

telnet 127.0.0.1

```


