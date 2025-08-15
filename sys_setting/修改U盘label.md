
格式化的U盘自动挂载之后，挂载点通常为一串 UUID.

如下:

```bash
$ df
Filesystem     1K-blocks      Used Available Use% Mounted on
/dev/sda1      960301296  20064088 891382824   3% /media/yuchao/b64099a1-d0b4-474a-a520-3418fae62057
```

如果希望显示成字符串的形式，需要修改USB的label.

```bash
$ df
Filesystem     1K-blocks      Used Available Use% Mounted on
/dev/sda1      960301296  20064088 891382824   3% /media/yuchao/SSD0-ext4
```


## 修改label

### exfat修改label

```bash
sudo umount /dev/sda

# 设置label(最多11个字符)
sudo exfatlabel /dev/sda "MyUSB"
```

### ext4修改label

```bash
sudo umount /dev/sda1

# 设置label(最多16个字符)
sudo e2label /dev/sda1 MyDisk
```

## 查看磁盘label

```bash
$ sudo blkid /dev/sda1
/dev/sda1: LABEL="SSD0-ext4" UUID="b64099a1-d0b4-474a-a520-3418fae62057" BLOCK_SIZE="4096" TYPE="ext4" PARTUUID="8796a7ee-01"
```

