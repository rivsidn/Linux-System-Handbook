## tagbar安装

```vim
Bundle 'majutsushi/tagbar'

"tagbar setting
let g:tagbar_left=1
let g:tagbar_width=30
```

功能实现是`tagbar`通过`ctags` 解析文件结构，将生成的结构展示出来。

`universal-ctags` 默认支持`markdown`语言，不需要额外设置;

`exuberant-ctags` 不支持`markdown`，需要自己写正则表达式，使得能够识别
`markdown`。


## universal-ctags配置

`universal-ctags` 默认支持`makrdown`。

### 安装

```bash
sudo apt install universal-ctags
```

确认支持`markdown`.

```bash
$ ctags-universal --list-languages | grep -i markdown
Markdown
```

## exuberant-ctags配置


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
let g:tagbar_type_markdown = {
        \ 'ctagstype' : 'markdown',
        \ 'kinds' : [
                \ 'h:headings',
        \ ],
    \ 'sort' : 0
\ }
```

### 参考资料

* [在 Vim 里为 Markdown 文档展示导航窗格](https://mazhuang.org/2016/08/03/add-outline-for-markdown-in-vim/)
