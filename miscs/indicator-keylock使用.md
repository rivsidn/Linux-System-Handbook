87键键盘的配列，大多数大小写指示器的灯都在键帽下，将指示器添加到屏幕上会比较容易看.

可以开启多个实例，每个实例标识一个lock键。

## 安装

```bash
sudo add-apt-repository ppa:tsbarnes/indicator-keylock
sudo apt-get update
sudo apt-get install indicator-keylock
```



## 设置

通常可以通过右键右上角图标的方式设置，当图标不小心隐藏之后，可以
通过安装`dconf-editor` 方式来重新设置开启，此时只需要将所有选项选中
即可。

```bash
sudo apt-get install dconf-editor
```



| 设置选项                                  | 作用                       |
| ----------------------------------------- | -------------------------- |
| Use an application indicator              | 右上角显示指示器           |
| Caps Lock                                 | 指示器类型(三选一)         |
| Num Lock                                  | 指示器类型(三选一)         |
| Scroll Lock                               | 指示器类型(三选一)         |
| Show indicator while lock key is inactive | 没激活的时候是否显示指示器 |

**附加：右键可以选中指示器图标**

**附加：默认开机启动，不需要单独设置**



## 附录

### 参考资料

* [Hidden (missing) indicator-keylock icon](https://askubuntu.com/questions/1164680/hidden-missing-indicator-keylock-icon)

