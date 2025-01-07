

```bash
# 读取pcap 文件，输出源IP、目的IP、协议号
# 可以作为输入， 重定向到脚本中进一步解析
tshark -r <pcap_file> -T fields -e ip.src -e ip.dst -e ip.proto

```



| 选项             | 说明         |
| ---------------- | ------------ |
| -r \<pcap file\> | 指定读取文件 |
| -T \<格式\>      | 指定输出格式 |
| -e \<fileds\>    | 指定输出区域 |

