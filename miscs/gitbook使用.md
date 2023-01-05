`github` 中记录的东西，在同一目录下的所有文件之间都是并列存在的，不容易梳理文件之间的关系。

对于不与其他文件产生关系的独立文件来说没什么问题，但是对于一个主题，该主题下文件存在先后顺序的，全部放在同一个目录下就显得杂乱。

所以此处引入`gitbook` 用于管理文件，另外，顺便将文件同步到`gitbook.com` 中。



## 安装更新

### 安装

```bash
sudo apt install npm
# -g 表示全局安装，不是安装在本地，这样可以当作命令行使用
# --force 表示可以覆盖之前存在的文件
# --registry 表示从国内源安装
sudo npm install -g gitbook-cli --force --registry=https://registry.npmmirror.com
gitbook fetch
```

`gitbook-cli` 和 `gitbook` 是两个软件，`gitbook-cli` 会将下载的`gitbook` 不同版本放到`~/.gitbook` 下，可以通过设置`GITBOOK_DIR` 环境变量来指定另外的文件夹。

可以理解成，`gitbook-cli` 是`gitbook` 的安装、版本管理工具。

### 更新

```bash
# 列出本地所有的gitbook版本
gitbook ls
# 列出远程可用的gitbook版本
gitbook ls-remote
# 安装对应的版本，没加版本号的时候，获取最新版本
gitbook fetch <标签/版本号>
# 更新到最新版本
gitbook update
```

### 卸载

```bash
gitbook uninstall <版本号>
```

### 其他命令

```bash
# 查看gitbook 所有命令
gitbook help
# 查看gitbook-cli 的帮助信息
gitbook --help
```



## 使用

```bash
# 初始化本地目录
gitbook init
# 生成_book目录，里面内容为展示的静态站点的资源文件
gitbook build
# 启动本地服务
gitbook serve
```

启动本地服务之后，本地可以通过浏览器访问`http://localhost:4000` 预览书籍。



### 开机启动

* 修改`rc.local`启动脚本

  ```bash
  #!/bin/bash
  
  gitbook serve /home/yuchao/tmp/book/ > /var/log/gitbook.log 2>&1 &
  ```

* `root`下安装`gitbook`

  由于`gitbook`默认是安装在本地目录下，启动脚本中启动的时候运行在`root`下，找不到本地的安装，此时将本地安装的`gitbook`拷贝到本地即可

  ```bash
  cp ~/.gitbook/versions/* /root -a
  ```



## 插件

### 生成页内目录

`book.json` 中添加插件名：

```json
{
    "plugins": ["page-treeview"],
    "pluginsConfig": {
        "page-treeview": {
            "copyright": "Copyright &#169; aleen42",
            "minHeaderCount": "2",
            "minHeaderDeep": "2"
        }
    }
}
```

然后执行命令安装：

```bash
gitbook install
```

安装之后会在本地生成一个`node_modules` 文件。



## 托管

已经存在于`github` 上的文件，可以同步到`gitbook.com` 上显示。

同步之后，提交到`github` 上的更新，可以直接同步到`gitbook.io` 。



## 附录

### 特殊文件说明

| 特殊文件    | 说明                                                         |
| ----------- | ------------------------------------------------------------ |
| book.json   | 配置数据(可选)                                               |
| README.md   | 电子书的前言或者简介(必须)                                   |
| SUMMARY.md  | 电子书目录(可选)<br />描述文件之间的目录关系，通过`markdown`列表之间的递进关系描述文件之间层级关系，<br />该文件中的标题仅用于自己注释，不会实际展示到电子书中。<br />文件之间的层级关系，就是通过列表之间层级关系体现的，目录等在`gitbook` 中并不会体现文件间层级关系。 |
| GLOSSARY.md | 词汇/注释属于列表(可选)                                      |

### 常见错误

* Error: ENOENT: no such file or directory, stat ‘C:***demo_book\_book\gitbook\gitbook-plugin-fontsettings\fontsettings.js’

  参照 [GitBook运行报错 - no such file or directory](https://blog.csdn.net/prufeng/article/details/83301895)

