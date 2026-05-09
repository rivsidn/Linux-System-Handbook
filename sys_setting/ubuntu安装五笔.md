
## 新世纪五笔安装

```bash
#!/usr/bin/env bash
set -Eeuo pipefail

# 安装位置：Fcitx5 的 Rime 用户配置目录。
RIME_DIR="${RIME_DIR:-$HOME/.local/share/fcitx5/rime}"
CONFIG_FILE="$RIME_DIR/default.custom.yaml"

# 新世纪五笔方案和拼音依赖来源；如需镜像源，可通过环境变量覆盖。
WUBI_REPO="${WUBI_REPO:-https://github.com/GuoBinyong/wubixinshiji.git}"
PINYIN_REPO="${PINYIN_REPO:-https://github.com/rime/rime-pinyin-simp.git}"

usage() {
  cat <<USAGE
用法：$0 install|uninstall

install   安装 fcitx5-rime 依赖、下载新世纪五笔方案、启用方案并重新部署
uninstall 删除新世纪五笔方案文件和 default.custom.yaml 里的方案入口

可选环境变量：
  RIME_DIR=/path/to/rime   指定 Rime 用户目录，默认：$RIME_DIR
  WUBI_REPO=...            指定新世纪五笔 Git 仓库
  PINYIN_REPO=...          指定袖珍简化字拼音 Git 仓库
USAGE
}

log() {
  printf '\n==> %s\n' "$*"
}

warn() {
  printf '警告：%s\n' "$*" >&2
}

require_cmd() {
  command -v "$1" >/dev/null 2>&1 || {
    echo "缺少命令：$1" >&2
    exit 1
  }
}

install_apt_deps() {
  if ! command -v apt-get >/dev/null 2>&1; then
    warn "未检测到 apt-get，跳过系统依赖安装；请手动安装 fcitx5-rime、librime-bin、git。"
    return
  fi

  # 这里会使用 sudo，目的是安装 Rime 前端和部署工具。
  log "安装系统依赖：fcitx5-rime librime-bin git"
  sudo apt-get update
  sudo apt-get install -y fcitx5-rime librime-bin git
}

backup_config() {
  mkdir -p "$RIME_DIR"
  if [[ -f "$CONFIG_FILE" ]]; then
    local backup="$CONFIG_FILE.bak.$(date +%Y%m%d%H%M%S)"
    cp "$CONFIG_FILE" "$backup"
    log "已备份配置：$backup"
  fi
}

install_scheme_files() {
  require_cmd git

  local tmpdir
  tmpdir="$(mktemp -d)"
  trap 'rm -rf "$tmpdir"' RETURN

  log "下载新世纪五笔方案"
  git clone --depth=1 "$WUBI_REPO" "$tmpdir/wubixinshiji"

  log "下载拼音依赖 pinyin-simp"
  git clone --depth=1 "$PINYIN_REPO" "$tmpdir/pinyin-simp"

  mkdir -p "$RIME_DIR/opencc"

  # 新世纪五笔主体：码表、三个方案、emoji/opencc 配置。
  cp "$tmpdir/wubixinshiji/wubixinshiji.dict.yaml" "$RIME_DIR/"
  cp "$tmpdir/wubixinshiji/wubixinshiji.schema.yaml" "$RIME_DIR/"
  cp "$tmpdir/wubixinshiji/wubixinshiji_pinyin.schema.yaml" "$RIME_DIR/"
  cp "$tmpdir/wubixinshiji/wubixinshiji_trad.schema.yaml" "$RIME_DIR/"
  cp "$tmpdir/wubixinshiji/opencc/"* "$RIME_DIR/opencc/"

  # 拼音反查、五笔拼音混输需要 pinyin-simp。
  cp "$tmpdir/pinyin-simp/pinyin_simp.dict.yaml" "$RIME_DIR/"
  cp "$tmpdir/pinyin-simp/pinyin_simp.schema.yaml" "$RIME_DIR/"
}

enable_schemas() {
  # 用少量 Python 做幂等文本修改：保留原文件，尽量只追加 schema_list 项。
  # 如果已有 default.custom.yaml，会先备份；如果没有，会创建最小配置。
  python3 - "$CONFIG_FILE" <<'PY'
import pathlib
import re
import sys

path = pathlib.Path(sys.argv[1])
schemas = ["wubixinshiji", "wubixinshiji_pinyin", "wubixinshiji_trad"]

if path.exists():
    text = path.read_text(encoding="utf-8")
else:
    text = ""

existing = set(re.findall(r"schema:\s*([A-Za-z0-9_+-]+)", text))
to_add = [schema for schema in schemas if schema not in existing]

if not text.strip():
    text = "patch:\n  schema_list:\n" + "".join(f"    - schema: {s}\n" for s in schemas)
elif to_add:
    lines = text.splitlines(keepends=True)
    schema_idx = next((i for i, line in enumerate(lines) if re.match(r"^(\s*)schema_list:\s*(#.*)?$", line)), None)

    if schema_idx is not None:
        indent = re.match(r"^(\s*)", lines[schema_idx]).group(1) + "  "
        insert = [f"{indent}- schema: {s}\n" for s in to_add]
        lines[schema_idx + 1:schema_idx + 1] = insert
        text = "".join(lines)
    else:
        patch_idx = next((i for i, line in enumerate(lines) if re.match(r"^patch:\s*(#.*)?$", line)), None)
        block = "  schema_list:\n" + "".join(f"    - schema: {s}\n" for s in to_add)
        if patch_idx is not None:
            lines[patch_idx + 1:patch_idx + 1] = [block]
            text = "".join(lines)
        else:
            if not text.endswith("\n"):
                text += "\n"
            text += "\npatch:\n" + block

path.parent.mkdir(parents=True, exist_ok=True)
path.write_text(text, encoding="utf-8")
PY
}

disable_schemas() {
  [[ -f "$CONFIG_FILE" ]] || return 0

  # 只删除本脚本加入的三个新世纪五笔入口，不动其它 Rime 配置。
  python3 - "$CONFIG_FILE" <<'PY'
import pathlib
import re
import sys

path = pathlib.Path(sys.argv[1])
remove = {"wubixinshiji", "wubixinshiji_pinyin", "wubixinshiji_trad"}
lines = path.read_text(encoding="utf-8").splitlines(keepends=True)
kept = []
for line in lines:
    match = re.search(r"schema:\s*([A-Za-z0-9_+-]+)", line)
    if match and match.group(1) in remove:
        continue
    kept.append(line)
path.write_text("".join(kept), encoding="utf-8")
PY
}

deploy_rime() {
  # 重新部署后，Rime 才会读取新方案；重载 Fcitx5 让列表刷新。
  if command -v rime_deployer >/dev/null 2>&1; then
    log "重新部署 Rime"
    rime_deployer --build "$RIME_DIR" || warn "Rime 部署失败，请打开 Fcitx5 配置工具手动部署。"
  else
    warn "未找到 rime_deployer，请安装 librime-bin 后手动部署。"
  fi

  if command -v fcitx5-remote >/dev/null 2>&1; then
    log "重载 Fcitx5"
    fcitx5-remote -r || warn "Fcitx5 重载失败，重新登录也可以生效。"
  fi
}

install_main() {
  install_apt_deps
  backup_config
  install_scheme_files
  enable_schemas
  deploy_rime

  log "安装完成"
  cat <<MSG
下一步：
1. 运行 fcitx5-configtool
2. 添加 Rime 输入法
3. 切到 Rime 后按 Ctrl+~ 或 F4，选择“新世纪五笔”
MSG
}

uninstall_main() {
  backup_config
  disable_schemas

  log "删除新世纪五笔方案文件"
  rm -f \
    "$RIME_DIR/wubixinshiji.dict.yaml" \
    "$RIME_DIR/wubixinshiji.schema.yaml" \
    "$RIME_DIR/wubixinshiji_pinyin.schema.yaml" \
    "$RIME_DIR/wubixinshiji_trad.schema.yaml" \
    "$RIME_DIR/opencc/emoji.json" \
    "$RIME_DIR/opencc/emoji_category.txt" \
    "$RIME_DIR/opencc/emoji_word.txt"

  # pinyin-simp 可能被其它 Rime 方案复用，所以这里保留，不主动删除。
  rmdir "$RIME_DIR/opencc" 2>/dev/null || true
  deploy_rime

  log "卸载完成；fcitx5-rime/librime-bin/git 未卸载，避免影响其它输入方案。"
}

case "${1:-}" in
  install)
    install_main
    ;;
  uninstall)
    uninstall_main
    ;;
  -h|--help|help|"")
    usage
    ;;
  *)
    echo "未知参数：$1" >&2
    usage >&2
    exit 1
    ;;
esac
```

## 98五笔安装

```bash
sudo apt update
sudo apt install -y fcitx5 fcitx5-frontend-all fcitx5-config-qt fcitx5-table-wubi98
im-config -n fcitx5
```


```bash
sudo apt install -y fcitx5-table-wubi98-pinyin fcitx5-table-wubi98-single
```
