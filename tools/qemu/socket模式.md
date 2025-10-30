

## socket

### 核心原理

### 配置实例

```bash
# 服务器
qemu-system-x86_64 /opt/fw_images/vpn-19985-server.img \
    -nic socket,model=virtio,listen=localhost:4444 \
    -m 4G -nographic

# 客户端
qemu-system-x86_64 /opt/fw_images/vpn-19985-client.img \
    -nic socket,model=virtio,connect=localhost:4444 \
    -m 4G -nographic

```



### VDE交换机



