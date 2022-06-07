`.bashrc` 文件中设置函数，可以改变`terminal` 标题。

```bash
function title() {
    # Set terminal tab title. Usage: title "new tab name"
    prefix=${PS1%%\\a*}                  # Everything before: \a
    search=${prefix##*;}                 # Eeverything after: ;
    esearch="${search//\\/\\\\}"         # Change \ to \\ in old title
    PS1="${PS1/$esearch/$@}"             # Search and replace old with new
}
```

设置之后保存，重新开启一个新的`terminal` 之后，输入

```bash
title "new title"
```

即可以修改 `terminal` 标题。

验证，同样支持修改 `ssh` 远程连接的终端修改标题。


## 参考资料

* [How to change Gnome-Terminal title?](https://askubuntu.com/questions/22413/how-to-change-gnome-terminal-title)





