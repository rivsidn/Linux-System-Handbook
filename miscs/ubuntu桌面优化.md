## 20.04 桌面优化

### 软件安装

```bash
sudo apt-get install gnome-tweaks chrome-gnome-shell
```

### 安装拓展

访问网址`https://extensions.gnome.org/`，安装`Workspace Matrix` 。

安装`Workspace Matrix` 之后，快捷键`Win+w` 查看桌面缩略图。




## workspace 独立

```
workspace isolated dash
```

由于该拓展跟`dashtodock` 互斥，要想该拓展生效需要卸载`dashtodock`。

```bash
sudo apt purge gnome-shell-extension-dashtodock
```


```bash
# 桌面独立
gsettings set org.gnome.shell.app-switcher current-workspace-only true
gsettings set org.gnome.shell.extensions.dash-to-dock isolate-workspaces true
```


```
比如解压后的名字为 apps-menugnome-shell-extensions.gcampax.github.com.v40.shell-extension， 你需要去掉后缀 .v40.shell-extension，然后把文件夹拷贝到 ~/.local/share/gnome-shell/extensions，重启 Gnome-Tweaks 就可以了。
```



## TODO

* [ubuntu 18.04 Gnome桌面优化](https://blog.51cto.com/u_6200909/3159334)
* [How to prevent Gnome-shell's Alt+Tab from grouping windows from similar apps?](https://superuser.com/questions/394376/how-to-prevent-gnome-shells-alttab-from-grouping-windows-from-similar-apps)
