## 工具汇总

| 工具           | 用途                                                         |
| -------------- | ------------------------------------------------------------ |
| tcpprep        | 预处理报文                                                   |
| tcprewrite     | 改写报文                                                     |
| tcpreplay      | 回放报文                                                     |
| tcpbridge      | 监听网络接口流量并将其桥转发到另一接口                       |
| tcpliveplay    | 现实应用场景中回放报文，只能回放TCP 报文，详情参见 [tcpliveplay](https://tcpreplay.appneta.com/wiki/tcpliveplay.html) |
| tcpcapinfo     | 用于诊断报文(查看tcprewrite 之后的报文是否正常)，详情参见 [tcpcapinfo](https://tcpreplay.appneta.com/wiki/tcpcapinfo.html) |
| tcpreplay-edit | 可以理解成是tcpwrite，tcpreplay 的集合体，修改报文会影响性能，不建议直接使用。详情参见 [tcpreplay-edit](https://tcpreplay.appneta.com/wiki/tcpreplay-edit) |



## 示例一

修改`IPv6`报文源 IP 地址，并回放。

```bash
# 修改源IP地址
tcprewrite --srcipmap=[12::8/128]:[12::22/128] --infile=udp_8.pcap --outfile=udp_22.pcap
# 报文回放
sudo tcpreplay --loop=2 --intf1="enp1s0" udp_22.pcap
```









## 参考资料

* [tcpreplay-edit](https://tcpreplay.appneta.com/wiki/tcpreplay-edit)





