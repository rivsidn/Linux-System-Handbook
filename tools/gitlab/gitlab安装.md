
## 搭建

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

添加用户并配置**西游记** 项目组，西游记项目组配置.

| 用户名 | 密码       | 权限      |
|--------|------------|-----------|
| 唐僧   | y123456789 | Owner     |
| 孙悟空 | y123456789 | Maintiner |
| 猪八戒 | y123456789 | developer |
| 沙僧   | y123456789 | developer |


### 添加代码仓库

**西游记**项目组中创建'gitlab-demo' 仓库.

- 创建'develop' 分支
- 设置默认分支为'develop'
- 创建分支规则，只允许'Maintiner' 提交代码到'develop'


完成这些配置之后:

- 默认`fork` 'develop' 分支
- 主线仓库只允许'Owner'、'Maintiner' 操作
- 'developer' 通过'Merge request'方式提交代码

