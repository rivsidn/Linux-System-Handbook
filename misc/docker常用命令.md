## 容器

### 运行容器

```bash
# 启动参数
sudo docker run -i -t ubuntu /bin/bash
```

| 参数 | 解释 |
| ---- | ---- |
| -i   |      |
| -t   |      |
|      |      |
|      |      |

### 重新启动容器

```bash
# 启动已经存在的容器
sudo docker start <name|ID>
# 绑定到启动的容器
sudo docker attach <name|ID>
```

### 查看容器

```bash
# 查看正在运行的容器
sudo docker ps
# 查看所有容器
sudo docker ps -a
# 查看最后一次运行的容器
sudo docker ps -l
```

### 删除容器

```bash
sudo docker rm <name|ID>
```

### 容器内安装软件

```bash
# 安装前必须要先更新软件源
sudo apt update
sudo apt-get install iproute2
```



## 镜像

### 构建镜像(一)

```bash
# 提交本地经过修改的容器作为镜像
sudo docker commit <ID> <repository>/<name>
```

### 构建镜像(二)