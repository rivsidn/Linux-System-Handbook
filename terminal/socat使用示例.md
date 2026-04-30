
该脚本用于本地创建一个telnet 文件，通过读、写telnet 文件，实现与远端telnet 通信效果.

## 脚本

```bash
#! /bin/bash

rm -f telnet.in telnet.out telnet.pid

mkfifo telnet.in
touch  telnet.out

socat EXEC:"telnet 172.20.20.2 5000",pty,setsid,ctty,raw,echo=0 \
  SYSTEM:"exec 3<&0; cat <&3 >> telnet.out & while true; do cat telnet.in; done | sed -u 's/$/\\r/'" &

echo $! > telnet.pid

```

```bash
exec 3<&0; cat <&3 >> telnet.out & while true; do cat telnet.in; done | sed -u 's/$/\\r/'
```

TODO: 没看懂怎么实现的....


## 附录


```markdown
1. 准备输入 FIFO 和输出文件

```bash
cd ~/AI/ask-connector

rm -f telnet.in telnet.out telnet.pid
mkfifo telnet.in
: > telnet.out
```

2. 启动 socat 桥接

```bash
socat -d -d \
  EXEC:"telnet 172.20.20.2 5000",pty,setsid,ctty,raw,echo=0 \
  SYSTEM:"exec 3<&0; cat <&3 >> telnet.out & while true; do cat telnet.in; done | sed -u 's/$/\\r/'" &
```

保存 PID：

```bash
echo $! > telnet.pid
```

这里的作用是：

- telnet.in：你往这里写命令
- telnet.out：远端输出会追加到这里
- while true; do cat telnet.in; done：每次 echo > telnet.in 后重新打开 FIFO
- sed -u 's/$/\r/'：把每行转换成 telnet/串口常用的回车
- cat <&3 >> telnet.out：把 telnet 输出保存到文件

3. 查看连接输出

```bash
sleep 1
cat telnet.out
```

如果看到类似：

Trying 172.20.20.2...
Connected to 172.20.20.2.
Escape character is '^]'.

说明已经连上。

4. 如果还没登录

先看 telnet.out 里是不是有：

node1 login:

如果有，再输入：

```bash
echo "clab" > telnet.in
sleep 1
echo "clab@123" > telnet.in
sleep 2
cat telnet.out
```

如果已经看到：

clab@node1:~$

就不用再登录了。

5. 执行命令并读取结果

```bash
: > telnet.out
echo "pwd" > telnet.in
sleep 1
cat telnet.out
```

或者：

```bash
: > telnet.out
echo "echo CODEX_OK; whoami; pwd" > telnet.in
sleep 1
cat telnet.out
```

应该能看到类似：

CODEX_OK
clab
/home/clab

6. 停止

```bash
kill "$(cat telnet.pid)"
rm -f telnet.in telnet.pid
```

所以这次的报错不是 socat 连不上，而是你少了这一步：

mkfifo telnet.in

并且建议用我这版修正后的 SYSTEM:"exec 3<&0; ..." 命令。

```

### AI

› socat EXEC:"telnet 172.20.20.2 5000",pty,setsid,ctty,raw,echo=0 \
    SYSTEM:"exec 3<&0; cat <&3 >> telnet.out & while true; do cat telnet.in; done | sed -u 's/$/\\r/'" &

  给我解释一下这条命令


