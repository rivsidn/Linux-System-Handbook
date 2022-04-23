`DPT-RP1` 是一款索尼的电子纸，该电子纸只能通过官方的APP 向设备内传文档，官方并没有提供LINUX 版本的APP，幸运的是从github 上找到的一个脚本能够在LINUX下完成该任务。

**注意：** 该工具并不支持LINUX下通过串口访问设备。
**注意：** 目前用的版本好像之支持python2，切换到python3会报错。



## 命令安装

```bash
sudo pip3 install dpt-rp1-py
```



## 连接设备

* 设备开启wifi 接入，电脑链接设备wifi

* 执行注册，输入PIN 码

  ```bash
  dptrp1 register
  ```

* 成功注册之后即可以开始使用



## 命令使用

* 查看目录

  ```bash
  dptrp1 --addr 192.168.43.1 list-folders
  ```

* 目录删除

  ```bash
  dptrp1 --addr 192.168.43.1 delete-folder <folder-name>
  ```

* 目录创建

  ```bash
  dptrp1 --addr 192.168.43.1 new-folder <folder-name>
  ```

* 查看文件

  ```bash
  dptrp1 --addr 192.168.43.1 list-documents
  ```

* 文件上传

  ```bash
  dptrp1 --addr 192.168.43.1 upload <local-file> <folder-path>
  ```

* 文件下载

  ```bash
  dptrp1 --addr 192.168.43.1 download <file-name> <local-path>
  ```

* 文件移动

  ```bash
  dptrp1 --addr 192.168.43.1 move-document <file-name> <folder-name>
  ```

* 文件删除

  ```bash
  dptrp1 --addr 192.168.43.1 delete <file-name>
  ```

  

## 附录

* [dpt-rp1 github 地址](https://github.com/janten/dpt-rp1-py)



