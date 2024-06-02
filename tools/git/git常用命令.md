## archive

```bash
# 以tar.gz格式压缩当前代码
git archive --format=tar.gz 'b-2.1.34' -o ~/linux-2.1.34.tar.gz
```

## checkout

```bash
# 创建新的分支
git chechout -b <branch-name> <tag>
# 创建追踪分支
git checkout -b <branch-name> <remote-branch>
```

## config

```bash
# 全局配置比较工具为meld
git config --global diff.tool meld

# 解决显示中文异常问题
git config --global core.quotepath 0
```

## describe

```bash
# 生成提交描述信息
$ git describe bc0b96b54a21
v3.0-7531-gbc0b96b54a21
```

`git`没有一个递增的版本号，可以通过 `git describe` 给每个`commit`生成一个比较容易看懂的提交名称。

## difftool

```bash
# 比较文件
git difftool <commit> <commit> Makefile
# 比较文件之前不输出提示信息
git difftool -y <commit> <commit> Makefile
# 比较目录
git difftool <commit> <commit> net/
```



## log

### -S

```bash
# 搜索包含 md5_transform 的提交
$ git log -S 'md5_transform' --oneline
```







