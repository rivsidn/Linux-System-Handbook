创建一个名为`git-name`的子命令就可以实现名为`name`的子命令。

希望实现一个存储本地`cscope`和`tags` 的子命令。



### git-tags

```bash
#! /bin/bash

branch="$(git branch | grep "^*" | cut -d ' ' -f 2-)"

GIT_ROOT="$(git rev-parse --git-dir)"
TAGS_DIR="${GIT_ROOT}/tags"
BRANCH_DIR="${TAGS_DIR}/${branch}"

if [ ! -d ${TAGS_DIR} ]; then
	mkdir ${TAGS_DIR}
fi


if [ "$1" = "recover" ]; then
	if [ -d ${BRANCH_DIR} ]; then
		echo "Not stored tags yet" >&2
		exit
	else
		cp ${BRANCH_DIR}/* ./
	fi
else
	if [ -d ${BRANCH_DIR} ]; then
		exit
	else
		mkdir ${BRANCH_DIR}
		cp cscope* ${BRANCH_DIR}
		cp tags ${BRANCH_DIR}
	fi
fi
```







