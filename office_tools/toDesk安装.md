

### 安装

官网下载，下载地址参见[参考资料](#参考资料)

```bash
sudo dpkg -i todesk_4.1.0_amd64.deb
```

### 关闭开机自启动

* 关闭`systemctl`启动

  ```bash
  sudo systemctl disable todeskd.service
  ```

* 禁止`GUI`程序自启动

  * 按`Alt+F2`，输入`gnome-session-properties`，然后回车
  * 在`启动应用程序首选项`中，删除`todesk`程序

### 使用

```bash
sudo systemctl start todeskd.service
sudo todesk
```




### 参考资料

* [toDesk官网linux下载](http://todesk.com/linux.html)

