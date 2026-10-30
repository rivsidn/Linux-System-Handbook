
tc(traffic control) 流量控制.

## Qdisc

qdisc(queueing discipline) 报文队列规则.

| 名称     | 功能                     |
|----------|--------------------------|
| pfifo    | 简单先进先出队列         |
| fq_codel | 按流公平排队并控制延迟   |
| netem    | 模拟延迟、丢包、抖动     |
| tbf      | 简单限速                 |
| htb      | 分层带宽控制(支持 class) |

## class

| class 类型 | 所属 qdisc | 主要用途                                 |
|------------|------------|------------------------------------------|
| htb        | htb        | 常用带宽分级、保证速率和借用空闲带宽     |
| hfsc       | hfsc       | 同时约束实时性、链路共享和最大速率       |
| cbq        | cbq        | 较早的分级带宽控制机制                   |
| drr        | drr        | 按 class 做 deficit round robin 公平调度 |

一个qdisc 只能管理它自己的class 类型，不能混用.

## filter

| 类型     | 主要用途                                     | 适合场景                               |
|----------|----------------------------------------------|----------------------------------------|
| flower   | 按协议、IP、端口、MAC、VLAN、DSCP 等字段匹配 | 新配置优先使用                         |
| u32      | 按报文头固定偏移和掩码匹配                   | 旧脚本、复杂的低层匹配                 |
| bpf      | 运行 eBPF 程序决定分类或直接执行action       | 复杂、自定义的匹配逻辑                 |
| matchall | 匹配所有报文                                 | 将全部流量执行某个 action              |
| fw       | 根据 skb mark 匹配                           | iptables/nftables 先打标，再由 tc 分类 |
| basic    | 通用分类器，常配合 ematch                    | 较少用于新配置                         |

## 示例

### 示例一 - pfifo 添加

```bash
tc qdisc add dev eth0 root pfifo limit 100
```

### 示例二 - htb 添加(多级class)

```bash

# eth0
# └─ HTB qdisc 1:
#    └─ class 1:10，100 Mbit
#       └─ HTB qdisc 10:
#          └─ class 10:1，10 Mbit
#             └─ pfifo qdisc 100:

# Root
tc qdisc add dev eth0 root handle 1: htb default 10

# Level-1
tc class add dev eth0 parent 1: classid 1:10 htb rate 100mbit ceil 100mbit
tc qdisc add dev eth0 parent 1:10 handle 10: htb default 1

# Level-2
tc class add dev eth0 parent 10: classid 10:1 htb rate 10mbit ceil 10mbit
tc qdisc add dev eth0 parent 10:1 handle 100: pfifo limit 100
```

如图所示，这里的 qdisc 和 class 形成了铰链般的层级关系.

qdisc[1:] -> class[1:10] -> qdisc[10:] -> class[10:1] -> qdisc[100:]

Qdisc 使用 major: 作为ID，是唯一的; class 使用 major:minor 作为ID .


### 示例三 - htb 添加(多个class)

```
# eth0
# └─ HTB qdisc 1:
#    ├─ class 1:10，10 Mbit
#    │  └─ fq_codel
#    └─ class 1:20，2 Mbit
#       └─ pfifo

# 根 HTB；未匹配流量默认进入 1:10
sudo tc qdisc replace dev eth0 root handle 1: htb default 10

# 两个 class
sudo tc class replace dev eth0 parent 1: classid 1:10 htb rate 10mbit ceil 10mbit
sudo tc class replace dev eth0 parent 1: classid 1:20 htb rate 2mbit ceil 2mbit

# 每个 class 下只有一个子 qdisc
sudo tc qdisc replace dev eth0 parent 1:10 handle 10: fq_codel
sudo tc qdisc replace dev eth0 parent 1:20 handle 20: pfifo limit 100

# 让 UDP/53（DNS）流量走 class 1:20
sudo tc filter add dev eth0 parent 1: protocol ip flower ip_proto udp dst_port 53 flowid 1:20
```

注意，一个class 下不可以绑定多个qdisc，只能绑定一个。


### 示例四 - filter 使用

```bash
# eth0
# └─ HTB qdisc 1:
#    ├─ class 1:10：默认流量，10 Mbit
#    └─ class 1:20：TCP/443， 20 Mbit

# Root
tc qdisc replace dev eth0 root handle 1: htb default 10

# class(htb)
tc class add dev eth0 parent 1: classid 1:10 htb rate 10mbit ceil 10mbit
tc class add dev eth0 parent 1: classid 1:20 htb rate 20mbit ceil 20mbit

# filter
tc filter add dev eth0 parent 1: protocol ip flower ip_proto tcp dst_port 443 flowid 1:20
```

一个HTB 创建了多个class，默认走 class 1:10，TCP/443 的流量走class 1:20.
