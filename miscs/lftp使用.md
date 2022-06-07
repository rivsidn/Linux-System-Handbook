linux 下 `ftp` 访问 windows 服务器会出现中文乱码问题，可以通过安装 `lftp` 解决。



### 安装

```bash
sudo apt-get install lftp
```



### 登录

```bash
lftp ftp://<username>:<password>@<address>
```



### 修改编码方式

```bash
set ftp:charset "gbk"
set file:charset "utf-8"

# 如果出现 Fatal error:Certificate verification:Not trusted
set ssl:verify-certificate no
```

**Tips：可以通过讲上边内容加入倒 ~/.lftprc 或/ect/lftp.conf 文件中，以后不需要手动添加。**
**Tips：出现了登录后手动修改不生效的问题，添加到文件中生效。**



## 参考资料

* [linux下访问windows ftp服务器出现乱码问题解决方案](https://blog.51cto.com/aaron521/2096602)
