
## 软件安装

```bash
# 不懂但是照做就行
sudo apt install rustup; rustup default stable

# 安装
cargo install kanata

```

设置环境变量(简单示例).

```bash
export PATH="$HOME/.cargo/bin:$PATH"
```


## 简单示例(一)

### 配置文件

配置文件 `demo.kdb` .

```kdb
(defcfg
  process-unmapped-keys yes
)

(defsrc
  a s e f
)

;; kanata 启动之后第一个层是默认层.
;; default  是层的名字.
(deflayer default
  1 2 3 4
)

```

功能是将字母'a s e f' 分别映射成 '1 2 3 4'，其他键位保持原样.

### 启动软件

```bash
# 指定配置文件启动
kanata --cfg demo.kbd
```

## 简单示例(二)

### 配置文件

```kbd
(defcfg
  process-unmapped-keys yes
)

(defsrc)

(deflayermap (arrows)
  w	up
  a	left
  s	down
  d	right
)
```

键盘摁键之间一一映射.


## 核心功能




## 配置函数

### linux-dev

查看键盘设备.

```bash
$ la -la /dev/input/by-path/
total 0
drwxr-xr-x 2 root root 160 May  6 08:48 .
drwxr-xr-x 3 root root 380 May 10 20:31 ..
lrwxrwxrwx 1 root root   9 May  5 10:16 platform-i8042-serio-0-event-kbd -> ../event3
lrwxrwxrwx 1 root root  10 May  5 10:16 platform-i8042-serio-1-event-mouse -> ../event10
lrwxrwxrwx 1 root root   9 May  5 10:16 platform-i8042-serio-1-mouse -> ../mouse2
lrwxrwxrwx 1 root root  10 May  5 10:16 platform-i8042-serio-2-event-mouse -> ../event11
lrwxrwxrwx 1 root root   9 May  5 10:16 platform-i8042-serio-2-mouse -> ../mouse3
lrwxrwxrwx 1 root root  10 May  5 10:16 platform-thinkpad_acpi-event -> ../event12

```

指定键盘设备.

```kbd
(defcfg
  linux-dev /dev/input/by-path/platform-i8042-serio-0-event-kbd
)
```

### linux-dev-names-include

```bash
$ cat /proc/bus/input/devices | more

# 省略好多内容...

I: Bus=0011 Vendor=0001 Product=0001 Version=ab83
N: Name="AT Translated Set 2 keyboard"
P: Phys=isa0060/serio0/input0
S: Sysfs=/devices/platform/i8042/serio0/input/input3
U: Uniq=
H: Handlers=sysrq kbd event3 leds 
B: PROP=0
B: EV=120013
B: KEY=402000002 3803078f800d001 feffffdfffefffff fffffffffffffffe
B: MSC=10
B: LED=7

#...

```

```kbd
linux-dev-names-include (
  "Device name"
)
```

绑定键盘设备.

### layer-while-held


## 附录

### TODO

- 简单示例

- 对于笔记本来说，可以同时运行两个kanata实例，绑定不同的配置文件.

  每个配置文件中通过`linux-dev` 限定设备.

- 如何桌面显示当前层


### adoc 文件转换成pdf

```bash

# 安装
sudo apt install ruby ruby-dev; gem install asciidoctor-pdf

# 执行转换
/home/yuchao/.local/share/gem/ruby/3.3.0/bin/asciidoctor-pdf README.adoc -o README.pdf

```

长久使用设置环境变量.

