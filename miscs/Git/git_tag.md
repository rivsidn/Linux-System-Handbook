
## 查看标签

```bash
# 显示当前所有标签
git tag

# 通过通配符输出标签
git tag -l "v4.4*"
```


## 附注标签

```bash
# 打标签
$ git tag -a v1.4 -m "my version 1.4"

# 查看标签信息
$ git show v1.4
```

附注标签的输出中能够看到打标签者的信息、打标签的日期时间、附注信息，然后显示提交信息。


## 轻量标签

```bash
$ git tag v1.4-w

# 通配符输出相关标签
$ git tag -l "v4.4*"

# 查看标签
$ git show v1.4-1w
```

轻量标签的输出中不会看到额外的信息，命令只会显示出提交信息.

## 后期打标签

```bash
$ git tag -a v1.2 <校验和>
```

## 共享标签

将标签传送到远程仓库

## 删除标签

### 删除本地标签
### 删除远程标签


## 检出标签

```bash
$ git checkout <tagname>
```

```bash
# 基于tag v2.0.0 创建一个新version2 的新分支
$ git checkout -b version2 v2.0.0
```

