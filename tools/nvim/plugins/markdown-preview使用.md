# markdown-preview.nvim 使用

本地 nvim 使用 `iamcco/markdown-preview.nvim` 做 Markdown 浏览器预览。

## 快捷键

在 `.md` 文件中按：

```vim
<F5>
```

等价于执行：

```vim
:MarkdownPreviewToggle
```

常用命令：

```vim
:MarkdownPreview
:MarkdownPreviewStop
:MarkdownPreviewToggle
```


## 依赖

需要本机安装：

```bash
node -v
npm -v
xdg-open --version
```

浏览器由 `xdg-open` 打开，默认浏览器可用下面命令查看：

```bash
xdg-settings get default-web-browser
```
## 常见故障：缺少 Node 依赖

如果预览不生效，并看到类似错误：

```text
Error: Cannot find module '@chemzqm/neovim'
```

通常是插件的 Node 依赖没有安装。修复：

```bash
cd ~/.local/share/nvim/lazy/markdown-preview.nvim/app
npm install
```

也可以在 nvim 里执行：

```vim
:Lazy build markdown-preview.nvim
```

