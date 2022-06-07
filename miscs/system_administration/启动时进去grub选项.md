

ubuntu 18.04, 进入到`/etc/default/grub`，设置.

```bash
GRUB_TIMEOUT=3
GRUB_TIMEOUT_STYLE=
```

更新grub。

```bash
sudo update-grub
```


**通过上述方式在串口下不生效，只能手动改default文件了**

## 附录

* [How to get to the GRUB menu at boot-time](https://askubuntu.com/questions/16042/how-to-get-to-the-grub-menu-at-boot-time)
* [How to list GRUB's “menuentries” in command-line?](https://askubuntu.com/questions/599208/how-to-list-grubs-menuentries-in-command-line)

