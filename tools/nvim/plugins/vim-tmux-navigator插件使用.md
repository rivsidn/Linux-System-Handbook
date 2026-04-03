
简单来说就是支持nvim 与 tmux 之间切换。


## 附录

> ## 典型使用方式
> 
> 通常是在 `tmux` 里启动 `nvim`：
> 
> 1. 先打开一个 `tmux session`
> 2. 在 `tmux` 里划分多个 pane
> 3. 其中一个 pane 运行 `nvim`
> 4. 其他 pane 运行 shell、测试、日志、REPL 等
> 
> 此时 `vim-tmux-navigator` 负责把 `nvim split` 和 `tmux pane` 的导航体验统一起来。
> 
> ## 当前本机配置
> 
> Neovim 配置目录：
> 
> ```text
> /home/yuchao/github/nvim
> ```
> 
> tmux 配置文件：
> 
> ```text
> /home/yuchao/github/dotfiles/tmux/.tmux.conf
> ```
> 
> 当前使用 `Alt + h/j/k/l` 作为切换快捷键。
> 
> ### Neovim 侧配置
> 
> 文件：
> 
> ```text
> /home/yuchao/github/nvim/lua/plugins.lua
> ```
> 
> 关键配置：
> 
> ```lua
> local vim_tmux_navigator = {
>   "christoomey/vim-tmux-navigator",
>   cmd = {
>     "TmuxNavigateLeft",
>     "TmuxNavigateDown",
>     "TmuxNavigateUp",
>     "TmuxNavigateRight",
>     "TmuxNavigatorProcessList",
>   },
>   init = function()
>     vim.g.tmux_navigator_no_mappings = 1
>   end,
>   keys = {
>     { "<A-h>", "<cmd><C-U>TmuxNavigateLeft<cr>", desc = "切换到左侧窗口" },
>     { "<A-j>", "<cmd><C-U>TmuxNavigateDown<cr>", desc = "切换到下方窗口" },
>     { "<A-k>", "<cmd><C-U>TmuxNavigateUp<cr>", desc = "切换到上方窗口" },
>     { "<A-l>", "<cmd><C-U>TmuxNavigateRight<cr>", desc = "切换到右侧窗口" },
>   },
> }
> ```
> 
> 说明：
> 
> - `tmux_navigator_no_mappings = 1` 表示关闭插件默认的 `<C-h/j/k/l>` 映射
> - 改为使用 `<A-h/j/k/l>`，也就是 `Alt + h/j/k/l`
> - 原生的 `C-w h/j/k/l` 仍然保留，不受影响
> 
> ### tmux 侧配置
> 
> 文件：
> 
> ```text
> /home/yuchao/github/dotfiles/tmux/.tmux.conf
> ```
> 
> 关键配置：
> 
> ```tmux
> set -g @vim_navigator_pattern '(\S+/)?g?\.?(view|l?n?vim?x?|fzf)(diff)?(-wrapped)?'
> 
> bind-key -n M-h if-shell "ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +#{@vim_navigator_pattern}$'" 'send-keys M-h' 'select-pane -L'
> bind-key -n M-j if-shell "ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +#{@vim_navigator_pattern}$'" 'send-keys M-j' 'select-pane -D'
> bind-key -n M-k if-shell "ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +#{@vim_navigator_pattern}$'" 'send-keys M-k' 'select-pane -U'
> bind-key -n M-l if-shell "ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +#{@vim_navigator_pattern}$'" 'send-keys M-l' 'select-pane -R'
> ```
> 
> 说明：
> 
> - 如果当前 `tmux pane` 里运行的是 `nvim/vim/fzf`，tmux 会把 `Alt + h/j/k/l` 发给当前程序
> - 如果当前 pane 不是这些程序，tmux 自己执行 `select-pane`
> - 这样就实现了同一套按键在 `nvim` 和 `tmux` 之间切换
> 
> ## 日常使用
> 
> 当前建议这样理解：
> 
> - 在普通 shell pane 里按 `Alt + h/j/k/l`，tmux 会切换 pane
> - 在运行 `nvim` 的 pane 里按 `Alt + h/j/k/l`，会交给 `vim-tmux-navigator`
> - `nvim` 默认窗口移动仍然可以使用 `C-w h/j/k/l`
> 
> ## 生效方式
> 
> 首次安装插件：
> 
> ```nvim
> :Lazy sync
> ```
> 
> 重新加载 tmux 配置：
> 
> ```bash
> tmux source-file /home/yuchao/github/dotfiles/tmux/.tmux.conf
> ```
> 
> 如果只是修改了 Neovim 配置，也可以重启 `nvim`，或者执行：
> 
> ```nvim
> :Lazy reload vim-tmux-navigator
> ```
> 
> ## 常见说明
> 
> - `Alt + h/j/k/l` 在 `Neovim` 里默认没有常见内置映射，适合自定义
> - 在终端里，`Alt` 常常以 `Esc + key` 的形式传递，所以终端和 tmux 是否正确转发按键很重要
> - 如果某些终端环境下 `Alt` 不稳定，可以退回使用插件默认的 `<C-h/j/k/l>`
> 
> ## 一句话总结
> 
> 这个插件的价值不只是“统一快捷键”，而是让 `nvim split` 和 `tmux pane` 在边界处可以自动接力切换。
> 
