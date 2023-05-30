希望通过捕获键鼠动作，结合`xdotool` 实现自动化。

## 安装使用

* 安装

  ```bash
  sudo apt-get install evtest
  ```

* 使用

  ```bash
  # 通过编号选择对应设备
  $ sudo evtest 
  No device specified, trying to scan all of /dev/input/event*
  Available devices:
  /dev/input/event0:	Sleep Button
  /dev/input/event1:	Power Button
  /dev/input/event2:	Power Button
  /dev/input/event3:	Video Bus
  /dev/input/event4:	HDA Intel PCH Front Mic
  /dev/input/event5:	HDA Intel PCH Rear Mic
  /dev/input/event6:	HDA Intel PCH Line
  /dev/input/event7:	HDA Intel PCH Line Out
  /dev/input/event8:	HDA Intel PCH Front Headphone
  /dev/input/event9:	HDA Intel PCH HDMI/DP,pcm=3
  /dev/input/event10:	HDA Intel PCH HDMI/DP,pcm=7
  /dev/input/event11:	HDA Intel PCH HDMI/DP,pcm=8
  /dev/input/event12:	HID 046a:0011
  /dev/input/event13:	PixArt Dell MS116 USB Optical Mouse
  Select the device event number [0-13]: 
  
  # 直接指定对应设备
  $ sudo evtest /dev/input/event0
  ```



## 键盘输出示例

```bash

```





## 附录

* `libinput-tools` 追踪设备输入

  ```bash
  # 安装
  sudo apt-get install libinput-tools
  # 使用
  sudo libinput-debug-events
  ```

  可以同时追踪多个设备输入。

