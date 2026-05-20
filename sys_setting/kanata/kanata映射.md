
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
| Alt + u      | page up   | 上翻页                     |
| Alt + i      | page down | 下翻页                     |

## 配置文件

![键位映射](kanata-layout.svg)

配置文件.

```kbd
;; Quote-key symbol layer for a US-QWERTY OS layout.
;; - tap Enter: Enter with no tap-hold delay
;; - hold apostrophe ('): symbols/nav/edit layer only; tapping it outputs nothing

(defcfg
  process-unmapped-keys yes
)

(defvar
  td 200
)

(defalias
  ;; Shift also activates a small shifted layer so Shift+Caps outputs Caps Lock.
  sfl (multi lsft (layer-while-held shifted))
  sfr (multi rsft (layer-while-held shifted))

  ;; Apostrophe is only a layer key; tapping it does not emit apostrophe.
  quo (layer-while-held symbols)

  ;; Force Caps output without carrying Shift through.
  cap (unshift caps)

  ;; Tap-dance pairs inside the apostrophe symbols layer.
  ;; 1 tap / 2 taps: double quote / single quote.
  dq  (tap-dance $td (S-' '))
  cb  (tap-dance $td (S-[ S-]))
  br  (tap-dance $td ([ ]))
  pr  (tap-dance $td (S-9 S-0))

  ;; Symbols that require Shift on a US-QWERTY layout.
  pipe S-\
  plus S-=
  star S-8
  us   S--
  ques S-/
)

(defsrc
  grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
  tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
  caps a    s    d    f    g    h    j    k    l    ;    '         ret
  lsft z    x    c    v    b    n    m    ,    .    /              rsft
  lctl lmet lalt                spc                 ralt rmet rctl
)

(deflayer base
  grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
  tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
  lctl a    s    d    f    g    h    j    k    l    ;    @quo      ret
  @sfl z    x    c    v    b    n    m    ,    .    /              @sfr
  lctl lmet lalt                spc                 ralt rmet rctl
)

;; Shift+Caps -> Caps Lock.
(deflayer shifted
  _    _    _    _    _    _    _    _    _    _    _    _    _    _
  _    _    _    _    _    _    _    _    _    _    _    _    _    _
  @cap _    _    _    _    _    _    _    _    _    _    _          _
  @sfl _    _    _    _    _    _    _    _    _    _               @sfr
  _    _    _                   _                   _    _    _
)

;; Hold apostrophe, then press a key in this layer.
(deflayer symbols
  _    _    _    _    _    _    _    _    _    _    _    _     _    _
  esc  @dq  @cb  @br  @pr  @pipe _    _    _    _    up   _     _    _
  bspc @plus -    @star /    =    _    _    _    left rght _          _
  _    @us  @ques grv  \    _    _    _    _    down _               _
  _    _    _                   _                   _    _    _
)

;; Alt+u/i -> Page Down/Page Up; Alt+h/j/k/l -> arrow keys.
;; Both left and right Alt are supported.
(defoverrides
  (lalt u) (pgdn)
  (lalt i) (pgup)
  (lalt h) (left)
  (lalt j) (down)
  (lalt k) (up)
  (lalt l) (rght)
  (ralt u) (pgdn)
  (ralt i) (pgup)
  (ralt h) (left)
  (ralt j) (down)
  (ralt k) (up)
  (ralt l) (rght)
)
```

## 设置开机自启动

### service 文件

```
[Unit]
Description=Kanata keyboard remapper
After=systemd-udev-settle.service
Wants=systemd-udev-settle.service

[Service]
Type=simple
ExecStart=/home/yuchao/.cargo/bin/kanata --cfg /home/yuchao/.config/kanata/kanata.kbd --no-wait
Restart=on-failure
RestartSec=2

[Install]
WantedBy=multi-user.target
```

### install 脚本

```bash
#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

install -d /home/yuchao/.config/kanata
install -m 0644 enter-tool-layer.kbd /home/yuchao/.config/kanata/kanata.kbd
sudo install -m 0644 kanata.service /etc/systemd/system/kanata.service
sudo systemctl daemon-reload
sudo systemctl enable --now kanata.service
systemctl status kanata.service --no-pager
```

## 附录


