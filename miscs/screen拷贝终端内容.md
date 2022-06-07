
```bash
sudo apt-get install screen
```

通过`srceen` 拷贝终端中内容操作步骤如下：

1. 开启 `screen`，直接执行`screen` 或者 `screen command`
2. 运行程序，产生输出
3. 进入拷贝模式：`control`+`a`+`[`
4. 敲`Enter`
5. 移动光标，到末尾位置
6. 敲`Enter`
7. `control`+`a`+`]` 粘贴



终端启动时候自动运行`screen` ，`.bashrc` 中添加下边这行：

```bash
[[ $TERM = "xterm-256color" ]] && exec screen -q
```



设置`.srceenrc` 文件：

```bash
# 关闭启动消息
startup_message off
```



但是在 srceen 中启动`vim` 之后，会导致`vim` 配色方案改变，暂时没找到解决方案。



只能在同一个 screen 中拷贝内容，使用意义不大。

