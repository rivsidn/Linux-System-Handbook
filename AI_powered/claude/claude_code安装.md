

## claude_code安装

### 安装

`claude_code`本地安装.

```bash
# 创建全局路径
mkdir "${HOME}/.npm-global"
npm config set prefix "${HOME}/.npm-global"
echo 'export PATH=$HOME/.npm-global/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
# 重新安装
npm install -g @anthropic-ai/claude-code
```

### 激活前期准备

激活重点需要解决两个问题：
1. 国外信用卡
2. 激活手机号


#### 国外信用卡

国外信用卡可以通过[wildcard](https://yeka.ai/pay-service) 申请获得，充值，使用即
可.

#### 激活手机号

激活手机号可以通过`wildcard`的[海外手机号](https://yeka.ai/sms) 业务，也可以通过
[sms-activate](https://sms-activate.io/cn) 获取。

### 激活

```bash
# 命令行输入命令即可进入激活，升级Pro，绑定账户即可使用
proxychain claude
```

### 参考资料

* [Claude国内如何使用](https://mp.weixin.qq.com/s?__biz=MzkwNTc1NjE3Nw==&mid=2247485449&idx=2&sn=c09949ae5d5c61aec54bcb14f1e027b6&scene=21#wechat_redirect)

