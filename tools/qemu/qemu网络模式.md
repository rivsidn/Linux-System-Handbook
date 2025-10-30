

## 用户模式

虚拟机访问外部网络.


## 桥接模式

### 核心原理

虚拟机启动的时候创建tap 网卡，将tap 网卡添加到网桥中.

虚拟机发送的报文会通过tap 网卡到达网桥中，从而实现与宿主机、外部通信的目的.

### 应用场景

- 用于与宿主机通信
- 可以通过NAT 与外部通信

### 配置实例

#### 网桥配置

```bash
sudo ip link add br0 type bridge
sudo ip addr add 172.20.0.1/24 dev br0
sudo ip link set br0 up
```

#### 虚拟机启动

```bash
sudo qemu-system-x86_64 /opt/fw_images/vpn-19985.img -nographic \
    -netdev tap,id=net0,script=/etc/kdev-qemu-ifup,downscript=/etc/kdev-qemu-ifdown \
    -device e1000,netdev=net0 \
    -m 4G
```

##### 启动脚本

```bash
##!/bin/sh

ip link set $1 up
ip link set $1 master br0
```

##### 关闭脚本

```bash
##!/bin/sh

ip link set $1 nomaster
ip link set $1 down
```

## MACVTAP



