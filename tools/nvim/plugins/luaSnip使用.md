
## 使用概述

使用流程大概是这样的:

1. 预定义代码片段.
   预定义代码片段由几部分组成:
   1. 预定义头
   2. 展开body
   3. 插入点
2. 首先输入 *预定义头*，通过快捷键可以展开为 *展开body*，展开之后的body 中包含*插入点*，
   通过跳转插入点实现输入的目的


## 代码片段配置

下边这几种配置方式，配置方式依次越来越难，功能越来越强大.

### SnipMate 风格

#### 代码片段示例

```
snippet fn "Lua function"
function ${1:name}(${2})
	${0}
end

snippet if "if statement"
if ${1:condition} then
	${0}
end
```

将代码片段放到特定目录下，通过`require()`命令加载.

#### 注册命令

```
require("luasnip.loaders.from_snipmate").lazy_load({
  paths = { "~/.config/nvim/snippets" }
})
```

注册命令中可以添加代码片段的路径.
支持多级多级添加，最后添加的代码片段有最高优先级.


### VSCode 风格

#### 配置目录

> ~/.config/nvim/vscode-snippets/
> ├── package.json          # 必须文件，定义片段包
> ├── snippets/
> │   ├── lua.json         # Lua 片段
> │   ├── python.json      # Python 片段
> │   ├── javascript.json  # JavaScript 片段
> │   └── markdown.json    # Markdown 片段

package.json 示例

```json
{
  "name": "my-custom-snippets",
  "version": "1.0.0",
  "contributes": {
    "snippets": [
      {
        "language": "lua",
        "path": "./snippets/lua.json"
      },
      {
        "language": "python",
        "path": "./snippets/python.json"
      }
    ]
  }
}
```

#### 代码片段示例

```json
{
  "Lua Function": {
    "prefix": "fn",
    "body": [
      "function ${1:name}(${2})",
      "\t${0}",
      "end"
    ],
    "description": "Lua function definition"
  }
}
```

#### 注册命令

```lua
require("luasnip.loaders.from_vscode").lazy_load({
  paths = { "~/.config/nvim/vscode-snippets" }
})
```

同上，注册命令中添加添加了代码路径.

### Lua 配置

#### 配置目录

>  ~/.config/nvim/lua-snippets/
>  ├── lua.lua          # Lua 语言片段
>  ├── python.lua       # Python 语言片段
>  ├── javascript.lua   # JavaScript 片段
>  ├── all.lua         # 全局片段（所有文件类型）
>  └── init.lua        # 可选的初始化文件

#### 代码片段示例

TODO


#### 注册命令

```lua
require("luasnip.loaders.from_lua").load({
  paths = "~/.config/nvim/lua-snippets"
})
```


配置后的代码片段可以通过以下命令查看:

```lua
-- 查看已加载的片段
:lua print(vim.inspect(require("luasnip").get_snippets("lua")))

-- 重新加载片段
:lua require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/lua-snippets"})
```

## 快捷键配置

| 快捷键 | 说明           |
|--------|----------------|
| C-k    | 代码片段展开   |
| C-l    | 向前跳转插入点 |
| C-j    | 向后跳转插入点 |


## 附录

### TODO


### From AI


>  目录结构
>
>  ~/.config/nvim/snippets/
>  ├── lua.snippets         # Lua 片段
>  ├── python.snippets      # Python 片段
>  ├── javascript.snippets  # JavaScript 片段
>  └── markdown.snippets    # Markdown 片段
>
>  片段文件示例 (lua.snippets)
>
>  snippet fn "Lua function"
>  function ${1:name}(${2})
>  	${0}
>  end
>
>  snippet if "if statement"
>  if ${1:condition} then
>  	${0}
>  end
>
>  加载配置
>
>  require("luasnip.loaders.from_snipmate").lazy_load({
>    paths = { "~/.config/nvim/snippets" }
>  })
>
>  在插件配置中启用
>
>  需要在 lua/plugins.lua 的 LuaSnip 配置中添加加载器：
>
>  config = function()
>    -- 现有配置...
>
>    -- 加载 friendly-snippets (VSCode 风格)
>    require("luasnip.loaders.from_vscode").lazy_load()
>
>    -- 加载自定义 VSCode 风格片段
>    require("luasnip.loaders.from_vscode").lazy_load({
>      paths = { "~/.config/nvim/vscode-snippets" }
>    })
>
>    -- 加载自定义 SnipMate 风格片段
>    require("luasnip.loaders.from_snipmate").lazy_load({
>      paths = { "~/.config/nvim/snippets" }
>    })
>
>    -- 加载自定义 Lua 片段
>    require("luasnip.loaders.from_lua").load({
>      paths = "~/.config/nvim/lua-snippets"
>    })
>  end


