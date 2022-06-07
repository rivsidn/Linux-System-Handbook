## 服务器配置

### 软件安装

```bash
sudo apt-get install nfs-kernel-server
```

### 配置

向`/etc/exports` 中写入：

```bash
#  *	允许所有IP地址访问
# rw	读写权限
# sync	数据同步写入内存和硬盘
# NFS	服务器共享目录用户的属性
/home/rivsidn/gitHub *(rw,sync,no_root_squash)
```

### 重启服务

```bash
sudo /etc/init.d/nfs-kernel-server restart
```



## 客户端挂载NFS文件系统

### Linux

```bash
sudo apt-get install nfs-common
sudo mount -t nfs <ipAddress>:/home/rivsidn/gitHub /home/AAA/file
```

### Windows

1. 使能nfs windows功能

   计算机 - 控制面板 - 程序和功能 - 打开或关闭Windows功能 - NFS服务

2. 挂载

   ```bash
   # 挂载命令，将文件夹挂载到一个未使用的盘符
   mount <ipAddress>:/home/rivsidn/gitHub H:
   ```
3. 显示挂载项
   ```bash
   showmount -e IP
   ```
4. 解决只读问题
   修改注册表
   
   ```
   HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\ClientForNFS\Current\Version\Default
   
   鼠标右键，QWORD(64)值，增加两项: AnonymousUid, AnonymousGid
   ```
   
   **注意：目前没能解决只读的问题，windows下挂载使用的不多。**



## 参考资料

* [两台ubuntu共享文件](https://blog.csdn.net/yuan13091324/article/details/39205919)
* [Windows7挂载NFS服务](https://blog.csdn.net/xy_kok/article/details/78475455)

