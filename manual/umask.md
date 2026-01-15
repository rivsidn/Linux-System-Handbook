
设置创建文件时候的屏蔽掩码.

举例说明:

```c
//mask 为 002
open("new_file.txt", O_RDONLY|O_CREAT, 0777);
```

最终权限为:

```bash
mode = 0777 & (~002) = 0775
```

即将other write 权限屏蔽了.

