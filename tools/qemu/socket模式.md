

## 核心原理

## 配置实例

### TCP socket(旧语法)

```bash
# 服务器
qemu-system-x86_64 /opt/images/vpn-19985-server.img \
    -net nic -net socket,listen=localhost:4444 \
    -m 4G -nographic

# 客户端
qemu-system-x86_64 /opt/images/vpn-19985-client.img \
    -net nic -net socket,connect=localhost:4444 \
    -m 4G -nographic
```

### TCP socket(新语法)

```bash
# 服务器
qemu-system-x86_64 /opt/images/vpn-19985-server.img \
    -netdev socket,id=net0,listen=localhost:4444 \
    -device e1000,netdev=net0 \
    -m 4G -nographic

# 客户端
qemu-system-x86_64 /opt/images/vpn-19985-client.img \
    -netdev socket,id=net0,connect=localhost:4444 \
    -device e1000,netdev=net0 \
    -m 4G -nographic
```

### Unix socket

当前版本不支持，暂无实例.


