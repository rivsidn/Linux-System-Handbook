## vim调试

### 获取源码

```bash
git clone https://github.com/vim/vim.git
```



### 代码调试

* 使能`-g` 选项编译`vim`

  ```diff
  diff --git a/src/Makefile b/src/Makefile
  index cde2e5581..8e67f1349 100644
  --- a/src/Makefile
  +++ b/src/Makefile
  @@ -587,7 +587,7 @@ CClink = $(CC)
   # When using -g with some older versions of Linux you might get a
   # statically linked executable.
   # When not defined, configure will try to use -O2 for gcc and -O for others.
  -#CFLAGS = -g
  +CFLAGS = -g
   #CFLAGS = -O
   
   # Optimization limits - depends on the compiler.  Automatic check in configure
  @@ -1105,7 +1105,7 @@ INSTALL_DATA_R    = cp -r
   
   ### Program to run on installed binary.  Use the second one to disable strip.
   #STRIP = strip
  -#STRIP = /bin/true
  +STRIP = /bin/true
   
   ### Permissions for binaries  {{{1
   BINMOD = 755
  ```

* 开始调试

  如果直接通过`gdb vim` 进行调试，`vim` 的输出会覆盖`gdb`执行，这里采用的方式是`gdbserver`、`gdb` 调试分离的方式执行，配合`tmux`，在同一个窗口进行调试，具体命令如下。

  * `tmux`分屏

    ```bash
    tmux new-session -d -s "vim"
    tmux split-window -h
    tmux attach
    ```

  * `gdb`调试

    ```bash
    # 左侧执行
    gdbserver :1234 vim
    
    # 右侧执行
    gdb vim
    ```

  

  可以执行调试命令，左右两侧可以通过`Ctrl+b <ARROW>` 进行切换。

  



## 附录

### 参考资料

* [Debugging Vim](https://vimhelp.org/debug.txt.html#debug.txt)

