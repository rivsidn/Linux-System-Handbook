
### 取消鼠标悬停选中

当前配置鼠标悬停即获得焦点，不需要点击.

当前配置下需要频繁移动鼠标，不方便，希望改变这个配置.

```bash
gsettings set org.gnome.desktop.wm.preferences focus-mode 'click'
```

### 设置Caps为Ctrl

```bash
# 设置Caps为Ctrl
gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:nocaps']"

# 交换Caps和Ctrl
gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:swapcaps']"

# 恢复初始设置
gsettings reset org.gnome.desktop.input-sources xkb-options
```

