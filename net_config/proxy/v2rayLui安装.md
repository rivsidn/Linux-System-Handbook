`v2ray_all.tar.gz` 中包含如下文件，安装之前可以前往 github 搜索`v2rayL` 查看是否有更新。 

* files.tar
* images-v2.0.2.tar
* v2ray-core.tar
* v2rayLui-v2.1.3.zip



## 安装

解压`v2rayLui-v2.1.3.zip` ，查看`install.sh` 文件。

正常情况下，执行该脚本可以完成软件安装。

文件执行的动作就是简单的，下载文件，解压文件，将文件放到正确位置，添加可执行权限等。目前安装碰到的问题是，执行该脚本时，文件下载不下来，我们可以参照该脚本，手动下载文件，完成软件安装。

需要设置桌面图标可执行文件路径，确保指向正确的可执行文件。

**注意：安装之后，重启生效**



## 执行

* 添加订阅，更新订阅
* 测试延迟查看是否生效



## 疑问

* 直接执行该命令，会报错，图形界面可用

  ```
  [sudo] password for yuchao: 
  Traceback (most recent call last):
    File "utils.py", line 74, in qt_message_handler
  ValueError: not enough values to unpack (expected 2, got 1)
  Aborted
  ```





