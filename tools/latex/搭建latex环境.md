### 安装

```bash
<<<<<<< HEAD

=======
cd /tmp
wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
zcat < install-tl-unx.tar.gz | tar xf -
cd install-tl-*
perl ./install-tl --no-interaction # as root or with writable destination

```

**配置PATH**

```bash
export PATH="$PATH:/usr/local/texlive/2023/bin/x86_64-linux"
>>>>>>> b3bd4d986aa23aca34d626d0562c6430f9223122
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
