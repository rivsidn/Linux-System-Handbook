


- default_mappings

- str_to_oscode


- tap-hold
- tap-hold-press
- tap-dance

### 功能

#### tap-dance

点击次数，支持不同的功能.

#### macro

提前定制的一些命令。

#### dynamic-macro

### config

#### P_7

A Windows tray menu build also allows specifying layer icons in deflayer and deflayermap to show
in the tray menu on layer activation, see example config

#### P_9

_   Map all unmapped keys in this layer that are defined in defsrc.
__  Map all unmapped keys in this layer that are not defined in defsrc.
___ Map all unmapped keys in this layer.


#### 层的概念


- 临时层
- 基础层
- 默认层(如果设置了delegate-to-first-layer)
- defsrc




### AI

#### 基本功能

- 支持多层键盘布局
  类似 QMK/VIA 里的 layer。你可以有一个基础层、符号层、数字层、导航层等。
  例如按住某个键时临时进入另一层，松开后回到原层。
- 支持临时切层和固定切层
  文档里有这些动作：
    - layer-while-held：按住某键时启用某层
    - layer-switch：切换到某层
    - transparent key：当前层没有定义时透传到下面的层
- 支持 tap-hold，一键两用
  这是 Kanata 很重要的功能。
  例如：
    - 轻点 Caps Lock 输出 Esc
    - 按住 Caps Lock 当作 Ctrl

  典型用法：

  (tap-hold 200 200 esc lctl)
- 支持 one-shot 按键
  例如按一下 Shift，下一次输入自动带 Shift，然后自动释放。适合做一击修饰键。
- 支持 tap-dance
  同一个键根据点击次数输出不同结果。
  比如单击是 Esc，双击是 Caps Lock。
- 支持宏 macro
  可以让一个键输出一串按键。
  比如按一个键自动输入一段文本、组合快捷键，或者执行连续操作。
- 支持动态宏 dynamic-macro
  可以在运行时录制一段按键，再回放。
- 支持组合键输出
  可以直接配置 Ctrl+C、Alt+Tab、Ctrl+Alt+Del 之类的组合键。
- 支持鼠标动作
  Kanata 不只改键盘，也能把按键映射成鼠标移动、点击、滚轮等动作。
- 支持配置热重载
  可以在 Kanata 运行时重新加载配置，不一定每次都重启程序。
- 支持配置检查
  命令行参数里有 --check，可以只检查配置文件是否正确，而不实际运行映射。

配置文件大概长这样

(defsrc
  caps a b c)

(deflayer base
  esc  1 2 3)

意思是：

- 物理 caps 输出 esc
- 物理 a 输出 1
- 物理 b 输出 2
- 物理 c 输出 3

你可以把 Kanata 理解成

它不是普通的“改键软件”，而是一个可编程键盘行为引擎。
它能做的事情包括：

- 改键
- 多层布局
- 一键两用
- 宏
- 组合键
- 鼠标控制
- Unicode 输入
- 条件逻辑
- 平台相关设备控制

如果你刚开始学，我建议先按这个顺序看：

1. defsrc
2. deflayer
3. deflayermap
4. defalias
5. tap-hold
6. layer-while-held
7. macro
8. defcfg


#### 和弦&组合

