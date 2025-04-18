主要用于解析`vim`启动过程中，脚本文件的加载过程。



## 创建调用关系图

### 获取启动日志文件

```bash
# 获取日志文件
vim -V2
```

### 调用关系图生成

```bash
python3 vim_starup.py starup.log
```



## 启动过程解析

以`ubuntu`下`vim` 为例子，具体配置参见附录。 

### 系统脚本加载

1. 代码中调用`do_source()` 执行`system vimrc file` 加载动作。

   函数调用关系为 `main()` -> `source_startup_scripts()` -> `do_source()`，代码如下：

   ```c
   (void)do_source((char_u *)SYS_VIMRC_FILE, FALSE, DOSO_NONE, NULL);
   ```

   此处的`SYS_VIMRC_FILE` 为 `/etc/vim/vimrc` 文件。

   `do_source()` 参数中支持环境变量，函数执行中会将函数变量转换为对应的地址，常见的环境变量有。

   | 环境变量   | 默认地址             |
   | ---------- | -------------------- |
   | HOME       | 家目录               |
   | VIMRUNTIME | /usr/share/vim/vim91 |
   | VIM        | /usr/share/vim       |

2. `/etc/vim/vimrc` 文件中执行命令，执行加载动作

   ```vim
   runtime! debian.vim
   
   if has("syntax")
     syntax on
   endif
   ```

   **runtime** 命令会从`runtimepath`、`packpath` 中查找对应文件，两个默认相同，为

   > $HOME/.vim
   >
   > /usr/share/vim/vimfiles
   >
   > /usr/share/vim/vim91
   >
   > /usr/share/vim/vimfiles/after
   >
   > $HOME/.vim/after

   **syntan on** 实际上等同执行下列动作，可以理解成是一个封装

   ```vim
   source $VIMRUNTIME/syntax/syntax.vim
   ```

3. `/usr/share/vim/vim91/syntax/syntax.vim` 执行，主要设计两部分

   1. 语法高亮加载
   2. 文件类型识别

### 用户脚本加载

用户态脚本加载与系统脚本加载位于同一个函数中， 函数此时执行的脚本为`$HOME/.vimrc` 文件。

```c
do_source((char_u *)USR_VIMRC_FILE, TRUE, DOSO_VIMRC, NULL) == FAIL
```

### 插件脚本加载

当前是通过`vundle` 管理的插件，该插件运行的时候会设置`rtp`，//TODO

```vim
/home/yuchao/.vim
/home/yuchao/.vim/bundle/Vundle.vim
/home/yuchao/.vim/bundle/a.vim
/home/yuchao/.vim/bundle/vim-colors-solarized
/home/yuchao/.vim/bundle/AutoClose
/home/yuchao/.vim/bundle/cscope.vim
/home/yuchao/.vim/bundle/DrawIt
/home/yuchao/.vim/bundle/surround.vim
/home/yuchao/.vim/bundle/taglist.vim
/home/yuchao/.vim/bundle/tabular
/home/yuchao/.vim/bundle/table-mode
/home/yuchao/.vim/bundle/vimtex
/usr/share/vim/vimfiles
/usr/share/vim/vim91
/usr/share/vim/vimfiles/after
/home/yuchao/.vim/after
/home/yuchao/.vim/bundle/Vundle.vim
/home/yuchao/.vim/bundle/Vundle.vim/after
/home/yuchao/.vim/bundle/a.vim/after
/home/yuchao/.vim/bundle/vim-colors-solarized/after
/home/yuchao/.vim/bundle/AutoClose/after
/home/yuchao/.vim/bundle/cscope.vim/after
/home/yuchao/.vim/bundle/DrawIt/after
/home/yuchao/.vim/bundle/surround.vim/after
/home/yuchao/.vim/bundle/taglist.vim/after
/home/yuchao/.vim/bundle/tabular/after
/home/yuchao/.vim/bundle/table-mode/after
/home/yuchao/.vim/bundle/vimtex/after"
```















## 附录

### TODO

* 为什么在`vim`调试过程中`strcmp()`不能使用？

* `vundle` 管理脚本是如何实现的？

* 各种不同的启动路径

  为什么`system vimrc file` 两个不同？是如何设置的？

  `runtimepath` `packpath` 两个路径区别？

  `$HOME`  `$VIM` `VIMRUNTIME`  这些宏分别是做什么用的？

  ```
  //自己编译的
     system vimrc file: "$VIM/vimrc"
       user vimrc file: "$HOME/.vimrc"
   2nd user vimrc file: "~/.vim/vimrc"
   3rd user vimrc file: "~/.config/vim/vimrc"
        user exrc file: "$HOME/.exrc"
         defaults file: "$VIMRUNTIME/defaults.vim"
    fall-back for $VIM: "/usr/local/share/vim"
  
  //系统安装的
     system vimrc file: "/etc/vim/vimrc"
       user vimrc file: "$HOME/.vimrc"
   2nd user vimrc file: "~/.vim/vimrc"
   3rd user vimrc file: "~/.config/vim/vimrc"
        user exrc file: "$HOME/.exrc"
    system gvimrc file: "/etc/vim/gvimrc"
      user gvimrc file: "$HOME/.gvimrc"
  2nd user gvimrc file: "~/.vim/gvimrc"
  3rd user gvimrc file: "~/.config/vim/gvimrc"
         defaults file: "$VIMRUNTIME/defaults.vim"
      system menu file: "$VIMRUNTIME/menu.vim"
    fall-back for $VIM: "/usr/share/vim"
  ```

