

## v2ray使用

### 安装

```bash
# sudo apt install v2ray
```



### 修改配置文件

配置文件位于 `/etc/v2ray/config.json`，从其他客户端导出配置，写入即可。



### 启动

```bash
# 启动
sudo service v2ray start
# 查看状态
sudo service v2ray status
# 设置开机启动
sudo systemctl enable v2ray
```



启动之后，配置浏览器代理即可。



## 附录

### 参考资料

* [fhs-install-v2ray](#https://github.com/v2fly/fhs-install-v2ray)

