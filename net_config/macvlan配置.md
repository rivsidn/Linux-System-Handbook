## 模式

| 模式          | 解释                                                         |
| ------------- | ------------------------------------------------------------ |
| private       | 相同物理口的虚设备之间不允许通信                             |
| vepa(default) | 虚拟以太网端口聚合模式，同一物理口下的聚合口之间通信必须要经过外部设备转发；<br />相当于一个设备配置出多个物理设备。 |
| bridge        | 桥设备下，所有虚设备在一个桥内，不需要用经过外部设备就可以通信 |
| passthru      | 同一个物理口下只允许设置一个，所有的流量都会转发到该设备     |
| source        | 允许根基源mac地址接收报文                                    |

`macvlan` 总共有五种模式，分别有不同的转发策略。



## 配置命令

```bash
# 添加
ip link add link <DEVICE> dev <name> type macvlan mode <mode>
# 删除
ip link del link <DEVICE> dev <name> type macvlan
# 查看所有
ip link show type macvlan
# 查看单个设备
ip link show <name>

# 其他相关配置命令
# 接口up
ip link set <name> up
```

**DEVICE** ： 表示物理设备

**NAME**：表示虚拟设备名



## 配置示例(一)

设备上`eth1` 上配置一个`macvlan` 虚接口，模式默认，外部`ping` 这个虚接口`IP`。

```bash
# 添加macvlan设备
ip link add link eth1 dev eth1_macvlan type macvlan
# up该设备
ip link set eth1_macvlan up
# 配置ip地址
ip addr add 172.31.3.137/24 dev eth1_macvlan
```



## 配置示例(二)

**当前没配置成功， 需要进一步去看。**

```bash
ip link add link eth5 dev mac1 type macvlan mode bridge
ip link add link eth5 dev mac2 type macvlan mode bridge

ip netns add ns1
ip netns add ns2

ip link set mac1 netns ns1
ip link set mac2 netns ns2

ip netns exec ns1 ip addr add 192.168.56.122/24 dev mac1
ip netns exec ns1 ip link set mac1 up

ip netns exec ns2 ip addr add 192.168.56.123/24 dev mac2
ip netns exec ns2 ip link set mac2 up

```





## 附录

### 参考资料

* [Linux云网络基础之网卡虚拟化技术macvlan详解](https://ctimbai.github.io/2019/04/01/tech/net/vnet/linux-macvlan/)



