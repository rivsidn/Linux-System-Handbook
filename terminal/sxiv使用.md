
## 简介

工具分成两个模式，图片模式和浏览模式。

图片模式就是图片查看模式，浏览模式就是展示图片缩略图，用于选择图片。

### 参数

| 参数 | 说明                     |
|------|--------------------------|
| -f   | 开启全屏模式             |
| -r   | 搜索目录下所有图片并打开 |
| -Z   | 设置放到率100%           |

### 快捷键

#### 通用快捷键

| 快捷键 | 说明                 |
|--------|----------------------|
| q      | 程序退出             |
| f      | 全屏模式             |
| g      | 跳转到第一张图片     |
| G      | 跳转到最后一张图片   |
| D      | 删除当前图片         |
| Ctrl-h | 滚动到最左侧         |
| Ctrl-l | 滚动到最右侧         |
| m      | 标记/取消标记        |
| M      | 翻转所有标记         |
| N      | 跳转到标记的图片     |
| P      | 向后跳转到标记的图片 |

#### 浏览模式快捷键

| 快捷键 | 说明     |
|--------|----------|
| h      | 向左移动 |
| j      | 向下移动 |
| k      | 向上移动 |
| l      | 向右移动 |

#### 图片模式快捷键

| 快捷键 | 说明     |
|--------|----------|
| n      | 向前跳转 |
| p      | 向后跳转 |


### bash封装

封装`sxiv` 命令，后台执行.

```bash
function sxiv() {
	command sxiv "$@" 2>&1 &
}
```


## 附录

### man手册

