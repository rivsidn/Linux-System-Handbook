
使用`qpdf` 拼接PDF 文件.


### 页面旋转

```bash
qpdf input.pdf --rotate=+90:1-z -- rotated.pdf
```

将input.pdf 文件中所有页面，顺时针旋转90度，输出到 rotated.pdf.


### 页面选择

```bash
qpdf --empty --pages a.pdf b.pdf z-1 c.pdf 3,6 -- output.pdf
```

将页面按照顺序输出到output.pdf 中.

| 文件  | 页面范围       |
|-------|----------------|
| a.pdf | 所有页面       |
| b.pdf | 所有页面反方向 |
| c.pdf | 3,6 页面       |


