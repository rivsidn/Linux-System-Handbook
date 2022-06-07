* 代码下载

  ```bash
  git clone https://github.com/gnab/rtl8812au.git
  ```

* 软件编译

  ```bash
  make
  ```

* 模块安装

  ```bash
  insmod 8812au.ko
  ```

* 安装到模块位置

  ```bash
  sudo cp 8812au.ko /lib/modules/$(uname -r)/kernel/drivers/net/wireless
  ```

* 生成模块依赖文件

  ```bash
  sudo depmod
  ```

* 

