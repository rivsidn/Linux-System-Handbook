
## 键盘映射

| 映射前       | 映射后    | 功能                       |
|--------------|-----------|----------------------------|
| Caps         | Ctrl      |                            |
| Shift + Caps | Caps      | 字母大写                   |
| ' + Caps     | Backspace | 映射成Backspace            |
| ' + Tab      | Esc       | 映射成Esc                  |
| ' + p        |           | 上                         |
| ' + .        |           | 下                         |
| ' + l        |           | 左                         |
| ' + ;        |           | 右                         |
| ' + q        | ' "       | 单点是双引号; 双点是单引号 |
| ' + w        | {}        | 单点是左括号; 双点是右括号 |
| ' + e        | []        | 单点是左括号; 双点是右括号 |
| ' + r        | ()        | 单点是左括号; 双点是右括号 |
| ' + t        | \|        | 竖线                       |
| ' + a        | +         | + 码                       |
| ' + s        | -         | - 号                       |
| ' + d        | *         | * 号                       |
| ' + f        | /         | / 号                       |
| ' + g        | =         | = 号                       |
| ' + z        | _         | 下划线                     |
| ' + c        | `         | ` 号                       |
| ' + x        | ?         | ? 号                       |
| ' + v        | \         | 反斜线                     |
| Alt + k      |           | 上                         |
| Alt + j      |           | 下                         |
| Alt + h      |           | 左                         |
| Alt + l      |           | 右                         |

## 配置文件

```kbd
```

## 附录

- 标点符号

  | 符号 | 英文     | 映射      |
  |------|----------|-----------|
  | +    | plus     | Space + p |
  | -    | minus    | Space + m |
  | *    | asterisk | Space + a |
  | /    | slash    | Space + s |
  | ^    | caret    | Space + c |
  | 

符号	英文名称
!	exclamation mark（英式） / exclamation point（美式）
@	at sign
\#	hash / pound sign / number sign
$	dollar sign
%	percent sign
^	caret
&	ampersand
*	asterisk
(	left parenthesis / open parenthesis
)	right parenthesis / close parenthesis
_	underscore
-	hyphen / minus
=	equals sign
+	plus sign
[	left square bracket / open bracket
{	left curly brace / left brace
\	backslash
|	vertical bar / pipe
'	apostrophe / single quote
"	quotation mark / double quote

补充几个容易混淆的：

'#'
编程里常说 hash
电话键盘里常说 pound
表示编号时叫 number sign

-
单词连接：hyphen
数学减号：minus
|
Linux / 编程里通常说 pipe
"
英式英语里也常说 inverted commas

符号	程序员常读
!	bang
@	at
\#	hash
$	dollar
%	percent
^	caret
&	amp / ampersand
*	star
(	left paren / open paren
)	right paren / close paren
_	underscore
-	dash / hyphen
=	equals
+	plus
[	left bracket / open bracket
]	right bracket / close bracket
{	left brace / open brace / curly brace
}	right brace / close brace
\	backslash
/	slash
|	pipe
'	single quote
"	double quote
:	colon
;	semicolon
.	dot
,	comma
~	tilde
`	backtick
?	question mark


### AI

• 常见工具大概分三类：

  最常用

  - Keyboard Layout Editor：https://www.keyboard-layout-editor.com/
    机械键盘圈最常见。适合画“静态键盘图”、键帽图、分享图。可以编辑按键大小、颜色、文字位置，也能下载 SVG/PNG/JPG/JSON。
    你的这种映射表，如果只是想画一张图给别人看，用它最快。
  - keymap-drawer：https://github.com/caksoylar/keymap-drawer
    更适合画“多层键位图”，比如 Base 层、Symbol 层、Nav 层、Hold-Tap、Combo 等。它用 YAML 描述布局，可以生成 SVG，也有网页版。官方主要支持解析
    QMK/ZMK；Kanata 解析器目前看还是 work-in-progress，但你可以手写 YAML 来画 Kanata 布局。

  想画得漂亮

  - Figma
    适合做很精致的说明图、博客配图、教程图。缺点是手工维护麻烦。
  - Inkscape / Illustrator
    适合直接编辑 SVG。keymap-drawer 或 KLE 导出的 SVG 可以再拿进去美化。

  快速草图

  - draw.io / diagrams.net
    适合画思路图，不太适合精确键盘布局。
  - Excalidraw
    适合手绘风说明图，表达“这个键改成这个功能”很直观。
  - Markdown 表格
    你现在这种其实已经很清楚，适合配置说明；缺点是没有空间位置感。

  如果是你这个 Kanata 映射，我建议：

  1. 先用 Keyboard Layout Editor 画一张 60%/87/104 键的基础图。
  2. 把改动键用颜色标出来，比如 Caps、Enter、'、q/w/e/r/t/a/s/d/f。
  3. 如果你后面做了 Symbol Layer、Nav Layer，再换成 keymap-drawer，因为多层图它更清楚。

  我个人会这样分工：

  只是给人看/打印：Keyboard Layout Editor
  要放到仓库里自动生成：keymap-drawer
  要做教程图/博客图：Figma 或 Inkscape
  临时讨论方案：Excalidraw

