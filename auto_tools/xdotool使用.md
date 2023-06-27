`xdotool` 是一个自动化工具，可以用于模拟鼠标、键盘、操作窗口等一系列操作。



## 安装

```bash
sudo apt-get install xdotool
```

## 使用示例

### 示例一

```bash
# 查找桌面0的终端
xdotool search --desktop 0 --classname terminal
```

### 示例二

```bash
#! /bin/bash

# 分别查找桌面0、桌面3上的终端
term0=$(xdotool search --desktop 0 --classname terminal)
term3=$(xdotool search --desktop 3 --classname terminal)

# 提前执行Return 是为了清空当前屏幕存在的脏数据，避免影响命令执行
function xdotool_type()
{
	xdotool key Return
	xdotool type "$*"
	xdotool key Return
}
function xdotool_type_noclear()
{
	xdotool type "$*"
	xdotool key Return
}
# 切换终端
xdotool windowactivate --sync ${term0}
xdotool key alt+1	# 切换tab页
xdotool windowactivate --sync ${term3}
xdotool key alt+2	# 同上
```







## 命令行

```bash
xdotool cmd args...
```

### 键盘命令

| 命令    | 语法                                        | 说明             |
| ------- | ------------------------------------------- | ---------------- |
| key     | key [options] keystroke [keystroke ...]     | 键盘输入         |
| keydown | keydown [options] keystroke [keystroke ...] | 仅仅发送摁下事件 |
| keyup   | keyup [options] keystroke [keystroke ...]   | 仅仅发送松开事件 |
| type    | type [options] keystroke [keystroke ...]    |                  |



| options              | 说明                     |
| -------------------- | ------------------------ |
| --window windowid    | 向特定的窗口发送摁键命令 |
| --delay milliseconds | 摁键时间间隔，默认12ms   |
| --clearmodifiers     | 摁键前清空修改符         |

### 鼠标命令

| 命令               | 语法                                           | 说明                                                         |
| ------------------ | ---------------------------------------------- | ------------------------------------------------------------ |
| mousemove          | mousemove [options] x y OR 'restore'           | 鼠标移动操作                                                 |
| mousemove_relative | mousemove_relative [options] x y               | 移动鼠标相对位置                                             |
| click              | click [options] button                         | 鼠标点击动作，依次为：<br />左键、中间、右键、滚轮上、滚轮下 |
| mousedown          | mousedown [options] button                     | 仅仅发送鼠标摁下事件                                         |
| mouseup            | mouseup [options] button                       | 仅仅发送鼠标松开事件                                         |
| getmouselocation   | getmouselocation [--shell]                     | 输出鼠标所在位置，x、y、屏幕、窗口                           |
| behave_screen_edge | behave_screen_edge [options] where command ... | 为鼠标点击屏幕边缘或角落的时候触发一个事件                   |
|                    | --delay MILLISECONDS                           | 鼠标在特定位置停留一段时间后才执行命令                       |
|                    | --quiesce MILLISECONDS                         | 运行命令之前等待一定时间                                     |



| options          | 说明                 |
| ---------------- | -------------------- |
| --window WINDOW  | 指定鼠标移动到的窗口 |
| --screen SCREEN  | 移动鼠标到特定屏幕   |
| --polar          | 使用极坐标系         |
| --clearmodifiers |                      |
| --sync           | 发送后等待鼠标移动   |
| --repeat REPEAT  | 重复点击次数         |



### 窗口命令

| 命令              | 语法                                              | 说明                                 |
| ----------------- | ------------------------------------------------- | ------------------------------------ |
| search            | search [options] pattern                          | 窗口查询，查询结果会存在**窗口栈中** |
|                   | --class                                           | 匹配窗口类                           |
|                   | --classname                                       | 匹配窗口名称                         |
|                   | --maxdepth N                                      | 设置查询深度                         |
|                   | --name                                            | 匹配名称                             |
|                   | --onlyvisible                                     | 仅仅显示可见的窗口                   |
|                   | --pid PID                                         | 匹配特定PID的窗口                    |
|                   | --screen N                                        | 选择特定屏幕的窗口                   |
|                   | --desktop N                                       | 匹配特定桌面的窗口                   |
|                   | --limit N                                         | 匹配数量限制                         |
|                   | --title                                           | 废弃，参见--name                     |
|                   | --all                                             | 需要匹配所有条件                     |
|                   | --any                                             | 需要匹配任意条件                     |
|                   | --sync                                            | 阻塞直到能有结果                     |
| selectwindow      |                                                   | 通过点击获取窗口id                   |
|                   | behave window action command ...                  | 窗口事件绑定一个动作                 |
| getwindowpid      | getwindowpid [window]                             | 获取窗口的pid                        |
| getwindowname     | getwindowname [window]                            | 获取窗口名                           |
| getwindowgeometry | getwindowgeometry [options] [window]              | 获取窗口几何信息                     |
| getwindowfocus    | getwindowfocus [-f]                               | 获取窗口id                           |
| windowsize        | windowsize [options] [window] width height        | 设置窗口大小                         |
|                   | --usehints                                        |                                      |
|                   | --sync                                            | 同步                                 |
| windowmove        | windowmove [options] [window] x y                 | 窗口移动操作                         |
| windowfocus       | windowfocus [options] [window]                    |                                      |
| windowmap         | windowmap [options] [window]                      |                                      |
| windowminimize    |                                                   | 窗口最小化                           |
| windowraise       |                                                   | 移动到最前                           |
| windowreparent    | windowreparent [source_window] destination_window | 窗口重新排序                         |
| windowclose       | windowclose [windows]                             | 关闭窗口                             |
| windowkill        | windowkill [windows]                              |                                      |
| windowunmap       |                                                   | 窗口不可见                           |
| set_window        |                                                   | 设置窗口属性                         |



### 桌面和窗口等命令

| 命令                   | 说明                    |
| ---------------------- | ----------------------- |
| getactivewindow        | 输出当前活跃窗口        |
| set_desktop            | workspace切换           |
| get_desktop            | 输出当前workspace       |
| set_desktop_for_window | 移动窗口到特定workspace |
| get_desktop_for_window | 获取特定窗口的workspace |



### 其他命令

| 命令                         | 说明                   |
| ---------------------------- | ---------------------- |
| exec [options] command [...] | 执行程序               |
| sleep seconds                | 等待一定时间，支持小数 |



## 脚本

允许执行脚本。



## 附录

### 参考资料

* [发现一个xdotool，是个神器](https://www.cnblogs.com/winafa/p/14230029.html)



