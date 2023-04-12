暂时整理三种方式。

### :!cmd

```bash
# 执行
:!ifconfig en0
# 重复执行上边命令
:!!
```



### C-Z

原理：

* 挂起当前`vim` 到后台并进入`shell`
* `fg` 切换回`shell`



### :shell

原理：

* `vim` 中运行出一个`shell`
* 执行结束之后`Ctrl+D` 关闭`shell` 回到`vim`





### 参考资料

* [在Vim中执行Shell命令](https://harttle.land/2017/02/04/run-shell-within-vim.html)