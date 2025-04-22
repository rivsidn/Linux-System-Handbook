## vim-table-mode使用

### 安装

```vim
"markdown生成表格
Plug 'dhruvasagar/vim-table-mode',{'for':'markdown'}
```
通过`vim-plug` 管理插件，`$HOME/.vimrc` 文件中添加上述代码后，执行`:PlugInstall`即可.

### 设置

```vim
"常态化开启table-mode
let g:table_mode_always_active = 0
```

### 使用


#### 常用方式

* 表头内容通过 '|' 分割
* 表头输入结束之后输入 '||'，可以自动生成分割符
* 内容输入与标头一致，通过 '|' 分割


