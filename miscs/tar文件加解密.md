




```bash
# 文件加密
tar czvf - tmp/ | openssl enc -e -aes256 -k 'passwd' -out aaa.tar.gz

# 文件解密
openssl enc -d -aes256 -in aaa.tar.gz | tar xzvf - -C ./
```



## TODO

1. `openssl` 命令
2. 加解密常用知识点，算法等

