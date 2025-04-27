
## vimscript调试

### 进入调试模式

进入调试模式有三种方式：

1. 调试模式启动

   ```bash
   vim -D file.txt
   ```

2. 调试命令

   ```bash
   :debug edit test.txt.gz
   ```

3. 启动时设置断点

   ```bash
   vim -c "breakadd file */explorer.vim" 
   ```

### 指定脚本调试

```bash
vim -u test.vim
```

### 查看当前变量

调试过程中可以通过`echo` 命令查看变量.

```vim
echo g:global
echo s:script
```






### 参考资料

* [Repeating commands, Vim scripts and debugging](https://vimhelp.org/repeat.txt.html#debug-scripts)
