

改键方案.


- ubuntu 自带改键


## ubuntu 自带改键


``` bash

# 查看当前配置
gsettings get org.gnome.desktop.input-sources xkb-options

# 设置caps为ctrl
gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:nocaps']"

# 恢复默认配置
gsettings reset org.gnome.desktop.input-sources xkb-options

```

参数说明:

| 参数            | 说明                            |
|-----------------|---------------------------------|
| caps:swapescape | caps 与 esc 交换                |
| caps:escape     | caps 设置成esc，caps 功能不存在 |
| ctrl:swapcaps   | ctrl 与 左侧caps 交换           |
| ctrl:nocaps     | caps 映射成ctrl                 |





## keyd 配置







## 附录


### 待整理


```

# Ubuntu 键盘映射

整理时间：2026-03-19

## 结论速览

Ubuntu 下的改键方案可以按场景这样选：

- 只想做少量固定换键，比如 `CapsLock` 和 `Esc` 对调：优先用系统自带的 `XKB/gsettings`
- 想用图形界面配置改键、组合键、宏：用 `input-remapper`
- 想做系统级、低延迟、稳定的改键：用 `keyd`
- 想按应用分别改键：用 `xremap`
- 想做复杂层、`tap-hold`、接近 QMK 的玩法：用 `kanata`

不建议优先使用 `xmodmap`。它偏老，主要适用于 `X11`，在当前常见的 `Wayland` 场景下不是首选。


## 系统自带方案

如果只是做标准换键，系统自带方案最稳。

例如把 `CapsLock` 和 `Esc` 对调：

```bash
gsettings set org.gnome.desktop.input-sources xkb-options "['caps:swapescape']"
```

常见选项：

- `caps:swapescape`
- `caps:escape`
- `ctrl:swapcaps`

适用场景：

- 只改少数键位
- 不需要宏
- 不需要按应用区分规则


## 常见改键工具

### input-remapper

特点：

- 有图形界面
- 支持 `Wayland/X11`
- 支持组合键、预设、宏

适合：

- 想少折腾，尽快上手
- 想可视化管理改键规则
- 需要做简单宏

### keyd

特点：

- 系统级 daemon
- 延迟低，比较稳
- 适合双功能键和层映射

适合：

- 想把 `CapsLock` 做成点按 `Esc`、长按 `Ctrl`
- 需要长期稳定使用
- 能接受编辑配置文件和 systemd 服务

### xremap

特点：

- 支持 `Wayland`
- 支持按应用分别改键
- 支持触发命令和按键序列

适合：

- 不同软件需要不同快捷键规则
- 想做更细粒度的桌面行为定制

### kanata

特点：

- 功能上限很高
- 支持层、`tap-hold`、宏、Unicode、鼠标动作
- 配置能力接近“键盘固件语言”

适合：

- 要做复杂层逻辑
- 要做 `home-row mods`
- 已经能接受较高配置复杂度


## 易用性排序

从最容易上手到最折腾：

1. `input-remapper`
2. `keyd`
3. `xremap`
4. `kanata`

补充说明：

- `input-remapper` 有 GUI，上手最快
- `keyd` 配置简单，但需要系统级配置
- `xremap` 功能更细，但理解成本更高
- `kanata` 最强，也最需要投入学习成本


## 功能高级排序

从功能上限较低到较高：

1. `input-remapper`
2. `keyd`
3. `xremap`
4. `kanata`

补充说明：

- `input-remapper` 够用，但更偏“常见需求”
- `keyd` 很适合系统级双功能键和层
- `xremap` 的按应用映射是明显优势
- `kanata` 在层、宏、`tap-hold` 方面最灵活


## 能否通过快捷键自动输入一串密码

技术上支持，但不推荐把真实密码直接写进改键配置。

可行性：

- `input-remapper` 支持宏
- `kanata` 支持宏
- `xremap` 可以映射成按键序列或触发命令
- `keyd` 也支持宏

问题在于：

- 密码可能会直接保存在配置文件里，等于明文保存
- 一旦焦点窗口错了，密码可能会被输入到聊天框、终端或日志里
- 某些自动输入方案在 `Wayland` 下兼容性不如密码管理器稳定

结论：

- “按快捷键自动输入固定字符串”可以做
- “把登录密码硬编码到改键软件里”不建议


## 更安全的替代方案

### 网页登录

优先使用密码管理器的自动填充能力，例如 `Bitwarden` 浏览器扩展。

默认常见用法：

- `Ctrl+Shift+L` 自动填充当前网站登录信息

可以再配合改键工具，把自己习惯的快捷键映射成 `Ctrl+Shift+L`。

### 桌面应用登录

可以考虑 `KeePassXC Auto-Type`。

注意：

- Linux 下 `Wayland` 对自动输入支持有限
- `KeePassXC` 的 Auto-Type 在 Linux 上通常更适合 `X11/xcb` 场景


## 推荐策略

### 只想改一个键位

先用 `gsettings/XKB`，最稳。

### 想做 GUI 改键和普通宏

先试 `input-remapper`。

### 想做双功能键

优先看 `keyd` 或 `kanata`。

### 想按应用分别改键

优先看 `xremap`。

### 想做密码输入

不要把密码写进改键配置。

更合理的做法是：

- 改键工具负责触发快捷键
- `Bitwarden` 或 `KeePassXC` 负责安全填充


## 官方参考

- GNOME `xkb-options` 文档: <https://help.gnome.org/system-admin-guide/keyboard-compose-key.html>
- Ubuntu `xkeyboard-config` manpage: <https://manpages.ubuntu.com/manpages/jammy/man7/xkeyboard-config.7.html>
- input-remapper: <https://github.com/sezanzeb/input-remapper>
- input-remapper 宏文档: <https://github.com/sezanzeb/input-remapper/blob/main/readme/macros.md>
- keyd: <https://github.com/rvaiya/keyd>
- xremap: <https://github.com/xremap/xremap>
- kanata: <https://github.com/jtroo/kanata>
- kanata 配置指南: <https://github.com/jtroo/kanata/wiki/Configuration-guide>
- Bitwarden 键盘快捷键: <https://bitwarden.com/help/keyboard-shortcuts/>
- Bitwarden 自动填充: <https://bitwarden.com/help/auto-fill-browser/>
- KeePassXC 用户指南: <https://keepassxc.org/docs/KeePassXC_UserGuide>
- xmodmap Ubuntu manpage: <https://manpages.ubuntu.com/manpages/xenial/man1/xmodmap.1.html>

```
