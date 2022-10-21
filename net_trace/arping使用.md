### 功能

向邻居设备发送ARP请求。

### 语法

```bash
arping  [-AbDfhqUV]  [-c count] [-w deadline] [-s source] [-I interface] destination
```

### 选项解释

| 选项         | 解释                        |
| ------------ | --------------------------- |
| -A           | **TODO**                    |
| -b           | 发送MAC地址广播模式         |
| -c count     | 发送ARP请求的报文数         |
| -D           | 重复地址检测模式            |
| -f           | 收到reply确认地址存在后停止 |
| -I interface | 指定发送的接口名称          |
| -h           | 输出帮助信息                |
| -q           | 安静模式，不显示任何信息    |
| -s source    | ARP报文中使用的源IP地址     |
| -U           | **TODO**                    |
| -V           | 输出程序版本信息            |
| -w deadline  | 指定超时时间，单位为秒      |

