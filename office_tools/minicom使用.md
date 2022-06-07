## 连接串口

* 打开minicom

  ```bash
  sudo minicom
  ```

* 打开minicom配置页面

  * 先ctrl-A，松开之后再摁Z，打开minicom命令列表

  * 摁O 打开minicom 配置页面

    ```bash
                +-----[configuration]------+
                | Filenames and paths      |
                | File transfer protocols  |
                | Serial port setup        |
                | Modem and dialing        |
                | Screen and keyboard      |
                | Save setup as dfl        |
                | Save setup as..          |
                | Exit                     |
                +--------------------------+
    ```

* 选中`Serial port setup` 配置minicom

  ```bash
  OPTI+-----------------------------------------------------------------------+
  Comp| A -    Serial Device      : /dev/tty8                                 |
  Port| B - Lockfile Location     : /var/lock                                 |
      | C -   Callin Program      :                                           |
  Pres| D -  Callout Program      :                                           |
      | E -    Bps/Par/Bits       : 115200 8N1                                |
      | F - Hardware Flow Control : Yes                                       |
      | G - Software Flow Control : No                                        |
      |                                                                       |
      |    Change which setting?                                              |
      +-----------------------------------------------------------------------+
              | Screen and keyboard      |
              | Save setup as dfl        |
              | Save setup as..          |
              | Exit                     |
              +--------------------------+
  ```

  **注意：** 有次由于没选中`Hardware Flow Control` 设置为 Yes，导致串口不能输入

* 配置之后确定，选中`Save setup as dfl` 保存，后续直接打开minicom就可以访问串口不需要再次配置。

* `minicom` 退出，打开`minicom` ，摁`x` 确定，退出



## 常用配置

### 保存交互日志

* 先ctrl-A，松开之后再摁Z，打开minicom命令列表

* 选择 `Capture on/off.....L` ，设置文件确定即可

* 退出时操作与上述步骤基本一致，首先进入命令列表，选中日志配置选项，此时会有三个选择，如下

  ```
                               +--------------------------------+                
                               |          Capture file          |                
                               |    Close    Pause      Exit    |                
                               +--------------------------------+                
  ```

  **Close :** 关闭文件

  **Pause :** 暂定日志记录

  **Exit : ** 不做设置，退出

### 脚本自动登录

* 设置脚本路径

  * `ctrl+a o`进入到 `Filenames and paths` 中设置
  * 设置之后保存配置文件

* 添加脚本到`/etc/minicom` 下

  ```tcl
  send	administrator
  expect	"Password:"
  send	xxxxxx
  
  send	switchtodebug
  expect	"Enter debug password:"
  send	xxxxxx
  ```

* `ctrl+a g` 设置脚本名称，回车运行

### 配置文件

* 保存配置文件，可以选择保存模式配置文件或者指定文件名

* 设置配置文件，如果没设置则使用默认配置

  ```bash
  sudo minicom [configuration]
  ```



## 附录









