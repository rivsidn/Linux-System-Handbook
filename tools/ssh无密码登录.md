## 设置步骤

### 本地生成密钥

```bash
# 生成密钥
ssh-keygen -t rsa
# 或
ssh-keygen -b 4096 -t rsa
```

执行命令需要两次输入密码，服务器导入公钥之后第一次登录需要输入该密码。

> $ ssh-keygen -t rsa
> Generating public/private rsa key pair.
> **Enter file in which to save the key (/home/yuchao/.ssh/id_rsa):**
> **Enter passphrase (empty for no passphrase):** 
> **Enter same passphrase again:** 
> Your identification has been saved in /home/yuchao/.ssh/id_rsa
> Your public key has been saved in /home/yuchao/.ssh/id_rsa.pub
> The key fingerprint is:
> SHA256:IOADRe/QfJGIDZErAXCPguZUPmajhQudYYghXUVBM/s yuchao@yuchao
> The key's randomart image is:
> +---[RSA 3072]----+
> |X*XO.=Oo         |
> |**BXo .=         |
> |+=BO* +          |
> |*.B+oo o         |
> | =  .   E        |
> |                 |
> |                 |
> |                 |
> |                 |
> +----[SHA256]-----+

### 上传公钥到服务器

```bash
ssh-copy-id username@server-ip
```

输入用户密码即可，`SSH`公钥就会自动上传了，公钥保存在服务器的`.ssh/authorized_keys` 中。此后登录服务器，仅仅第一次需要输入密钥密码， 之后不想要输入密码。



## 附录

### 参考资料

* [SSH无密码登录：只需两个简单步骤 (Linux)](https://www.linuxdashen.com/ssh-key：两个简单步骤实现ssh无密码登录)