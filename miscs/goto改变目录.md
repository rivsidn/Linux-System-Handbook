终端下工作的时候，有时候路径太深且涉及多个，通过 `cd` 修改路径比较繁琐，希望能够实现一个`goto` 命令，后边跟一个提示符，根据提示符就能跳转到指定的位置。

主要涉及两个文件：

| 涉及文件                 | 功能             |
| ------------------------ | ---------------- |
| /usr/local/bin/changedir | 实现修改目录功能 |
| ~/.bashrc                | 添加goto别名     |

实现之后效果如下：

```bash
rivsidn@rivsidn:~$ goto C
rivsidn@rivsidn:~/gitHub/Programming_Language/C$ 
```

## 代码

### shell脚本

```bash
#! /bin/bash

case ${1} in
C)
	cd ~/gitHub/Programming_Language/C
	;;
doc)
	cd ~/gitHub/kernel_doc
	;;
misc)
	cd ~/gitHub/Misc
	;;
2.4)
	cd ~/gitHub/linux-2.4.0
	;;
2.6)
	cd ~/gitHub/linux-2.6.35.6
	;;
*)
	echo 1>&2 "invalid path"
	;;
esac

if [ ! -z "$2" ]
then
	cd $2
fi
```

### 添加别名

```bash
alias goto='source /usr/local/bin/changedir'
```