• 这条命令的作用是：

  把 telnet 会话包装成两个本地文件：
  telnet.in   写入命令
  telnet.out  保存输出

  完整命令：

  socat EXEC:"telnet 172.20.20.2 5000",pty,setsid,ctty,raw,echo=0 \
    SYSTEM:"exec 3<&0; cat <&3 >> telnet.out & while true; do cat telnet.in; done | sed -u 's/$/\\r/'" &

  它等价于搭了这样一条链路：

  echo "pwd" > telnet.in
          ↓
        socat
          ↓
  telnet 172.20.20.2 5000
          ↓
       远端输出
          ↓
      telnet.out

  ———

  先看 socat 的基本结构

  socat 有两个端点：

  socat 端点A 端点B

  你这条命令里：

  端点A = EXEC:"telnet 172.20.20.2 5000",pty,setsid,ctty,raw,echo=0
  端点B = SYSTEM:"exec 3<&0; cat <&3 >> telnet.out & while true; do cat telnet.in; done | sed -u 's/$/\\r/'"

  socat 会在这两个端点之间双向转发数据。

  ———

  端点 A：启动 telnet

  这一段：

  EXEC:"telnet 172.20.20.2 5000",pty,setsid,ctty,raw,echo=0

  表示让 socat 启动一个子进程：

  telnet 172.20.20.2 5000

  后面的参数含义是：

  pty       给 telnet 分配一个伪终端
  setsid    让 telnet 运行在新的 session 中
  ctty      把这个 pty 作为 telnet 的控制终端
  raw       原始模式，减少终端特殊处理
  echo=0    关闭本地回显

  为什么不用直接 TCP:172.20.20.2:5000？

  因为你的目标是 Telnet 控制台，telnet 客户端会处理 Telnet 协议协商。用 EXEC:"telnet ..." 更稳。

  ———

  端点 B：SYSTEM 这部分最关键

  这一段：

  SYSTEM:"exec 3<&0; cat <&3 >> telnet.out & while true; do cat telnet.in; done | sed -u 's/$/\\r/'"

  socat 会启动一个 shell 来执行这段命令。

  在这个 SYSTEM 里：

  - 标准输入 stdin：来自 telnet 的输出
  - 标准输出 stdout：会被发回 telnet

  也就是说：

  SYSTEM 的 stdin  ← telnet 输出
  SYSTEM 的 stdout → telnet 输入

  ———

  1. exec 3<&0

  exec 3<&0

  这句是把当前标准输入复制到文件描述符 3。

  当前标准输入就是：

  telnet 返回的数据

  所以执行后：

  fd 0 = telnet 输出
  fd 3 = telnet 输出的副本

  这样后面就可以用 fd 3 专门读取远端输出。

  ———

  2. cat <&3 >> telnet.out &

  cat <&3 >> telnet.out &

  这句在后台启动一个 cat：

  从 fd 3 读取 telnet 输出
  追加写入 telnet.out

  也就是：

  远端输出 → telnet.out

  末尾的 & 表示这个 cat 在后台持续运行。

  所以你可以用：

  cat telnet.out

  查看远端输出。

  ———

  3. while true; do cat telnet.in; done

  while true; do cat telnet.in; done

  这里假设 telnet.in 是 FIFO 管道，不是普通文件。

  需要提前创建：

  mkfifo telnet.in

  为什么要 while true？

  因为你执行：

  echo "pwd" > telnet.in

  时，过程是：

  打开 telnet.in
  写入 pwd
  关闭 telnet.in

  如果只写：

  cat telnet.in

  那么 echo 写完关闭后，cat 会收到 EOF，然后退出。

  所以要包一层：

  while true; do cat telnet.in; done

  这样每次 echo > telnet.in 结束后，它会重新等待下一次写入。

  ———

  4. sed -u 's/$/\\r/'

  sed -u 's/$/\\r/'

  这句的作用是给每一行末尾补一个回车符 \r。

  比如你执行：

  echo "pwd" > telnet.in

  echo 实际写入的是：

  pwd\n

  经过 sed 后，大致变成：

  pwd\r\n

  很多 telnet、串口、控制台设备需要 \r 或 \r\n 才会认为你按了回车。

  -u 表示 unbuffered，尽量不要缓冲，写入后更快发出去。

  ———

  5. 最后的 &

  整条命令最后有一个：

  &

  表示把整个 socat 放到后台运行。

  所以你可以继续在当前终端执行：

  echo "pwd" > telnet.in
  cat telnet.out

  ———

  完整使用流程

  先准备文件：

  cd ~/AI/ask-connector

  rm -f telnet.in telnet.out telnet.pid
  mkfifo telnet.in
  : > telnet.out

  启动桥接：

  socat EXEC:"telnet 172.20.20.2 5000",pty,setsid,ctty,raw,echo=0 \
    SYSTEM:"exec 3<&0; cat <&3 >> telnet.out & while true; do cat telnet.in; done | sed -u 's/$/\\r/'" &

  保存进程号：

  echo $! > telnet.pid

  发送命令：

  echo "pwd" > telnet.in

  查看输出：

  cat telnet.out

  如果只想看本次输出，可以先清空：

  : > telnet.out
  echo "pwd" > telnet.in
  sleep 1
  cat telnet.out

  停止：

  kill "$(cat telnet.pid)"
  rm -f telnet.in telnet.pid

  ———

  简单总结：

  EXEC:"telnet ..."

  负责真正连接远端 telnet。

  cat <&3 >> telnet.out &

  负责把远端输出保存到 telnet.out。

  while true; do cat telnet.in; done

  负责不断读取你写入 telnet.in 的命令。

  sed -u 's/$/\\r/'

  负责把普通换行转换成 telnet 控制台需要的回车。
