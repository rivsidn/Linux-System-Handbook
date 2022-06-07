

1 /etc/default/grub
Change /etc/default/grub as below.

Change GRUB terminal to console and ttyS0. This will provide one GRUB to a monitor display and serial console.
Change linux kernel console to tty1 and ttyS0. This setting will be taken over to userland, and there will be two login prompt for tty1 and ttyS0.
$ cat <<EOF | sudo tee /etc/default/grub
GRUB_DEFAULT=0
GRUB_TIMEOUT=1
GRUB_DISTRIBUTOR=\`lsb_release -i -s 2> /dev/null || echo Debian\`
GRUB_CMDLINE_LINUX_DEFAULT=""
GRUB_CMDLINE_LINUX="console=tty1 console=ttyS0,115200"
GRUB_TERMINAL="console serial"
GRUB_SERIAL_COMMAND="serial --speed=115200 --unit=0 --word=8 --parity=no --stop=1"
EOF
2 grub-mkconfig
Update /boot/grub/grub.cfg with grub-mkconfig.

$ sudo grub-mkconfig -o /boot/grub/grub.cfg
Reboot system.

$ sudo reboot


## 附录

### 参考资料

* [Ubuntu 18.04: GRUB2 and linux with serial console](https://www.hiroom2.com/2018/04/30/ubuntu-1804-serial-console-en/)


**这里设置的tty1、tty0有什么区别？**