```bash
echo 'export PATH="$HOME/.local/share/gem/ruby/3.3.0/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### 参考资料

- [高级键盘映射：Kanata 快速入门](https://blog.hentioe.dev/posts/advanced-keymapping-kanata-tutorial.html)
- [HHKB 键盘布局配置方案](https://bitmingw.com/2017/07/29/hhkb-keyboard-layout-configuration/)

### AI

#### 实现桌面显示

• 可以实现，而且你说的“右上角 拼音 / En”就是一个很好的参照。

  我看了下你当前环境：

  GNOME Shell 48.0
  Ubuntu GNOME
  X11
  输入源: us / libpinyin / table:tiger
  IBus 正在运行

  也就是说，右上角的 拼音、En 不是普通窗口，也不是通知，而是：

  GNOME Shell 顶栏里的 Input Source Indicator
          ↑
  读取 GNOME 输入源状态
          ↑
  后端通常是 IBus / XKB

  其中：

  - En 来自 XKB 英文键盘布局，比如 xkb:us
  - 拼音 来自 IBus 输入法，比如 ibus:libpinyin
  - 顶栏显示是 GNOME Shell 自己画出来的
  - IBus 后台负责输入法状态，但面板显示由 GNOME Shell 接管

  你这里甚至能看到 IBus 是这样启动的：

  ibus-daemon --panel disable --xim

  --panel disable 的意思大致就是：IBus 自己不显示面板，让桌面环境 GNOME 来显示输入源状态。

  ———

  Kanata 能不能也做成这样？

  可以，但不是直接用 Kanata 内置功能，而是做一个：

  Kanata TCP 接口
      ↓
  GNOME Shell 扩展
      ↓
  右上角显示当前 Kanata 层

  效果可以类似：

  拼音  En  K:base
  拼音  En  K:nav
  拼音  En  K:sym

  或者更短：

  En  base
  En  nav
  En  sym

  也可以做成点击菜单：

  Kanata: nav
  - base
  - nav
  - symbol
  - mouse

  点一下直接切层。

  ———

  实现原理

  Kanata 启动时打开 TCP server：

  kanata -c your-config.kbd -p 127.0.0.1:7070

  然后外部程序可以问它当前在哪一层：

  echo '{"RequestCurrentLayerName":{}}' | nc localhost 7070

  返回类似：

  {"CurrentLayerName":{"name":"base"}}

  层变化时，Kanata 也会发事件：

  {"LayerChange":{"new":"nav"}}

  所以 GNOME Shell 扩展只需要做三件事：

  1. 在顶栏添加一个文字按钮
  2. 连接 Kanata 的 127.0.0.1:7070
  3. 收到 LayerChange 后更新显示文本

  这就能实现和输入法指示器很接近的效果。

  ———

  为什么不直接改“拼音 / En”那个地方？

  不建议。

  那个位置本质上是 GNOME 的输入源系统，和 IBus/XKB 绑定。理论上可以写一个假的 IBus engine 来显示 nav、base，但这会把 Kanata 层伪装成输入法，容易和真实中文输入法冲突。

  更合理的是：

  保留原来的 拼音 / En
  旁边新增一个 Kanata 层指示器

  这样不会影响输入法，也不会破坏 GNOME 的输入源逻辑。

  ———

  可选方案对比

  - GNOME Shell 扩展：最像右上角 拼音 / En，推荐
  - 桌面通知 notify-send：简单，但不是常驻状态
  - 悬浮小窗：容易实现，但不如顶栏自然
  - AppIndicator 托盘图标：能放右上角，但文字显示和交互不如 GNOME 扩展
  - 伪造 IBus 输入法：不推荐，容易和真实输入法冲突

  ———

  我的建议

  我们可以做一个小 GNOME Shell 扩展，比如名字叫：

  kanata-layer@yuchao

  显示逻辑：

  base        → K:base
  navigation  → K:nav
  symbols     → K:sym
  mouse       → K:mouse
  连接失败     → K:off

  然后 Kanata 用这个方式启动：

  kanata -c your-config.kbd -p 127.0.0.1:7070

  这样右上角就能像输入法状态一样显示当前层。

  可以实现，而且这应该是 Ubuntu GNOME 下最正统、最自然的做法。

• 可以。下面这个是 最小 GNOME 顶栏示例：在 Ubuntu 右上角显示当前 Kanata 层，比如：

  K:base
  K:nav
  K:symbol
  K:off

  它通过 Kanata 的 TCP 接口每秒查询一次当前层。

  ———

  1. 启动 Kanata 时开启 TCP

  先这样启动 Kanata：

  kanata -c your-config.kbd -p 127.0.0.1:7070

  可以先测试一下：

  echo '{"RequestCurrentLayerName":{}}' | nc 127.0.0.1 7070

  如果返回类似下面这样，说明 TCP 可用：

  {"CurrentLayerName":{"name":"base"}}

  ———

  2. 创建 GNOME Shell 扩展

  执行：

  UUID=kanata-layer@example.local
  EXT_DIR="$HOME/.local/share/gnome-shell/extensions/$UUID"

  mkdir -p "$EXT_DIR"

  创建 metadata.json：

  cat > "$EXT_DIR/metadata.json" <<'EOF'
  {
    "uuid": "kanata-layer@example.local",
    "name": "Kanata Layer Indicator",
    "description": "Show current Kanata layer in GNOME top bar",
    "shell-version": ["48"]
  }
  EOF

  创建 extension.js：

  cat > "$EXT_DIR/extension.js" <<'EOF'
  import Gio from 'gi://Gio';
  import GLib from 'gi://GLib';
  import St from 'gi://St';

  import {Extension} from 'resource:///org/gnome/shell/extensions/extension.js';
  import * as Main from 'resource:///org/gnome/shell/ui/main.js';
  import * as PanelMenu from 'resource:///org/gnome/shell/ui/panelMenu.js';

  const HOST = '127.0.0.1';
  const PORT = 7070;

  export default class KanataLayerExtension extends Extension {
      enable() {
          this._indicator = new PanelMenu.Button(0.0, 'Kanata Layer Indicator');

          this._label = new St.Label({
              text: 'K:...',
          });

          this._indicator.add_child(this._label);
          Main.panel.addToStatusArea(this.uuid, this._indicator, 0, 'right');

          this._queryLayer();

          this._timer = GLib.timeout_add_seconds(GLib.PRIORITY_DEFAULT, 1, () => {
              this._queryLayer();
              return GLib.SOURCE_CONTINUE;
          });
      }

      disable() {
          if (this._timer) {
              GLib.Source.remove(this._timer);
              this._timer = null;
          }

          if (this._indicator) {
              this._indicator.destroy();
              this._indicator = null;
          }

          this._label = null;
      }

      _setLayer(layer) {
          if (this._label)
              this._label.set_text(`K:${layer}`);
      }

      _queryLayer() {
          const client = new Gio.SocketClient();

          client.connect_to_host_async(HOST, PORT, null, (client, result) => {
              let connection = null;

              try {
                  connection = client.connect_to_host_finish(result);

                  const output = connection.get_output_stream();
                  const input = new Gio.DataInputStream({
                      base_stream: connection.get_input_stream(),
                  });

                  const request = new TextEncoder().encode(
                      '{"RequestCurrentLayerName":{}}\n'
                  );

                  output.write_all(request, null);
                  output.flush(null);

                  input.read_line_async(GLib.PRIORITY_DEFAULT, null, (stream, result) => {
                      try {
                          const [line] = stream.read_line_finish_utf8(result);

                          if (!line) {
                              this._setLayer('off');
                              return;
                          }

                          const msg = JSON.parse(line);
                          const layer = msg.CurrentLayerName?.name ?? msg.LayerChange?.new;

                          this._setLayer(layer || '?');
                      } catch (e) {
                          this._setLayer('err');
                      } finally {
                          connection.close_async(GLib.PRIORITY_DEFAULT, null, null);
                      }
                  });
              } catch (e) {
                  this._setLayer('off');

                  if (connection)
                      connection.close_async(GLib.PRIORITY_DEFAULT, null, null);
              }
          });
      }
  }
  EOF

  ———

  3. 重载 GNOME Shell 并启用扩展

  你现在是 GNOME + X11，可以按：

  Alt + F2
  输入 r
  回车

  然后启用扩展：

  gnome-extensions enable kanata-layer@example.local

  查看是否启用：

  gnome-extensions list --enabled | grep kanata-layer

  ———

  4. 效果

  如果 Kanata 正常运行并开启了 TCP：

  右上角显示：K:base

  切到 nav 层后：

  右上角显示：K:nav

  如果 Kanata 没启动，或者没有加 -p 127.0.0.1:7070：

  右上角显示：K:off

  ———

  这个示例是“轮询版”，实现简单，每秒查询一次。后面如果你想更精致，可以改成监听 Kanata 的 LayerChange 事件，这样切层后会立刻更新。

