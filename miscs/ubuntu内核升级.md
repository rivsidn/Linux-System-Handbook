* 检查当前内核版本

  ```bash
  uname -r
  ```

* 下载内核版本更新脚本

  ```bash
  wget https://raw.githubusercontent.com/pimlie/ubuntu-mainline-kernel.sh/master/ubuntu-mainline-kernel.sh
  ```

* 脚本安装

  ```bash
  sudo install ubuntu-mainline-kernel.sh /usr/sbin/
  ```

* 更新内核

  ```bash
  # 显示当前可用内核版本
  sudo ubuntu-mainline-kernel.sh -r
  # 更新到指定版本
  sudo ubuntu-mainline-kernel.sh -i [version]
  ```

  其他选项可以通过 `-h` 查看。

  

* 重启系统，检查内核版本

  ```bash
  uname -r
  ```



## 附录

### 参考资料

* [Install ort Upgrade To Latest Linux Kernel on Ubuntu 20.04](https://linuxhint.com/install-upgrade-linux-kernel-ubuntu-linux-mint/)

