### 安装

```bash
cd /tmp
wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
zcat < install-tl-unx.tar.gz | tar xf -
cd install-tl-*
perl ./install-tl --no-interaction # as root or with writable destination

```

**配置PATH**

```bash
export PATH="$PATH:/usr/local/texlive/2023/bin/x86_64-linux"
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

### 参考资料

* [TeX Live - Quick install for Unix](https://tug.org/texlive/quickinstall.html)
