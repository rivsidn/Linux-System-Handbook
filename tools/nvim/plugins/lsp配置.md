

## 插件安装

```lua
local lsp_config = {
  'neovim/nvim-lspconfig',
}
```

添加官方支持的lsp 插件.


## 语言服务器配置

### C 语言服务器配置

**插件支持**

```lua
  config = function()
    -- 配置clangd用于C/C++
    require('lspconfig').clangd.setup{}
  end
```

**LSP服务器安装**

```bash
sudo apt install clangd
```

**注意事项**

LSP 运行的时候，会基于目录生成缓存.

如果我在分析一个git 仓库，分支切换的时候目录保持不变，这时候缓存之间可能会出现混
淆.


### python 语言服务器配置



