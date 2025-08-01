
### 安装

```bash
sudo apt install fzf
```

### 使用

#### 

```bash
tmux attach -t $(tmux list-sessions -F '#S' | fzf)
```

从列出的session 名称中执行模糊匹配，选中之后进入session.

