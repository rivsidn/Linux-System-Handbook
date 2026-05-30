
## 命令安装

`filter-repo` 不是git 自带的命令，需要单独安装.

```bash
sudo apt install git-filter-repo
```

## 仓库初始化

通过[初始化脚本](#初始化脚本) 创建Git 仓库.

初始化之后的文件格式.

```bash
$ tree -t 
.
├── init.sh
├── sub-A
│   └── a.txt
└── sub-B
    └── b.txt

3 directories, 3 files
```

## 仓库拆分

```bash
git subtree split --prefix=sub-A -b sub-A-split
git subtree split --prefix=sub-B -b sub-B-split
```

解释:

- `git subtree split` 是命令
- `--prefix=sub-A`  指定目录名
- `sub-A-split` 指定创建的分支名称

该命令会创建一个包含sub-A 文件、提交日志的git 分支.

## 提交同步

假设我们将两个subtree 分支创建了worktree.

### 主仓库同步到subtree

```bash
git -C ../sub-A-worktree merge "$(git subtree split --prefix=sub-A master)"
```

在主仓库中执行这个命令，将主仓库的修改合并到subtree.

### subtree同步到主仓库

```bash
git subtree merge --prefix=sub-A sub-A-split -m "Merge sub-A changes"
```

## 附录

### 分支合并

如果subtree 不是独立的worktree，需要通过这种方式合并修改.

```bash
# 获取修改commit
git checkout master
split_commit=$(git subtree split --prefix=sub-A master)

# 合并修改commit
git checkout sub-A-split
git merge "$split_commit"

```

### 初始化脚本

```bash
#! /bin/bash

set -e

# 创建文件
mkdir sub-A
mkdir sub-B

touch sub-A/a.txt
touch sub-B/b.txt

# GIT初始化
git init
git add  *
git commit -m "init"

# 分别创建提交日志
echo "aaa" > sub-A/a.txt
git add * 
git commit -m "commit to sub-A"

# 分别创建提交日志
echo "bbb" > sub-B/b.txt
git add * 
git commit -m "commit to sub-B"
```

