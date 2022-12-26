## 组网环境

```bash
+---------------+              +---------------+
|       A       |              |       B       |
| 172.31.3.136  +--------------+ 172.31.3.138  |
|               |              |               |
+---------------+              +---------------+
```



## 配置

### 设备A配置

```bash
# SA配置
## 去方向 {方向 | 协议类型 | SPI | 模式 | 加密算法}
ip xfrm state add src 172.31.3.136 dst 172.31.3.138 proto esp spi 0x00000301 mode tunnel auth md5 0x8896ab8654cd9875e214a978bd31209f enc des3_ede 0xea89273861739abc9e0d527ad98462108365289dcb1a6738
## 回方向
ip xfrm state add src 172.31.3.138 dst 172.31.3.136 proto esp spi 0x00000302 mode tunnel auth md5 0x8ab2639471536c8d92a0e82618e92ac7 enc des3_ede 0xec91728a907c6d526178493027139dce56473926ac947289

# 安全策略配置
ip xfrm policy add src 172.31.3.136 dst 172.31.3.138 dir out ptype main tmpl src 172.31.3.136 dst 172.31.3.138 proto esp mode tunnel
ip xfrm policy add src 172.31.3.138 dst 172.31.3.136 dir in ptype main tmpl src 172.31.3.138 dst 172.31.3.136 proto esp mode tunnel
```



### 设备B配置

```bash
# SA配置
sudo ip xfrm state add src 172.31.3.136 dst 172.31.3.138 proto esp spi 0x00000301 mode tunnel auth md5 0x8896ab8654cd9875e214a978bd31209f enc des3_ede 0xea89273861739abc9e0d527ad98462108365289dcb1a6738
sudo ip xfrm state add src 172.31.3.138 dst 172.31.3.136 proto esp spi 0x00000302 mode tunnel auth md5 0x8ab2639471536c8d92a0e82618e92ac7 enc des3_ede 0xec91728a907c6d526178493027139dce56473926ac947289

# 安全策略配置
sudo ip xfrm policy add src 172.31.3.136 dst 172.31.3.138 dir in ptype main tmpl src 172.31.3.136 dst 172.31.3.138 proto esp mode tunnel
sudo ip xfrm policy add src 172.31.3.138 dst 172.31.3.136 dir out ptype main tmpl src 172.31.3.138 dst 172.31.3.136 proto esp mode tunnel
```



### 配置查看

```bash
# SA查看
sudo ip xfrm state ls
# 安全策略查看
sudo ip xfrm policy ls
```



## 附录

### 参考资料

* [IPSec手动创建隧道](https://blog.csdn.net/sinat_20184565/article/details/90415139)

