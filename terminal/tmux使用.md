`Tmux` 主要作用是窗口、会话分离，窗口也就是我们看到的操作界面，会话可以理解成是后台程序。

举例说明，我们开启一个`Terminal`，此时后台对应的程序是`bash`，通常退出`Terminal` 之后，后台对应的`bash` 也在同一时间结束了。通过`Tmux`，可以实现窗口、会话分离，也就是断开`Terminal`之后，`bash` 依旧存在，之后可以重新链接。



综上，一个会话可以有多个窗口，一个窗口可以分多个窗格。



## 会话管理

### 外部命令

| 命令                                               | 说明                                             |
| -------------------------------------------------- | ------------------------------------------------ |
| tmux new-session -d -s \<session-name\>            | 会话创建<br />-d 不连接到会话<br />-s 指定会话名 |
| tmux list-session                                  | 会话查看                                         |
| tmux kill-session -t \<session-name\>              | 删除会话                                         |
| tmux attach-session -t \<target-session\>          | 连接会话                                         |
| tmux detach-client -s \<target-session\>           | 分离会话                                         |
| tmux rename-session -t \<target-session\> new-name | 重命名会话                                       |

### 内部快捷键

| 快捷键(ctrl+b) | 说明           |
| -------------- | -------------- |
| d              | 分离当前会话   |
| s              | 列出所有会话   |
| $              | 重命名当前会话 |



## 窗口设置

### 外部命令

| 命令             | 说明                         |
| ---------------- | ---------------------------- |
| tmux list-window | 查看窗口，可以看到有多个窗格 |

### 内部快捷键



## 窗格设置

### 外部命令

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





## 附录

### 参考资料

* [Tmux使用教程](https://www.ruanyifeng.com/blog/2019/10/tmux.html)