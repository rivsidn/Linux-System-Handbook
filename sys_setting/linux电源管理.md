## 电源管理模式

linux 电源管理支持如下四种状态，从上到下，耗电量降低，唤醒延迟增大。

| ACPI 状态 | 状态                       | 标签                  | state   | mem_sleep |
| --------- | -------------------------- | --------------------- | ------- | --------- |
| S0        | Suspend-To-Idle            | "s2idle" ("freeze")   | freeze  | s2idle    |
| S1        | Standby / Power-On Suspend | "shallow" ("standby") | standby | shallow   |
| S3        | Suspend-to-RAM             | "deep"                | <mem>   | deep      |
| S4        | Suspend-to-disk            | "disk"                | disk    |           |



进入某种挂起模式可以通过设置`/sys/power/` 下的 `state`，`mem_sleep` 来实现，其中`S0`、`S1`可以以两种方式设置，以`S0` 为例：

* 直接将`freeze` 写入`/sys/power/state`
* 写入`s2idle` 到`mem_sleep`，写入`mem` 到`state`

`S3` 、`S4` 只可以以一种方式设置，不再举例。



## 设置S4模式

### 创建swap文件

```bash
sudo swapoff /swapfile
# 此处的8g 必须大于内存大小
sudo fallocate -l 8g /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
```

```bash
$ sudo findmnt -no UUID -T /swapfile
20562a02-cfa6-42e0-bb9f-5e936ea763d0
```

记住此处的UUID，之后会用到。

### 配置安装 uswsusp

```bash
sudo apt install uswsusp
sudo dpkg-reconfigure -pmedium uswsusp
# Answer "Yes" to continue without swap space
# Select "/dev/disk/by-uuid/20562a02-cfa6-42e0-bb9f-5e936ea763d0" replace the UUID with the result from the previous findmnt command
# Encrypt: "No"
```

### 配置hibernate服务

```bash
sudo systemctl edit systemd-hibernate.service

#[Service]
#ExecStart=
#ExecStartPre=-/bin/run-parts -v -a pre /lib/systemd/system-sleep
#ExecStart=/usr/sbin/s2disk
#ExecStartPost=-/bin/run-parts -v --reverse -a post /lib/systemd/system-sleep
```

### 配置grub

```bash
sudo swap-offset /swapfile
# resume offset = 34818
# 编辑/etc/default/grub，添加如下:
# GRUB_CMDLINE_LINUX_DEFAULT="resume=UUID=20562a02-cfa6-42e0-bb9f-5e936ea763d0 resume_offset=34818 quiet splash"
sudo update-grub
```

### 更新initramfs

```bash
# 创建文件 /etc/initramfs-tools/conf.d/resume，内容如下:
# RESUME=UUID=20562a02-cfa6-42e0-bb9e-5e936ea763d0 resume_offset=34816

sudo update-initramfs -u -k all
```

### 设备挂起

```bash
sudo systemctl hibernate
```



## TODO

* [Long boot time of Kali Linux after swap partition changes – swap settings for the initramfs](https://linux-blog.anracom.com/2020/11/15/long-boot-time-of-kali-linux-after-swap-partition-changes-swap-settings-for-the-initramfs/)



## 附录

* [System Power Management Sleep States](https://www.kernel.org/doc/Documentation/power/states.txt)

* [Hibernate and resume from a swap file](https://askubuntu.com/questions/6769/hibernate-and-resume-from-a-swap-file)

