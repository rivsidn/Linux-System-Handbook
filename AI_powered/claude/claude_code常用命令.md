
## claude常用命令

### 命令行

| 命令行                   | 说明         |
|--------------------------|--------------|
| -r "<session-id>"        | 恢复上次会话 |
| --permission-prompt-tool | TODO         |


### 会话命令

| 命令(/\<command\>) | 说明                     |
|--------------------|--------------------------|
| add-dir \<path\>   | 添加工作目录             |
| bug                | 报告错误                 |
| clear              | 清空会话历史，重置上下文 |
| compact            | 压缩会话，降低token用量  |
| config             | 查看/修改配置            |
| cost               | 显示token使用信息        |
| doctor             | 检查安装健康状况         |
| exit/quit          | 退出                     |
| help               | 显示帮助信息             |
| init               | 初始化/更新项目          |
| login              | 账户登录                 |
| logout             | 账户登出                 |
| permissions        | 工具权限设置             |
| pr_comments        | 查看pull request 评论    |
| review             | 请求代码审查             |
| terminal-setup     | ??设置键绑定             |

### 快捷键

| 快捷键    | 说明         |
|-----------|--------------|
| shift+tab | 切换工作模式 |


### 常用配置

#### 设置代理

```bash
{
	"env":{
		"HTTP_PROXY": "http://127.0.0.1:1081",
		"HTTPS_PROXY": "http://127.0.0.1:1081"
	},
	"model": "sonnet"
}
```

### 附录

### 参考资料

* [Claude Code 使用教程](https://blog.axiaoxin.com/post/claude-code-full-guide/)
* [Claude Code 实用教程——使用方法详解](https://blog.axiaoxin.com/post/claude-code-usages/)

### claude code命令行

```bash
Usage: claude [options] [command] [prompt]

使用方法:
    claude [options] [command] [prompt]


Claude Code - starts an interactive session by default, use -p/--print for non-interactive output
            - 默认启动一个交互式会话，使用 -p/--print 用户非交互式输出

Arguments:
  prompt                          Your prompt

Options:
  -d, --debug                     Enable debug mode
  --verbose                       Override verbose mode setting from config
  -p, --print                     Print response and exit (useful for pipes)
  --output-format <format>        Output format (only works with --print):
                                  "text" (default), "json" (single result), or
                                  "stream-json" (realtime streaming) (choices:
                                  "text", "json", "stream-json")
                                  输出格式，支持("text", "json", "stream-json")
  --input-format <format>         Input format (only works with --print):
                                  "text" (default), or "stream-json" (realtime
                                  streaming input) (choices: "text",
                                  "stream-json")
  --mcp-debug                     [DEPRECATED. Use --debug instead] Enable MCP
                                  debug mode (shows MCP server errors)
                                  使能MCP 调试模式.
  --dangerously-skip-permissions  Bypass all permission checks. Recommended
                                  only for sandboxes with no internet access.
                                  跳过所有的权限检查. 仅仅用于没有网络环境的沙
                                  盒环境.
  --allowedTools <tools...>       Comma or space-separated list of tool names
                                  to allow (e.g. "Bash(git:*) Edit")
                                  指定可以用于访问的工具.
  --disallowedTools <tools...>    Comma or space-separated list of tool names
                                  to deny (e.g. "Bash(git:*) Edit")
                                  指定不能用于访问的工具.
  --mcp-config <file or string>   Load MCP servers from a JSON file or string
                                  通过JSON文件或者字符串加载MCP服务器.
  -c, --continue                  Continue the most recent conversation
                                  恢复最近的会话.
  -r, --resume [sessionId]        Resume a conversation - provide a session ID
                                  or interactively select a conversation to
                                  resume
                                  恢复会话.
  --model <model>                 Model for the current session. Provide an
                                  alias for the latest model (e.g. 'sonnet' or
                                  'opus') or a model\'s full name (e.g.
                                  'claude-sonnet-4-20250514').
                                  选择使用的模型，支持别名.
  --add-dir <directories...>      Additional directories to allow tool access
                                  to
                                  添加允许工具访问的目录.
  -v, --version                   Output the version number
                                  输出版本号信息.
  -h, --help                      Display help for command
                                  输出帮助信息.

Commands:
  config                          Manage configuration (eg. claude config set
                                  -g theme dark)
  mcp                             Configure and manage MCP servers
  migrate-installer               Migrate from global npm installation to local
                                  installation
  doctor                          Check the health of your Claude Code
                                  auto-updater
  update                          Check for updates and install if available
                                  检查更新
```

