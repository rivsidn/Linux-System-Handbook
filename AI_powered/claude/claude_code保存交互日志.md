
## 保存交互日志到文件

### 工具安装

```bash
sudo apt install expect
```

### 命令执行

```bash
unbuffer claude | tee test.md
```

### 日志查看

通过`vim`查看日志.

```vim
"显示ANSI字符
Plug 'powerman/vim-plugin-AnsiEsc'

"插件安装执行 :PlugInstall
```

文件打开之后执行`:AnsiEsc` 即可.