• 可以。Kanata 里的“和弦 / 组合”大概对应英文 chords / combos，意思是：按下多个键的组合，触发一个不同的动作。

  它有两个容易混淆的概念：

  - 输出和弦 Output Chords：一个键输出组合键，比如 Ctrl+C
  - 输入和弦 Input Chords / Combos：同时按几个物理键，触发另一个动作，比如 j+k 输出 Esc

  你现在主要要理解的是第二种：输入和弦 / combos。

  ———

  1. 输出和弦：输出组合键

  比如你希望某个键按下后输出 Ctrl+C，可以写：

  C-c

  这里的 C- 表示左 Ctrl，c 是普通按键。

  常见前缀：

  C-   左 Ctrl
  RC-  右 Ctrl
  A-   左 Alt
  RA-  右 Alt / AltGr
  S-   左 Shift
  RS-  右 Shift
  M-   左 Meta / Win / Cmd
  RM-  右 Meta

  例子：

  C-c     ;; Ctrl+C
  C-v     ;; Ctrl+V
  S-1     ;; Shift+1，在美式键盘上通常是 !
  A-tab   ;; Alt+Tab
  C-A-del ;; Ctrl+Alt+Delete

  这类更像是“输出快捷键”。

  ———

  2. 输入和弦：几个键一起按触发动作

  这个更像 QMK/ZMK 里的 combo。

  比如：

  - 同时按 j + k 输出 Esc
  - 同时按 s + d 输出 Backspace
  - 同时按 f + j 切换到符号层
  - 同时按 a + s + d 执行一个宏

  这种就叫 input chord。

  Kanata 文档推荐用新版写法：defchordsv2。

  ———

  3. 一个最小例子

  (defcfg
    concurrent-tap-hold yes)

  (defsrc
    a s d f j k l)

  (deflayer base
    a s d f j k l)

  (defchordsv2
    (j k) esc 150 first-release ()
    (s d) bspc 150 first-release ()
  )

  意思是：

  - 正常按 j，还是输出 j
  - 正常按 k，还是输出 k
  - 如果在 150ms 内同时按到 j 和 k，输出 Esc
  - 如果在 150ms 内同时按到 s 和 d，输出 Backspace

  注意：

  (defcfg
    concurrent-tap-hold yes)

  这个在使用 defchordsv2 时是必须开的。

  ———

  4. defchordsv2 的结构

  文档里的格式是：

  (defchordsv2
    (参与按键) 动作 超时时间 释放行为 (禁用层)
  )

  对应到例子：

  (defchordsv2
    (j k) esc 150 first-release ()
  )

  逐项解释：

  (j k)           参与和弦的按键
  esc             触发后的动作
  150             超时时间，单位毫秒
  first-release   释放行为
  ()              哪些层禁用这个和弦

  ———

  5. 超时时间 timeout

  比如：

  (j k) esc 150 first-release ()

  意思是：

  从你按下第一个键开始计时，150ms 内如果另一个键也按下，就认为你输入了这个 combo。

  如果超时还没凑齐组合，就按普通按键处理。

  常见取值：

  75ms    比较快，适合熟练后使用
  100ms   比较常见
  150ms   新手比较舒服
  200ms+  容易误触，也会让普通输入感觉有延迟

  刚开始可以用 150，熟悉后改成 100 或更低。

  ———

  6. 释放行为

  defchordsv2 里有两个释放行为：

  first-release
  all-released

  区别是：

  (j k) esc 150 first-release ()

  表示：只要 j 或 k 其中一个松开，esc 这个动作就释放。

  (j k) lctl 150 all-released ()

  表示：只有 j 和 k 都松开后，lctl 才释放。

  简单记：

  - 普通按键、宏、一次性动作：常用 first-release
  - 修饰键、按住生效的层：可以考虑 all-released

  ———

  7. 禁用层

  最后的 () 表示在哪些层禁用这个 combo。

  例如：

  (defchordsv2
    (j k) esc 150 first-release (game)
  )

  意思是：在 game 层里，j+k 不再触发 Esc。

  这很有用，比如你打游戏时不想 combo 干扰正常按键。

  ———

  8. 和普通组合键的区别

  很多人会混淆这两个：

  C-c

  这是 输出和弦，意思是输出 Ctrl+C。

  (defchordsv2
    (j k) esc 150 first-release ()
  )

  这是 输入和弦，意思是物理上同时按 j+k，然后输出 Esc。

  可以这样理解：

  输出和弦：一个键 -> 多个输出键
  输入和弦：多个输入键 -> 一个动作

  ———

  9. 常见用途

  Kanata 的和弦 / combo 常用来做这些：

  j+k       -> Esc
  s+d       -> Backspace
  f+j       -> Enter
  a+s       -> Tab
  d+f       -> Delete
  j+l       -> Caps Word
  q+w       -> 切换层

  例如：

  (defcfg
    concurrent-tap-hold yes)

  (defsrc
    a s d f j k l ;)

  (deflayer base
    a s d f j k l ;)

  (defchordsv2
    (j k) esc 120 first-release ()
    (s d) bspc 120 first-release ()
    (f j) ret 120 first-release ()
    (d f) del 120 first-release ()
  )

  ———

  10. 初学建议

  你刚开始学的话，建议先只记住这三点：

  (defcfg
    concurrent-tap-hold yes)

  然后写：

  (defchordsv2
    (j k) esc 150 first-release ()
  )

  含义是：

  同时按 j 和 k，在 150ms 内完成，就输出 Esc。

  先从 j+k -> Esc 这种简单 combo 开始，等你熟悉后，再学更复杂的三键和弦、分层禁用、虚拟键和 tap-hold 配合。




