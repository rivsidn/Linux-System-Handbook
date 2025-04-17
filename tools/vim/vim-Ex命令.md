



## 源码剖析

`vim` 中的 `Ex` 命令，由数据结构表示。

```c
static struct cmdname
{
    char_u	*cmd_name;	// name of the command
    size_t	cmd_namelen;	// length of the command name
    ex_func_T   cmd_func;	// function for this command
    long_u	cmd_argt;	// flags declared above
    cmd_addr_T	cmd_addr_type;	// flag for address type
} cmdnames[] =
```





