

### 模式切换

| 快捷键   | 模式切换               |
|----------|------------------------|
| Ctrl+W N | 切换为normal 模式      |
| a/i      | 切换为Terminal-Job模式 |


`Terminal-Job` 模式是进入`Terminal` 的默认模式。


### 窗口设置

```vim
"split窗口位置设置
set splitbelow
"显示窗口大小
if exists('&termwinsize')
    set termwinsize=12*0
endif
```

