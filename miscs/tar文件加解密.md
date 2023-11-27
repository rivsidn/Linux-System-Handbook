



### 单个文件

```bash
# 文件加密
tar czvf - tmp/ | openssl enc -e -aes256 -k 'passwd' -out aaa.tar.gz

# 文件解密
openssl enc -d -aes256 -k 'passwd' -in aaa.tar.gz | tar xzvf - -C ./
```

### 加密并拆解成多个文件

```bash
# 文件加密
tar czvf - test/ | openssl enc -e -aes256 -k '123456' | split -b 100m - ~/test.tar.gz

# 文件解密
cat test.tar.gz* | openssl -enc -k '123456' -d -aes256 | tar xzvf - -C ./
```



## TODO

1. `openssl` 命令
2. 加解密常用知识点，算法等

