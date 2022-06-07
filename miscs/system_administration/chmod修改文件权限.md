## 修改文件权限

### 权限解释

| 权限 | 文件         | 目录                  |
| ---- | ------------ | --------------------- |
| r    | 可以读文件   | 可以`ls` 查看目录内容 |
| w    | 可以写文件   | 可以修改目录内容      |
| x    | 可以执行文件 | 可以`cd` 进入目录     |



### 修改权限

| 访问用户             | 操作符               | 访问类型    |
| -------------------- | -------------------- | ----------- |
| u (user)             | + (add access)       | r (read)    |
| g (group)            | - (remove access)    | w (write)   |
| o (other)            | = (set exact access) | x (execute) |
| all (all: u,g and o) |                      |             |





## 参考资料

* [Manage file permissions on Unix-like systems](https://kb.iu.edu/d/abdb)