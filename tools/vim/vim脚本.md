
```vimscript
vim9script noclear
# Vim global plugin for correcting typing mistakes
# Last Change:	2021 Dec 30
# Maintainer:	Bram Moolenaar <Bram@vim.org>
# License:	This file is placed in the public domain.

# 避免重复加载
if exists("g:loaded_typecorrect")
  finish
endif
g:loaded_typecorrect = 1

# 定义需要修改的拼写
iabbrev teh the
iabbrev otehr other
iabbrev wnat want
iabbrev synchronisation synchronization
var count = 4

# 如果映射没有定义，则定义
if !hasmapto('<Plug>TypecorrAdd;')
  map <unique> <Leader>a  <Plug>TypecorrAdd;
endif
noremap <unique> <script> <Plug>TypecorrAdd;  <SID>Add

noremap <SID>Add  :call <SID>Add(expand("<cword>"), true)<CR>

def Add(from: string, correct: bool)
  var to = input("type the correction for " .. from .. ": ")
  exe ":iabbrev " .. from .. " " .. to
  if correct | exe "normal viws\<C-R>\" \b\e" | endif
  count += 1
  echo "you now have " .. count .. " corrections"
enddef

if !exists(":Correct")
  command -nargs=1  Correct  call Add(<q-args>, false)
endif
```



## 全局脚本

### \<Plug\>描述

```
<Plug>	is visible outside of the script.  It is used for mappings which the
	user might want to map a key sequence to.  <Plug> is a special code
	that a typed key will never produce.
	To make it very unlikely that other plugins use the same sequence of
	characters, use this structure: <Plug> scriptname mapname
	In our example the scriptname is "Typecorr" and the mapname is "Add".
	We add a semicolon as the terminator.  This results in
	"<Plug>TypecorrAdd;".  Only the first character of scriptname and
	mapname is uppercase, so that we can see where mapname starts.
```

`<Plug>` 可以理解成是脚本提供接口的一种命名规范，`<Plug>` 是一种虚拟的字符，
不可能通过键盘输入.

```
	\a  ->  <Plug>TypecorrAdd;  ->  <SID>Add  ->  :call <SID>Add(...)
```

从输入到执行，依次是如下动作:

1. 用户态输入   -- 全局唯一
2. 脚本接口     -- 全局唯一
3. 脚本功能命名 -- 脚本独立
4. 脚本功能执行 -- 脚本独立



## Filetype脚本







## 附录

### TODO



* 这句话什么意思？

  ```
  This does require that the filetype plugin directory comes before $VIMRUNTIME in 'runtimepath'!
  ```

* `vim`中的各种路径？

  ```
  runtimepath
  packpath
  ```

* 



