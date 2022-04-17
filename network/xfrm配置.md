

```bash
# 组网
# [LS:194.168.10.4] <===> [RS:1924.168.10.5]

#LS
#配置SA
ip xfrm state add src 194.168.10.4 dst 194.168.10.5 proto esp spi 0x00004005 mode tunnel auth md5 0xa87ff679a2f3e71d9181a67b7542122c enc des 0xa2f3e71d9181a67b
ip xfrm state add src 194.168.10.5 dst 194.168.10.4 proto esp spi 0x00005004 mode tunnel auth md5 0xa87ff679a2f3e71d9181a67b7542122c enc des 0xa2f3e71d9181a67b
#配置SP
ip xfrm policy add src 194.168.10.4 dst 194.168.10.5 dir out tmpl src 194.168.10.4 dst 194.168.10.5 proto esp mode tunnel
ip xfrm policy add src 194.168.10.5 dst 194.168.10.4 dir in tmpl src 194.168.10.5 dst 194.168.10.4 proto esp mode tunnel


#RS
#配置SA
ip xfrm state add src 194.168.10.4 dst 194.168.10.5 proto esp spi 0x00004005 mode tunnel auth md5 0xa87ff679a2f3e71d9181a67b7542122c enc des 0xa2f3e71d9181a67b
ip xfrm state add src 194.168.10.5 dst 194.168.10.4 proto esp spi 0x00005004 mode tunnel auth md5 0xa87ff679a2f3e71d9181a67b7542122c enc des 0xa2f3e71d9181a67b
#配置SP
ip xfrm policy add src 194.168.10.4 dst 194.168.10.5 dir in tmpl src 194.168.10.4 dst 194.168.10.5 proto esp mode tunnel
ip xfrm policy add src 194.168.10.5 dst 194.168.10.4 dir out tmpl src 194.168.10.5 dst 194.168.10.4 proto esp mode tunnel
```







## 附录

### 术语解释

| 术语缩写 | 解释                 |
| -------- | -------------------- |
| SA       | Security Association |
| SP       | Security Policy      |
| SPI      |                      |



### 参考资料

* [用ip xfrm搭ipsec隧道](https://www.cnblogs.com/4a8a08f09d37b73795649038408b5f33/p/11959104.html)