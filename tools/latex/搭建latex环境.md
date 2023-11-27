### 安装

```bash

```



### 示例程序

```tex
\documentclass[UTF8]{ctexart}
\begin{document}
你好，world!
\end{document}
```



### 编译

```bash
xelatex test.tex
```



### Vim配置

```bash
Bundle 'lervag/vimtex'

"LaTeX配置
let g:tex_flavor='latex'
let g:vimtex_compiler_latexmk_engines = {
    \ '_'                : '-pdf',
    \ 'pdflatex'         : '-pdf',
    \ 'dvipdfex'         : '-pdfdvi',
    \ 'lualatex'         : '-lualatex',
    \ 'xelatex'          : '-xelatex',
    \ 'context (pdftex)' : '-pdf -pdflatex=texexec',
    \ 'context (luatex)' : '-pdf -pdflatex=context',
    \ 'context (xetex)'  : '-pdf -pdflatex=''texexec --xtx''',
    \}

let g:vimtex_view_general_viewer = '/usr/bin/okular'

```

#### 使用

```tex
% !TEX program = xelatex
% 首行加入，声明编译环境，其他正常写即可

```



### 参考资料

* [TeX Live - Quick install for Unix](https://tug.org/texlive/quickinstall.html)
