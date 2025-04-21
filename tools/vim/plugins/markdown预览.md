## markdown-preview

### 安装

```vim
Bundle 'iamcco/markdown-preview.vim'
```

### 使用

```bash
# 开启预览
:MarkdownPreview
# 关闭预览
:MarkdownPreviewStop
```

## vim-instant-markdown

### 安装

```vim
Plug 'suan/vim-instant-markdown',{'for':'markdown'}
```

### 使用

```vim
let g:instant_markdown_mathjax = 1
let g:instant_markdown_mermaid = 1
let g:instant_markdown_theme = 'light'

"预览开启or关闭
nnoremap <silent> <F5> :InstantMarkdownPreview<CR>
nnoremap <silent> <F6> :InstantMarkdownStop<CR>
```
