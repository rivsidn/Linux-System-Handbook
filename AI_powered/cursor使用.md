## 安装

* 下载最新版本到本地，[下载地址](#https://www.cursor.com/downloads)。

  进入下载目录之后，由于字体、背景均为黑色看不清楚，可以通过`Ctrl+a`选中所有，查看页面文字。

  此处下载最新版程序。

* 解压并拷贝到根目录

  ```bash
  # 添加可执行权限
  chmod 0777 Cursor-0.48.9-x86_64.AppImage
  # 提取内容到本地
  ./Cursor-0.48.9-x86_64.AppImage --appimage-extract
  # 将内容拷贝到对应目录
  sudo cp squashfs-root/usr/* /usr/ -r
  ```

* 修改权限设置

  ```bash
  # 修改权限设置
  sudo chmod 4755 /usr/share/cursor/chrome-sandbox
  ```