> 目录结构
>
> ~/.config/nvim/vscode-snippets/
> ├── package.json          # 必须文件，定义片段包
> ├── snippets/
> │   ├── lua.json         # Lua 片段
> │   ├── python.json      # Python 片段
> │   ├── javascript.json  # JavaScript 片段
> │   └── markdown.json    # Markdown 片段
>
> package.json 示例
>
> {
>   "name": "my-custom-snippets",
>   "version": "1.0.0",
>   "contributes": {
>     "snippets": [
>       {
>         "language": "lua",
>         "path": "./snippets/lua.json"
>       },
>       {
>         "language": "python",
>         "path": "./snippets/python.json"
>       }
>     ]
>   }
> }
>
> 片段文件示例 (lua.json)
>
> {
>   "Lua Function": {
>     "prefix": "fn",
>     "body": [
>       "function ${1:name}(${2})",
>       "\t${0}",
>       "end"
>     ],
>     "description": "Lua function definition"
>   }
> }
>
> 加载配置
>
> require("luasnip.loaders.from_vscode").lazy_load({
>   paths = { "~/.config/nvim/vscode-snippets" }
> })

>  配置目录
>
>  ~/.config/nvim/lua-snippets/
>  ├── lua.lua          # Lua 语言片段
>  ├── python.lua       # Python 语言片段
>  ├── javascript.lua   # JavaScript 片段
>  ├── all.lua         # 全局片段（所有文件类型）
>  └── init.lua        # 可选的初始化文件
>
>  基本语法结构
>
>  核心组件
>
>  local ls = require("luasnip")
>  local s = ls.snippet           -- 片段定义
>  local t = ls.text_node         -- 静态文本
>  local i = ls.insert_node       -- 占位符（可编辑）
>  local f = ls.function_node     -- 动态函数生成
>  local c = ls.choice_node       -- 选择节点
>  local d = ls.dynamic_node      -- 动态节点
>  local r = ls.restore_node      -- 恢复节点
>
>  基本片段示例 (lua.lua)
>
>  local ls = require("luasnip")
>  local s = ls.snippet
>  local t = ls.text_node
>  local i = ls.insert_node
>  local f = ls.function_node
>
>  return {
>    -- 简单函数片段
>    s("fn", {
>      t("function "), i(1, "name"), t("("), i(2), t(")"),
>      t({"", "\t"}), i(0),
>      t({"", "end"})
>    }),
>
>    -- 带选择的条件语句
>    s("if", {
>      t("if "), i(1, "condition"), t(" then"),
>      t({"", "\t"}), i(0),
>      t({"", "end"})
>    }),
>
>    -- 动态内容：自动插入文件名
>    s("header", {
>      t("-- "), f(function()
>        return vim.fn.expand("%:t")
>      end), t(" - "), i(1, "description"),
>      t({"", "-- Created: "}), f(function()
>        return os.date("%Y-%m-%d")
>      end),
>      t({"", "", ""}), i(0)
>    })
>  }
>
>  高级功能示例
>
>  1. 选择节点 (choice_node)
>
>  s("class", {
>    c(1, {
>      t("local "),
>      t(""),
>    }), i(2, "ClassName"), t(" = {}"),
>    t({"", "", "function "}), rep(2), t(":new("), i(3), t(")"),
>    t({"", "\tlocal obj = {}"}),
>    t({"", "\tsetmetatable(obj, self)"}),
>    t({"", "\tself.__index = self"}),
>    t({"", "\t"}), i(0),
>    t({"", "\treturn obj"}),
>    t({"", "end"})
>  })
>
>  2. 函数节点 (function_node)
>
>  -- 自动生成当前时间
>  s("timestamp", {
>    t("-- Updated: "), f(function()
>      return os.date("%Y-%m-%d %H:%M:%S")
>    end)
>  }),
>
>  -- 根据文件名生成模块名
>  s("module", {
>    t("local "), f(function()
>      return vim.fn.expand("%:t:r")
>    end), t(" = {}"),
>    t({"", "", "return "}), f(function()
>      return vim.fn.expand("%:t:r")
>    end)
>  })
>
>  加载配置
>
>  在 lua/plugins.lua 中添加：
>
>  config = function()
>    local ls = require("luasnip")
>
>    -- 键位映射...
>
>    -- 加载 Lua 格式片段
>    require("luasnip.loaders.from_lua").load({
>      paths = "~/.config/nvim/lua-snippets"
>    })
>
>    -- 可选：启用自动片段
>    ls.config.set_config({
>      enable_autosnippets = true,
>      store_selection_keys = "<Tab>",
>    })
>  end
>
>  调试和测试
>
>  -- 查看已加载的片段
>  :lua print(vim.inspect(require("luasnip").get_snippets("lua")))
>
>  -- 重新加载片段
>  :lua require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/lua-snippets"})
