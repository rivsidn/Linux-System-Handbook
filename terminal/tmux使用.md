`Tmux` 主要作用是窗口、会话分离，窗口也就是我们看到的操作界面，会话可以理解成是后台程序。

举例说明，我们开启一个`Terminal`，此时后台对应的程序是`bash`，通常退出`Terminal` 之后，后台对应的`bash` 也在同一时间结束了。通过`Tmux`，可以实现窗口、会话分离，也就是断开`Terminal`之后，`bash` 依旧存在，之后可以重新链接。



综上，一个会话可以有多个窗口，一个窗口可以分多个窗格。


## 常用工作流

### 查看会话

```bash
tmux ls
```

### 多窗格操作

1. tmux进入
2. `ctrl+b $` 会话重命名
3. `ctrl+b %` 左右划分窗格
4. `ctrl+b <arraw-key>` 窗格切换
5. 设置窗格布局

   `ctrl+b :` 进入命令模式，然后执行命令.

   | 命令                          | 设置       |
   |-------------------------------|------------|
   | select-layout even-horizontal | 水平等分   |
   | select-layout even-vertical   | 垂直等分   |
   | select-layout main-horizontal | 主窗格在上 |
   | select-layout main-vertical   | 主窗格在左 |
   | select-layout tiled           | 平铺       |

6. `exit` 退出窗格

### 窗格等分

1. tmux进入
2. `ctrl+b %` 创建多个(3个或者以上)窗格
3. `ctrl+b :` 输入命令

   | 命令                          | 说明             |
   |-------------------------------|------------------|
   | select-layout even-vertical   | 窗格之间横着排列 |
   | select-layout even-horizontal | 窗格之间竖着排列 |

### 多窗口操作

1. tmux进入
2. `ctrl+b $` 会话重命名
3. `ctrl+b c` 创建一个新窗口
4. `ctrl+b ,` 窗口重命名
5. `ctrl+b <num>`、`ctrl+b n/p` 窗口切换
6. `exit` 退出窗口


## 会话管理

### 外部命令

| 命令                                               | 说明                                             |
| -------------------------------------------------- | ------------------------------------------------ |
| tmux new-session -d -s \<session-name\>            | 会话创建<br />-d 不连接到会话<br />-s 指定会话名 |
| tmux list-sessions                                 | 会话查看                                         |
| tmux kill-session -t \<session-name\>              | 删除会话                                         |
| tmux attach-session -t \<target-session\>          | 连接会话                                         |
| tmux detach-client -s \<target-session\>           | 分离会话                                         |
| tmux rename-session -t \<target-session\> new-name | 重命名会话                                       |

### 内部快捷键

| 快捷键(ctrl+b) | 说明                       |
|----------------|----------------------------|
| s              | 列出所有会话               |
| d              | 分离当前会话               |
| $              | 重命名当前会话             |
| :              | 进入命令行模式，创建新会话 |

### 会话列表快捷键

`ctrl+b s` 可以列出当前所有会话.

| 快捷键 | 说明                         |
|--------|------------------------------|
| x      | 会话删除(不能删除绑定的会话) |


## 窗口设置

### 命令

| 命令             | 说明                         |
| ---------------- | ---------------------------- |
| tmux new-windos  | 创建一个新窗口               |
| tmux list-window | 查看窗口，可以看到有多个窗格 |


### 内部快捷键

| 快捷键(ctrl+b) | 说明                       |
|----------------|----------------------------|
| w              | 列出窗口列表               |
| c              | 创建一个新窗口             |
| p              | 切换到上一个窗口           |
| n              | 切换到下一个窗口           |
| ,              | 窗口重命名                 |
| :              | 进入命令行模式，创建新窗口 |


### 窗口列表快捷键

| 快捷键 | 说明     |
|--------|----------|
| x      | 删除窗口 |


## 窗格设置

### 命令

| 命令                 | 说明             |
| -------------------- | ---------------- |
| tmux split-window    | 划分上下两个窗格 |
| tmux split-window -h | 划分左右两个窗格 |
| tmux select-pane -U  | 窗格切换，上     |
| tmux select-pane -D  | 窗格切换，下     |
| tmux select-pane -L  | 窗格切换，左     |
| tmux select-pane -R  | 窗格切换，右     |

### 内部快捷键

| 快捷键(ctrl+b) | 说明                 |
| -------------- | -------------------- |
| %              | 左右划分窗格         |
| "              | 上下划分窗格         |
| \<arrow key\>  | 按照箭头方向切换窗格 |


### 参数设置

参数设置在`Ctrl+b` 之后输入。

| 设置                          | 说明              |
|-------------------------------|-------------------|
| :set synchronize-panes on/off | 开启/关闭窗格同步 |


## 其他操作

### 内容复制

写内容到文件中`.tmux.conf`.

```
# 设置为vim模式
# v 进入选中模式
# V 进入行选中模式
# y 复制到系统粘贴板
set-window-option -g mode-keys vi

bind-key -T copy-mode-vi 'v' send-keys -X begin-selection
bind-key -T copy-mode-vi 'V' send-keys -X select-line

bind-key -T copy-mode-vi 'y' send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'
```

### 保存交互日志


写内容到文件中`.tmux.conf`.

```
bind-key P command-prompt -p 'save history to filename:' -I '/tmp/tmux-history.txt' 'capture-pane -S -; save-buffer %1; delete-buffer'
```

输入`ctrl+b P` 输入文件名，保存内容到文件中.

## 附录

### 参考资料

* [Tmux使用教程](https://www.ruanyifeng.com/blog/2019/10/tmux.html)

