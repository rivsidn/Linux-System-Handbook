通过硬盘装一个ubunutu系统，替换内核，装上systemtap等调试工具，放到设备上运行，方便定位设备调试，定位性能问题，跟踪代码等。



## 内核编译

### 内核下载

```bash
git clone git://kernel.ubuntu.com/ubuntu/ubuntu-xenial.git

# 切换到4.4 版本编译
git checkout Ubuntu-4.4.0-0.10
```



### 版本编译

```bash
# 具体的编译方式可以参照官方文档
```

**注意：在ubuntu版本下编译对应版本的内核。**



### 编译问题

1. 报错 `gcc: error: unrecognized command line option ‘--fno-pie’; did you mean ‘-fno-pie’?`

   解决方案：

   ```makefile
   root@rivsidn:/home/yuchao/Downloads/xenial# git diff
   diff --git a/Makefile b/Makefile
   index 91220b550985..78e4cf7d3265 100644
   --- a/Makefile
   +++ b/Makefile
   @@ -401,7 +401,7 @@ KBUILD_CFLAGS   := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
                      -fno-strict-aliasing -fno-common \
                      -Werror-implicit-function-declaration \
                      -Wno-format-security \
   -                  -std=gnu89
   +                  -std=gnu89 -fno-pie
   ```






## 附录

### 参考资料

* [BuildYourOwnKernel](https://wiki.ubuntu.com/Kernel/BuildYourOwnKernel#Debug_Symbols)
* [Debug Symbol Packages](https://wiki.ubuntu.com/Debug%20Symbol%20Packages)
* [KernelGitGuide](https://wiki.ubuntu.com/Kernel/Dev/KernelGitGuide)
