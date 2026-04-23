
## 搭建

### 配置代理

```
[Service]
Environment="HTTP_PROXY=http://127.0.0.1:1081"
Environment="HTTPS_PROXY=http://127.0.0.1:1081"
Environment="NO_PROXY=localhost,127.0.0.1"
```

重启docker服务.

```bash
sudo systemctl daemon-reload
sudo systemctl restart docker.service
```

### 下载docker

`docker-compose.yml` 文件.

```yml
services:
  gitlab:
    image: gitlab/gitlab-ce:latest
    container_name: gitlab
    restart: always
    hostname: gitlab.local
    ports:
      - "8929:8929"
      - "8443:443"
      - "2224:22"
    volumes:
      - "./gitlab/config:/etc/gitlab"
      - "./gitlab/logs:/var/log/gitlab"
      - "./gitlab/data:/var/opt/gitlab"
    shm_size: "256m"
    environment:
      GITLAB_OMNIBUS_CONFIG: |
        external_url 'http://localhost:8929'
        gitlab_rails['gitlab_shell_ssh_port'] = 2224
```

| 命令                   | 说明                       |
|------------------------|----------------------------|
| docker compose up -d   | 启动容器，镜像不存在则创建 |
| docker compose start   | 启动容器                   |
| docker compose stop    | 停止容器                   |
| docker compose restart | 停止容器                   |
| docker compose down    | 停止容器并删镜像           |


访问端口 `http://localhost:8929 .


```bash
$ sudo cat config/initial_root_password

Password: 1GKf4EC+BVxa+lJ6PowxCAX42FAcJTqk6mpkE0cwv+Q=
```

查看初始化密码.

## 配置

### 添加用户

```
唐僧
  ├── 孙悟空
  ├── 猪八戒
  └── 沙僧
```

添加用户并配置**xiyouji** 项目组.

### 添加代码仓库

**xiyouji**项目组中创建'gitlab-demo' 仓库.



