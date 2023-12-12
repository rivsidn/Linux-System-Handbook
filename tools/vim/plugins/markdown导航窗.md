
### 安装

```vim
Bundle 'majutsushi/tagbar'
```

### 设置

设置~/.ctags文件.

```
--langdef=markdown
--langmap=markdown:.md
--regex-markdown=/^#{1}[ \t]*([^#]+.*)/. \1/h,headings/
--regex-markdown=/^#{2}[ \t]*([^#]+.*)/.   \1/h,headings/
--regex-markdown=/^#{3}[ \t]*([^#]+.*)/.     \1/h,headings/
--regex-markdown=/^#{4}[ \t]*([^#]+.*)/.       \1/h,headings/
--regex-markdown=/^#{5}[ \t]*([^#]+.*)/.         \1/h,headings/
--regex-markdown=/^#{6}[ \t]*([^#]+.*)/.           \1/h,headings/
```

`~.vimrc` 中添加如下配置.

```vim
"tagbar setting
let g:tagbar_left=1
let g:tagbar_width=30
let g:tagbar_type_markdown = {
        \ 'ctagstype' : 'markdown',
        \ 'kinds' : [
                \ 'h:headings',
        \ ],
    \ 'sort' : 0
\ }
nnoremap tb :TagbarToggle<CR>
```

`normal` 模式下输入 `tb` 打开tagbar 窗口.

### 参考资料

* [在 Vim 里为 Markdown 文档展示导航窗格](https://mazhuang.org/2016/08/03/add-outline-for-markdown-in-vim/)
