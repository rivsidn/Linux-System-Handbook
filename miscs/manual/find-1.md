查找目录中文件。

```
find [-H] [-L] [-P] [-D debugopts] [-Olevel] [starting-point...] [expression]
```



## 选项



## 表达式

### 测试表达式



### 动作表达式



### 全局选项表达式

影响整个命令执行，总是返回 `true`。

| 表达式                 | 作用                                                         |
| ---------------------- | ------------------------------------------------------------ |
| -d                     | `-depth`的缩写，用于兼容其他操作系统                         |
| -depth                 | 优先处理目录内容，而后处理目录。<br/>`-delete` 自动添加 `-depth` 选项 |
| -help                  | 输出命令用法并退出                                           |
| -ignore_readdir_race   |                                                              |
| -max-depth levels      | 起始目录下降的最大深度                                       |
| -min-depth levels      | 其实目录下降的最小深度                                       |
| -mount                 |                                                              |
| -noignore_readdir_race |                                                              |
| -noleaf                |                                                              |
| -version, --version    |                                                              |
| -xdev                  |                                                              |



### 位置选项表达式

仅影响过之后的测试或者动作表达式，总是返回 `true`。

| 表达式          | 作用                 |
| --------------- | -------------------- |
| -daystart       | 测量时间，从今天开始 |
| -follow         | 已废弃               |
| -regextype type | 修改正则表达式类型   |
| -warn, -nowarn  | 开启或关闭告警       |



### 操作符表达式

