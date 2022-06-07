## 情景

当前ssh服务器上一个git仓库，想要实现的功能是：

1. 将代码从ssh 服务器上 clone 下来

```bash
git clone ssh://rivsidn@172.31.3.137/home/rivsidn/tmp/repository/.git
```

2. 同步ssh服务器上的代码修改

```bash
git pull
```

3. 向ssh 服务器上提交自己的代码修改

```bash
# 服务器端执行
git config receive.denyCurrentBranch updateInstead
```

```bash
# 本地
git push
```





