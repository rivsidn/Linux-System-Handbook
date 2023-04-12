
```bash
sudo apt-get install vim-gtk
```


```bash
# 复制
"+y
"+yy

# 剪切
"+dd
"+p

# 快捷键
## Visual 模式下，通过C-y 复制到系统粘贴板
vnoremap <C-y> "+y
## normal 模式下，通过C-p 粘贴系统粘贴板
nnoremap <C-p> "*p
```





