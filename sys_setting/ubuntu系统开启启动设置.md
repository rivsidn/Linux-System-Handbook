关闭开机启动的 4 中方式：

* `systemctl`禁止开机启动
* `rcconf`或者`update-rc.d`关闭自启动服务
* 通过`gnome-session-properties`禁用GUI程序自启动
* 手动编辑`~/.config/autostart/`下的启动项



## 开启启动设置

### `systemctl`设置

```bash
# 列出当前服务
sudo systemctl list-unit-files --type=service
# 禁用服务
sudo systemctl disable 服务名
```



### `rcconf`或`update-rc.d`配置

```bash
# rcconf配置，安装后启动，勾选即可
sudo apt-get install rcconf
sudo rcconf
# update-rc.d配置
sudo update-rc.d 服务名称 disable
```

### `gnome-session-properties`设置

* `Alt+F2`，输入`gnome-session-properties`然后回车
* 勾选设置

### `动编辑~/.config/autostart/`设置

修改目录下的 xxx.desktop 文件实现



## 本地设置

### 守护进程开机启动

`/etc/systemd/system/` 下加入文件 `daemon.service`.

```bash
[Unit]
Description=fake daemon
After=network.target
Wants=network.target

[Service]
User=name
Group=name
Type=simple
ExecStart=/home/yuchao/scripts/daemon
Restart=on-failure
# Don't restart in the case of configuration error
RestartPreventExitStatus=23
StartLimitBurst=10
StartLimitInterval=1


[Install]
WantedBy=multi-user.target
```

### Keynav开机启动

`~/.config/autostart` 下加入文件`keynav.desktop`.

```bash
[Desktop Entry]
Type=Application
Name=keynav
Comment=
GenericName=keynav
Exec=/usr/bin/keynav daemon
Icon=
StartupNotify=false
Categories=Network
Keywords=keynav
Terminal=false
Name[zh_CN]=keynav
```

### Etrust开机启动

`~/.config/autostart` 下加入文件`etrust.desktop`.

```bash
[Desktop Entry]
Type=Application
Name=SIMguard
Comment=A secure connection.
GenericName=simguard
Exec=/usr/local/etrust/ui/etrust-ui
Icon=/usr/local/etrust/ui/UI.png
StartupNotify=false
Categories=Network
Keywords=simguard
Terminal=false
Name[zh_CN]=超级SIM安全网关
```

