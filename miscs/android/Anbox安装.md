初衷是在本地电脑上安装不常用的app，比如京东、当当、天猫等，结果是虚拟机可以正常安装，但是app不支持X86，于是放弃。



## 安装步骤

### 安装模块

```bash
$ sudo add-apt-repository ppa:morphis/anbox-support
$ sudo apt update
$ sudo apt install linux-headers-generic anbox-modules-dkms
```



解决模块不能编译通过问题。

> https://github.com/anbox/anbox-modules/issues/21#issuecomment-529236886)
>
> https://github.com/anbox/anbox-modules/commit/ae35b8da224b7ba163ebc1b3cf94acc2b0da260b#diff-9aa03907fd998dd9f406ebf8061dd34d



### 安装anbox

```bash
sudo apt-get install snapd
snap install --devmode --beta anbox
```



### 安装adb

```bash
sudo apt-get install android-tools-adb
```



### 安装软件

```bash
adb install <app_name>.apk
```



由于软件版本不支持x86，安装失败。



## 参考资料

* [安装anbox](https://docs.anbox.io/userguide/install.html)
* [ubuntu 安装snap](https://snapcraft.io/docs/installing-snap-on-ubuntu)
* [安装内核模块](https://docs.anbox.io/userguide/install_kernel_modules.html)
* [解决anbox模块编译不通过问题](https://github.com/anbox/anbox-modules/issues/21#issuecomment-529236886)
* [anbox上安装app](https://www.reallinuxuser.com/how-to-run-android-apps-in-linux-mint-with-anbox/)

