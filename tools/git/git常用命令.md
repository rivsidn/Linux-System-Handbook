## describe

```bash
# 生成提交描述信息
$ git describe bc0b96b54a21
v3.0-7531-gbc0b96b54a21
```

`git`没有一个递增的版本号，可以通过 `git describe` 给每个`commit`生成一个比较容易看懂的提交名称。

## log

### -S

```bash
# 搜索包含 md5_transform 的提交
$ git log -S 'md5_transform' --oneline
```







