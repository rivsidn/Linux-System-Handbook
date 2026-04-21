
### 取消鼠标悬停选中

当前配置鼠标悬停即获得焦点，不需要点击.

当前配置下需要频繁移动鼠标，不方便，希望改变这个配置.

```bash
gsettings set org.gnome.desktop.wm.preferences focus-mode 'click'
```

### caps设置成ctrl

```bash

# caps 设置成ctrl
gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:nocaps']"
# caps、ctrl 互换
gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:swapcaps']"
# 恢复默认配置
gsettings reset org.gnome.desktop.input-sources xkb-options

```


