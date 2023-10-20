### 文件剪切

```bash
# 保存页数
pdftk INPUT.pdf cat 1-100 output OUTPUT.pdf 

# 从第1页开始从最后结束保存奇数页
pdftk input.pdf cat 1-endodd output odd_pages.pdf

# 从第2页开始从最后结束保存偶数页
pdftk input.pdf cat 2-endeven output even_pages.pdf
```







### 参考资料

* [PDF 合并和分割工具--PDFtk](https://blog.seisman.info/pdftk/)
