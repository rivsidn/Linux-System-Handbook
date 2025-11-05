
**当前QEMU 命令不支持vde模式，以下命令未验证.**

```bash
# 工具安装
sudo apt install vde2
```

```bash
# 创建虚拟交换机
vde_switch -s /tmp/vde.ctl -daemon
```

```bash
# VM1
qemu-system-x86_64 -drive file=disk1.img,format=raw \
    -net nic \
    -net vde,sock=/tmp/vde.ctl \
    -m 1G
```


```bash
# VM2
qemu-system-x86_64 -drive file=disk2.img,format=raw \
    -net nic \
    -net vde,sock=/tmp/vde.ctl \
    -m 1G
```

```bash
# 添加宿主机到虚拟交换机
sudo vde_tap -s /tmp/vde.ctl tap0
sudo ip addr add 192.168.100.1/24 dev tap0
sudo ip link set tap0 up
```


```bash
# 可以同时创建多个虚拟交换机
vde_switch -s /tmp/vde-net1.ctl -daemon
vde_switch -s /tmp/vde-net2.ctl -daemon
```

