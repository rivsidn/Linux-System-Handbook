## 20.04 桌面优化

### 软件安装

```bash
sudo apt-get install gnome-tweaks chrome-gnome-shell
```

### 安装拓展

访问网址`https://extensions.gnome.org/`，安装`Workspace Matrix` 。

安装`Workspace Matrix` 之后，快捷键`Win+w` 查看桌面缩略图。


## workspace 独立

```bash
# 桌面独立
gsettings set org.gnome.shell.app-switcher current-workspace-only true
gsettings set org.gnome.shell.extensions.dash-to-dock isolate-workspaces true
```


## TODO

* [ubuntu 18.04 Gnome桌面优化](https://blog.51cto.com/u_6200909/3159334)
* [How to prevent Gnome-shell's Alt+Tab from grouping windows from similar apps?](https://superuser.com/questions/394376/how-to-prevent-gnome-shells-alttab-from-grouping-windows-from-similar-apps)
