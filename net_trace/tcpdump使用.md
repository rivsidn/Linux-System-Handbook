## 循环抓包

### 相关参数

| 参数 | 说明                                                         |
| ---- | ------------------------------------------------------------ |
| -w   | 指定文件名                                                   |
| -W   | 指定文件个数                                                 |
| -C   | 指定文件大小，达到某一大小之后文件循环(单位为M)              |
| -G   | 指定循环时间(单位为秒)                                       |
| -Z   | 以root运行时，默认修改用户、用户组为`tcpdump`，可以通过 -Z root <br />去掉 |



### 使用示例

```bash
# 文件达到2M之后循环，最多保存个2文件，-K 不需要验证校验和 -n 不需要将IP显示为域名
sudo tcpdump -i eth0 -w trace -W 2 -C 2 -Z root -K -n

# 文件达到100M或者时间1800s之后循环，最多保存48个文件
sudo tcpdump -i eth0 -w /var/tmp/trace -W 48 -G 1800 -C 100 -K -n


/usr/sbin/tcpdump -i eth0 -w eth0_trace -W 3 -C 10 -K -n -p &
/usr/sbin/tcpdump -i eth1 -w eth1_trace -W 3 -C 10 -K -n -p &


```

