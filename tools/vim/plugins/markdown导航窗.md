
### 安装

```vim
Bundle 'majutsushi/tagbar'
```

### 设置

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

