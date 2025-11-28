
### 安装

```bash
sudo apt install x11vnc -y
```

### 设置密码

```bash
x11vnc -storepasswd
```

### 启动

```bash
x11vnc -forever -usepw -display :0
```


**注意:x11vnc 在wayland 下不能使用，需要切换到Xorg.**

切换方式，退出登陆，输入密码界面找到右下角齿轮图表，点击选贼 'Ubuntu on Xorg' .