* `source` 执行时候会去哪里找？

* 编译过程中如何修改这两个值

  ```c
  #define SYS_VIMRC_FILE "/etc/vim/vimrc"
  
  char_u *default_vim_dir = (char_u *)"/usr/share/vim";
  
  ```

  



### ubuntu vim配置

```bash
$ ./vim --version
VIM - Vi IMproved 9.1 (2024 Jan 02, compiled Apr 18 2025 09:48:23)
Included patches: 1-1299
Compiled by yuchao@yuchao
Huge version without GUI.  Features included (+) or not (-):
+acl               +file_in_path      +mouse_urxvt       -tag_any_white
+arabic            +find_in_path      +mouse_xterm       -tcl
+autocmd           +float             +multi_byte        +termguicolors
+autochdir         +folding           +multi_lang        +terminal
-autoservername    -footer            -mzscheme          +terminfo
-balloon_eval      +fork()            +netbeans_intg     +termresponse
+balloon_eval_term -gettext           +num64             +textobjects
-browse            -hangul_input      +packages          +textprop
++builtin_terms    +iconv             +path_extra        +timers
+byte_offset       +insert_expand     -perl              +title
+channel           +ipv6              +persistent_undo   -toolbar
+cindent           +job               +popupwin          +user_commands
-clientserver      +jumplist          +postscript        +vartabs
-clipboard         +keymap            +printer           +vertsplit
+cmdline_compl     +lambda            +profile           +vim9script
+cmdline_hist      +langmap           -python            +viminfo
+cmdline_info      +libcall           -python3           +virtualedit
+comments          +linebreak         +quickfix          +visual
+conceal           +lispindent        +reltime           +visualextra
+cryptv            +listcmds          +rightleft         +vreplace
+cscope            +localmap          -ruby              +wildignore
+cursorbind        -lua               +scrollbind        +wildmenu
+cursorshape       +menu              +signs             +windows
+dialog_con        +mksession         +smartindent       +writebackup
+diff              +modify_fname      -sodium            -X11
+digraphs          +mouse             -sound             +xattr
-dnd               -mouseshape        +spell             -xfontset
-ebcdic            +mouse_dec         +startuptime       -xim
+emacs_tags        -mouse_gpm         +statusline        -xpm
+eval              -mouse_jsbterm     -sun_workshop      -xsmp
+ex_extra          +mouse_netterm     +syntax            -xterm_clipboard
+extra_search      +mouse_sgr         +tag_binary        -xterm_save
-farsi             -mouse_sysmouse    -tag_old_static    
   system vimrc file: "/etc/vim/vimrc"
     user vimrc file: "$HOME/.vimrc"
 2nd user vimrc file: "~/.vim/vimrc"
 3rd user vimrc file: "~/.config/vim/vimrc"
      user exrc file: "$HOME/.exrc"
       defaults file: "$VIMRUNTIME/defaults.vim"
  fall-back for $VIM: "/usr/share/vim"
Compilation: gcc -c -I. -Iproto -DHAVE_CONFIG_H -g 
Linking: gcc -L/usr/local/lib -Wl,--as-needed -o vim -lm -ltinfo 
```

### 调用关系图生成脚本

```python
#!/usr/bin/env python3

import graphviz
import argparse

def parse_vim_log(file_path):
    """解析Vim启动日志文件，提取脚本加载依赖关系和行号。"""
    edges = []
    stack = []
    current_file = None
    
    with open(file_path, 'r') as file:
        for line in file:
            line = line.strip()
            if line.startswith('sourcing'):
                # 提取被加载的脚本路径
                path = line.split(' ')[-1].strip('"')
                # 将当前脚本压入栈
                stack.append(path)
                # 添加没有parent的边
                edges.append(("", path, 0))
            elif line.startswith('line'):
                # 提取行号
                parts = line.split(':')
                line_number = int(parts[0].split(' ')[-1])
                path = parts[1].strip().split(' ')[-1].strip('"')
                if stack:
                    # 当前脚本是上一个脚本的子节点
                    parent_path = stack[-1]
                    edges.append((parent_path, path, line_number))

                    # 调试
                    print(parent_path, path, line_number)

                stack.append(path);
            elif line.startswith('finished sourcing'):
                # 从栈中弹出已完成的脚本
                path = line.split(' ')[-1].strip('"')
                if stack and stack[-1] == path:
                    stack.pop()
    return edges


def create_vim_startup_graph_from_log(log_file_path):
    # 解析日志文件获取依赖关系
    edges = parse_vim_log(log_file_path)
    
    # 创建一个有向图
    dot = graphviz.Digraph(comment='Vim Startup Script Loading Graph')
    dot.attr(rankdir='LR')
    
    # 设置节点样式
    dot.attr('node', shape='box', style='rounded')
    
    # 添加节点和边
    for source, target, line_number in edges:
        # 使用完整路径作为节点标签
        source_label = source
        target_label = target
        
        if len(source_label) == 0:
            dot.node(target, target_label)
            continue

        dot.node(source, source_label)
        dot.node(target, target_label)
        # 在边上添加行号信息
        dot.edge(source, target, label=f"line {line_number}")
    
    # 保存图形
    dot.render('vim_startup_graph', format='png', cleanup=True)


def main():
    parser = argparse.ArgumentParser(description='Generate a Vim startup script loading graph.')
    parser.add_argument('log_file', type=str, help='Path to the Vim startup log file')
    args = parser.parse_args()

    create_vim_startup_graph_from_log(args.log_file)


if __name__ == '__main__':
    main()

```













