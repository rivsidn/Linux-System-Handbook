
• 可以。gitk 自带快捷键列表，打开后可以从菜单看：

  Help -> Key bindings

  下面是常用默认快捷键，Linux/Windows 下通常是 Ctrl，macOS 下对应多为 Cmd。

  提交列表导航

  Up / p / k          选择上一个 commit
  Down / n / j        选择下一个 commit
  Home                跳到第一个 commit
  End                 跳到最后一个 commit
  PageUp              向上翻一页 commit
  PageDown            向下翻一页 commit

  Ctrl-1 ... Ctrl-9   跳到当前 commit 的第 n 个 parent

  这里的 h/j/k/l 比较像 Vim：

  j   下移
  k   上移

  搜索 / 跳转

  /                   聚焦搜索框
  Ctrl-F              查找
  Enter               跳到下一个搜索结果
  Ctrl-G              跳到下一个搜索结果
  ?                   跳到上一个搜索结果

  Shift-Up            向上查找
  Shift-Down          向下查找

  g                   跳转到指定 commit

  按 g 后可以输入 commit hash、branch、tag 等引用。

  **注释: 通过 上下箭头使得可以焦点重回commit log.**

  diff 区域滚动

  Space               diff 向下翻一页
  Backspace           diff 向上翻一页
  Delete              diff 向上翻一页

  d                   diff 向下滚动一段
  u                   diff 向上滚动一段

  f                   跳到 diff 中下一个文件
  b                   跳到 diff 中上一个文件

  注意这里的 f/b 是在当前 commit 的 diff 里按文件跳转，不是搜索字符。

  提交列表滚动

  Ctrl-Home           滚动到 commit 列表顶部
  Ctrl-End            滚动到 commit 列表底部
  Ctrl-Up             commit 列表向上滚动一行
  Ctrl-Down           commit 列表向下滚动一行
  Ctrl-PageUp         commit 列表向上滚动一页
  Ctrl-PageDown       commit 列表向下滚动一页

  窗口 / 视图

  F5                  更新当前视图
  Shift-F5            重新加载
  F2                  列出 references
  F4                  编辑当前 view
  Shift-F4            新建 view

  Ctrl-Q              退出 gitk

  字体大小

  Ctrl-+              增大字体
  Ctrl-=              增大字体
  Ctrl--              减小字体

  最常用的一组其实是：

  **注释：这就挺不错了.**

  j / k       上下选 commit
  Space       diff 向下翻页
  u / d       diff 上下滚动
  /           搜索
  Enter       下一个搜索结果
  g           跳到 commit
  f / b       diff 中下一个/上一个文件


