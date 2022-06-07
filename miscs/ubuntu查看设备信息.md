* 查看硬盘序列号

  ```bash
  hdparm -i /dev/sda
  ```

  

* 查看操作系统安装日期

  ```bash
  dumpe2fs /dev/sda1 | grep 'Filesystem created'
  ```

  

* 查看IP，mac地址

  ```bash
  ifconfig <dev>
  ```

  

* 

