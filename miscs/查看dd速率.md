

```bash
sudo apt-get install pv
```

```bash
# 开启缓存的时候可能导致显示异常，此时需要关闭缓存
sudo dd if=/dev/sdb bs=4M | pv -s 10G | sudo dd of=/dev/sdba bs=4M

# 可以通过自带的statur=progress 选项来查看写入状态
sudo dd if=diskimage@xeon-211208.img of=/dev/sdb bs=1M iflag=nocache oflag=nocache status=progress
```

将bs 调大会提高写入速度
