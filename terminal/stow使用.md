
## 安装

```bash
sudo apt install stow 
```

## 使用

### 目录结构

```
.
└──── bash
       └── .bashrc
```


### 安装

```bash
# 安装
stow -t $HOME bash
```

该命令执行之后，会在 $HOME 下创建 .bashrc 的软链接.

### 卸载

```bash
# 卸载
stow -D $HOME bash
```

## 附录

### 进阶工具

- chezmoi 工具

