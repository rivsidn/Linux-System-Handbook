
## 软件安装

* `drawio`下载，[下载地址](https://github.com/jgraph/drawio-desktop/releases/tag/v20.3.0)

* 安装

  ```bash
  sudo dpkg -i drawio-amd64-20.3.0.deb
  ```

## 图标显示问题

### 排查手段


- 确认窗口类，执行`xprop`之后，点击drawio 窗口.

  命令会输出两条字符串，分别为 实例名、窗口类名.

  ```bash
  $ xprop WM_CLASS
  WM_CLASS(STRING) = "draw.io", "draw.io"
  ```
- 修改`drawio.desktop` 中`StartupWMClass=draw.io` 为对应的窗口类

- 重启应用即可


### 修改方案

#### 原文件

```desktop
[Desktop Entry]
Name=drawio
Exec=/opt/drawio/drawio %U
Terminal=false
Type=Application
Icon=drawio
StartupWMClass=drawio
Comment=draw.io desktop
MimeType=application/vnd.jgraph.mxfile;application/vnd.visio;
Categories=Graphics;
```

#### 修改后

```desktop
[Desktop Entry]
Name=drawio
Exec=/opt/drawio/drawio %U
Terminal=false
Type=Application
Icon=drawio
StartupWMClass=draw.io
Comment=draw.io desktop
MimeType=application/vnd.jgraph.mxfile;application/vnd.visio;
Categories=Graphics;
```

