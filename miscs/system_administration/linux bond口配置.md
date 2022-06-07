```bash
# 添加bond口，模式默认
ip link add <bond_name> type bond mode balance-rr

# bond口中添加物理口，需要提前将物理口down掉
ip link set <eth_name> master <bond_name>

# 显示bond口信息
ip -detail link show type bond

# 显示添加的物理口信息
ip link show type bond_slave

# bond中移除物理口
ip link set <eth_name> nomaster

```



## ARM 配置

```bash
ifconfig eth2 down
ifconfig eth3 down
ip link set eth2 master bond2
ip link set eth3 master bond2
ifconfig eth2 up
ifconfig eth3 up
```












