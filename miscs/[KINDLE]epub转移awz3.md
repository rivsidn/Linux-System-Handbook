## 软件安装

```bash
sudo apt install calibre
```



## 文件转换

`ebook-convert` 通过文件后缀区分文件格式 

```bash
ebook-convert <filename>.epub <filename>.azw3
```

```bash
for file in `ls -A *.txt`; do ebook-convert ${file}  $(basename ${file} .txt).azw3; done;
```