```man
SXIV(1)                                                                          General Commands Manual                                                                          SXIV(1)

NAME
       sxiv - Simple X Image Viewer
            - 简单的图片浏览器

SYNOPSIS
       sxiv [-abcfhiopqrtvZ] [-A FRAMERATE] [-e WID] [-G GAMMA] [-g GEOMETRY] [-N NAME] [-n NUM] [-S DELAY] [-s MODE] [-z ZOOM] FILE...

DESCRIPTION
       sxiv is a simple image viewer for X.

       It  has  two modes of operation: image and thumbnail mode. The default is image mode, in which only the current image is shown. In thumbnail mode a grid of small previews is displayed, making it easy to choose an image to open.

       Please note, that the fullscreen mode requires an EWMH/NetWM compliant window manager.

OPTIONS
       -A FRAMERATE
              Play animations with a constant frame rate set to FRAMERATE.
              幻灯片模式，以一定速率显示图片.

       -a     Play animations of multi-frame images.
              播放多帧图片.

       -b     Do not show info bar on bottom of window.
              不显示info 信息.

       -c     Remove all orphaned cache files from the thumbnail cache directory and exit.
              删除所有的孤儿缓存文件并退出.

       -e WID Embed sxiv's window into window whose ID is WID.
              嵌入到已有窗口.

       -f     Start in fullscreen mode.
              全屏模式开启.

       -G GAMMA
              Set image gamma to GAMMA (-32..32).
              调整图片GAMMA.

       -g GEOMETRY
              Set window position and size. See section GEOMETRY SPECIFICATIONS of X(7) for more information on GEOMETRY argument.
              设置窗口位置和大小.

       -N NAME
              Set the resource name of sxiv's X window to NAME.

       -n NUM Start at picture number NUM.
              设置启动图片号.

       -h     Print brief usage information to standard output and exit.

       -i     Read names of files to open from standard input. Also done if FILE is `-'.
              从标准输入读取图片.

       -o     Write list of all marked files to standard output when quitting. In combination with -i sxiv can be used as a visual filter/pipe.

       -p     Enable private mode, in which sxiv does not write any cache or temporary files.

       -q     Be quiet, disable warnings to standard error stream.

       -r     Search the given directories recursively for images to view.
              搜索目录下所有图片打开.

       -S DELAY
              Start in slideshow mode. Set the delay between images to DELAY seconds.  DELAY may be a floating point number.
              启动滑动显示模式.

       -s MODE
              Set scale mode according to MODE character. Supported modes are: [d]own, [f]it, [w]idth, [h]eight.

       -t     Start in thumbnail mode.
              启动thumbnail 模式.

       -v     Print version information to standard output and exit.
              显示版本信息.

       -Z     The same as `-z 100'.

       -z ZOOM
              Set zoom level to ZOOM percent.
              显示放大率.

KEYBOARD COMMANDS
   General
       The following keyboard commands are available in both image and thumbnail mode:
       所有模式都支持.

       0-9    Prefix the next command with a number (denoted via count).

       q      Quit sxiv.
              退出 sxiv.

       Return Switch to thumbnail mode / open selected image in image mode.
       回车在thumbnail模式/select image 模式之间切换.

       f      Toggle fullscreen mode.
              全屏模式.

       b      Toggle visibility of info bar on bottom of window.
              切换下边的信息是否显示.

       Ctrl-x Send the next key to the external key-handler. See section EXTERNAL KEY HANDLER for more information.

       g      Go to the first image.
              跳转到第一张图片.

       G      Go to the last image, or image number count.
              跳转到最后一张图片.

       r      Reload image.
              重新加载图片.

       D      Remove current image from file list and go to next image.
              删除当前图片，跳转到下一张图片.

       Ctrl-h, Ctrl-Left
              Scroll left one screen width.

       Ctrl-j, Ctrl-Down
              Scroll down one screen height.

       Ctrl-k, Ctrl-Up
              Scroll up one screen height.

       Ctrl-l, Ctrl-Right
              Scroll right one screen width.

       +      Zoom in.

       -      Zoom out.

       m      Mark/unmark the current image.

       M      Reverse all image marks.

       Ctrl-M Repeat last mark action on all images from the last marked/unmarked up to the current one.

       Ctrl-m Remove all image marks.

       N      Go count marked images forward.
              跳转到标记的图片.

       P      Go count marked images backward.

       {      Decrease gamma correction by count steps.

       }      Increase gamma correction by count steps.

       Ctrl-g Reset gamma correction.

   Thumbnail mode
       The following keyboard commands are only available in thumbnail mode:

       h, Left
              Move selection left count times.

       j, Down
              Move selection down count times.

       k, Up  Move selection up count times.

       l, Right
              Move selection right count times.

       R      Reload all thumbnails.

   Image mode
       The following keyboard commands are only available in image mode:

       Navigate image list:

       n, Space
              Go count images forward.
              向前跳转.

       p, Backspace
              Go count images backward.
              向后跳转.

       [      Go count * 10 images backward.

       ]      Go count * 10 images forward.

       Handle multi-frame images:

       Ctrl-n Go count frames of a multi-frame image forward.

       Ctrl-p Go count frames of a multi-frame image backward.

       Ctrl-Space
              Play/stop animations of multi-frame images.

       Panning:

       h, Left
              Scroll image 1/5 of window width or count pixel left.

       j, Down
              Scroll image 1/5 of window height or count pixel down.

       k, Up  Scroll image 1/5 of window height or count pixel up.

       l, Right
              Scroll image 1/5 of window width or count pixel right.

       H      Scroll to left image edge.

       J      Scroll to bottom image edge.

       K      Scroll to top image edge.

       L      Scroll to right image edge.

       Zooming:

       =      Set zoom level to 100%, or count%.

       w      Set zoom level to 100%, but fit large images into window.

       W      Fit image to window.

       e      Fit image to window width.

       E      Fit image to window height.

       Rotation:

       <      Rotate image counter-clockwise by 90 degrees.

       >      Rotate image clockwise by 90 degrees.

       ?      Rotate image by 180 degrees.

       Flipping:
       图像翻转:

       |      Flip image horizontally.
              水平翻转.

       _      Flip image vertically.
              垂直翻转.

       Miscellaneous:

       a      Toggle anti-aliasing.

       A      Toggle visibility of alpha-channel, i.e. image transparency.

       s      Toggle slideshow mode and/or set the delay between images to count seconds.

MOUSE COMMANDS
       The following mouse mappings are available in image mode:

       General:

       Button3
              Switch to thumbnail mode.

       Navigate image list:

       Button1
              Go to the next image if the mouse cursor is in the right part of the window or to the previous image if it is in the left part.

       Panning:

       Button2
              Pan the image according to the mouse cursor position in the window while keeping this button pressed down.

       Zooming:

       ScrollUp
              Zoom in.

       ScrollDown
              Zoom out.

CONFIGURATION
       The following X resources are supported:
       支持修改配置:

       background
              Color of the window background and bar foreground

       foreground
              Color of the window foreground and bar background

       font   Name of Xft bar font

       Please see xrdb(1) on how to change them.

STATUS BAR
       The information displayed on the left side of the status bar can be replaced with the output of a user-provided script, which is called by sxiv whenever an image gets loaded. The path of this script is $XDG_CONFIG_HOME/sxiv/exec/image-info and the arguments given to it are: 1) path to image file, 2) image width, 3) image height.

       There is also an example script installed together with sxiv as /usr/share/sxiv/exec/image-info.

EXTERNAL KEY HANDLER
       Additional external keyboard commands can be defined using a handler program located in $XDG_CONFIG_HOME/sxiv/exec/key-handler.  The handler is invoked by pressing  Ctrl-x.   The next key combo is passed as its first argument. Passed via stdin are the images to act upon, one path per line: all marked images, if in thumbnail mode and at least one image has been marked, otherwise the current image.  sxiv(1) will block until the handler terminates. It then checks which images have been modified and reloads them.
       会将执行的文件传输给key-handler 脚本处理，如果文件被修改，会被重新加载.

       The  key  combo  argument  has  the  following  form:  "[C-][M-][S-]KEY",  where C/M/S indicate Ctrl/Meta(Alt)/Shift modifier states and KEY is the X keysym as listed in /usr/include/X11/keysymdef.h without the "XK_" prefix.

       There is also an example script installed together with sxiv as /usr/share/sxiv/exec/key-handler.

THUMBNAIL CACHING
       sxiv stores all thumbnails under $XDG_CACHE_HOME/sxiv/.

       Use the command line option -c to remove all orphaned cache files. Additionally, run the following command afterwards inside the cache directory to remove empty subdirectories:

              find . -depth -type d -empty ! -name '.' -exec rmdir {} \;

AUTHOR
       Bert Muennich   <ber.t at posteo.de>

CONTRIBUTORS
       Bastien Dejean  <nihilhill at gmail.com>
       Dave Reisner    <d at falconindy.com>
       Fung SzeTat     <sthorde at gmail.com>
       Max Voit        <mvdev at with-eyes.net>

HOMEPAGE
       https://github.com/muennich/sxiv

SEE ALSO
       X(7), xrdb(1)

                                                                                         sxiv-26                                                                                  SXIV(1)
```
