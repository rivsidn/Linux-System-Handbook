## 功能

实现键盘控制鼠标位置的功能



## 安装&启动

### 安装

```bash
sudo apt-get update
sudo apt-get install keynav
```

### 启动

```bash
# 后台启动
keynav daemonize
```



## 命令整理

| 命令                        | 作用                                                         |
| --------------------------- | ------------------------------------------------------------ |
| start                       | 开启导航                                                     |
| end                         | 结束导航                                                     |
| quit                        | 退出导航，会关闭进程                                         |
| restart                     | 重启程序，会重新读取配置文件                                 |
|                             |                                                              |
| cut-up [value]              | 向上切割导航区域，value默认为0.5                             |
| cut-down [value]            | 向下切割导航区域，value默认为0.5                             |
| cut-left [value]            | ...                                                          |
| cut-right [value]           | ...                                                          |
| move-up [value]             | 向上移动导航区域，value默认为 1                              |
| move-down [value]           |                                                              |
| move-left [value]           |                                                              |
| move-right [value]          |                                                              |
| cursorzoom width height     | 鼠标位置建立导航区域，并设置区域大小                         |
| windowzoom                  | 设置导航区域为当前活动窗口大小                               |
|                             |                                                              |
| wrap                        | 移动鼠标到当前导航区域中心                                   |
| click [button]              | 点击鼠标<br/>1 = left, 2 = middle, 3 = right, 4 = wheel up, 5 = wheel down. |
| doubleclick [button]        | 双击鼠标，button 跟上述一致                                  |
| drag button [modifier-keys] | 拖动鼠标(对拖动应用窗口不起作用)                             |
|                             |                                                              |
|                             |                                                              |
|                             |                                                              |



快捷键通过组合上述`command` 实现通过键盘空住鼠标的作用。



## 快捷键整理

### 默认配置

> clear
> ctrl+semicolon start
> Escape end
> ctrl+bracketleft end
> q record ~/.keynav_macros
> shift+at playback
> a history-back
> h cut-left
> j cut-down
> k cut-up
> l cut-right
> shift+h move-left
> shift+j move-down
> shift+k move-up
> shift+l move-right
> space warp,click 1,end
> Return warp,click 1,end
> semicolon warp,end
> w warp
> t windowzoom
> c cursorzoom 300 300
> e end
> 1 click 1
> 2 click 2
> 3 click 3
> ctrl+h cut-left
> ctrl+j cut-down
> ctrl+k cut-up
> ctrl+l cut-right
> y cut-left,cut-up
> u cut-right,cut-up
> b cut-left,cut-down
> n cut-right,cut-down
> shift+y move-left,move-up
> shift+u move-right,move-up
> shift+b move-left,move-down
> shift+n move-right,move-down
> ctrl+y cut-left,cut-up
> ctrl+u cut-right,cut-up
> ctrl+b cut-left,cut-down
> ctrl+n cut-right,cut-down


### 开机自启动

- 设置开机启动文件`/home/yuchao/.config/systemd/user/keynav.service`
    ```
    [Unit]
    Description=Keynav - keyboard mouse control
    After=graphical-session.target
    Wants=graphical-session.target

    [Service]
    Type=simple
    ExecStart=/usr/bin/keynav
    Restart=always
    RestartSec=5
    Environment=DISPLAY=:0
    Environment=WAYLAND_DISPLAY=wayland-0

    [Install]
    WantedBy=default.target
    ```
- 设置命令
    ```
    启用/禁用服务：
    systemctl --user enable keynav.service   # 开机自启
    systemctl --user disable keynav.service  # 取消开机自启

    启动/停止服务：
    systemctl --user start keynav.service    # 立即启动
    systemctl --user stop keynav.service     # 立即停止
    systemctl --user restart keynav.service  # 重启服务

    查看状态：
    systemctl --user status keynav.service   # 查看运行状态
    systemctl --user is-enabled keynav.service  # 查看是否开机自启
    ```

### 配置文件

可以在 `~/.keynavrc` 目录下输入自己的配置。

```
s click 1
f click 3
e click 4
d click 5

r restart
z end

# 默认情况下不移鼠标
space click 1,warp,end

```


## TODO 

通过嵌入sh 命令能够实现那些有意思的功能。

[如何通过命令行修改窗口大小](https://unix.stackexchange.com/questions/43106/how-to-set-window-size-and-location-of-an-application-on-screen-via-command-line)




## 参考资料

* [keynav使用介绍](https://github.com/jordansissel/keynav/blob/master/keynav.pod)
* [keynav-retire your mouse](https://www.semicomplete.com/projects/keynav/)





