
## 配置方式

- 手动配置
- NetworkManager 配置
-

## 



• Linux 下 DNS 配置看起来比较乱，是因为 /etc/resolv.conf 往往只是“最终结果”，真正管理它的可能是 NetworkManager、systemd、DHCP 客户端或 VPN 软件。

  整体链路通常是：

  应用程序
     ↓
  /etc/nsswitch.conf
     ├─ /etc/hosts
     ├─ systemd-resolved
     └─ DNS 服务器
            ├─ 公司内网 DNS
            └─ 公共 DNS

  ## 先判断谁在管理 DNS

  开始修改前，建议先执行：

  ls -l /etc/resolv.conf
  readlink -f /etc/resolv.conf
  cat /etc/resolv.conf

  然后检查常见管理组件：

  resolvectl status
  nmcli general status
  nmcli device show | grep -E 'GENERAL.DEVICE|IP4.DNS|IP4.DOMAIN'

  常见情况如下：

   /etc/resolv.conf 指向或来源              DNS 管理者
  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
   普通文件                                 可能是手工配置、DHCP 或脚本
  ───────────────────────────────────────  ─────────────────────────────
   /run/systemd/resolve/stub-resolv.conf    systemd-resolved
  ───────────────────────────────────────  ─────────────────────────────
   /run/systemd/resolve/resolv.conf         systemd-resolved
  ───────────────────────────────────────  ─────────────────────────────
   NetworkManager 生成标记                  NetworkManager
  ───────────────────────────────────────  ─────────────────────────────
   /run/resolvconf/resolv.conf              resolvconf/openresolv

  ## 1. 直接配置 /etc/resolv.conf

  最传统的方式：

  nameserver 192.168.51.51
  nameserver 8.8.8.8
  search venusgroup.com.cn
  options timeout:2 attempts:2

  字段含义：

  - nameserver：DNS 服务器地址。
  - search：补全短域名，例如访问 gitlab 时尝试 gitlab.venusgroup.com.cn。
  - options timeout:2：单次查询等待时间。
  - options attempts:2：重试次数。
  - options rotate：在多个 DNS 之间轮换，而不是总从第一个开始。

  优点是简单、立即生效；缺点是很可能被 DHCP、NetworkManager 或 VPN 覆盖。

  适合：

  - 临时排查
  - 极简服务器
  - 没有网络管理服务的静态系统

  不建议在桌面 Linux、笔记本或需要 VPN 的机器上长期手工维护。

  ## 2. 使用 NetworkManager

  Ubuntu Desktop、Fedora、CentOS/RHEL 桌面版等经常使用 NetworkManager。

  查看连接：

  nmcli connection show

  查看当前 DNS：

  nmcli device show | grep -E 'GENERAL.DEVICE|IP4.DNS|IP4.DOMAIN'

  为某个连接设置 DNS：

  nmcli connection modify "连接名称" \
    ipv4.ignore-auto-dns yes \
    ipv4.dns "192.lass="final">
  168.51.51 8.8.8.8"

  重新启用连接：

  nmcli connection down "连接名称"
  nmcli connection up "连接名称"

  如果要保留 DHCP 下发的 DNS，同时额外增加 DNS：

  nmcli connection modify "连接名称" \
    ipv4.ignore-auto-dns no \
    ipv4.dns "192.168.51.51"

  NetworkManager 还可以配合 systemd-resolved 设置 Split DNS：

  nmcli connection modify "VPN连接名称" \
    ipv4.dns "192.168.51.51" \
    ipv4.dns-search "~venusgroup.com.cn"

  前面的 ~ 表示 routing domain：

  *.venusgroup.com.cn → 192.168.51.51

  这不是普通的域名补全，而是指定哪些 DNS 查询走该连接。

  适合：

  - 桌面 Linux
  - Wi-Fi 和有线网络频繁切换
  - VPN、内网和公网混合使用
  - 希望配置重启后保留

  ## 3. 使用 systemd-resolved

  许多现代发行版使用 systemd-resolved 作为本地 DNS 解析与缓存服务。

  这时 /etc/resolv.conf 经常是：

  nameserver 127.0.0.53

  127.0.0.53 不是最终 DNS，而是本机的 systemd DNS Stub。真正的上游服务器通过下面的命令查看：

  resolvectl status

  查询域名：

  resolvectl query aigateway.venusgroup.com.cn

  临时为某个接口设置 DNS：

  sudo resolvectl dns etrust 192.168.51.51

  为该接口设置 Split DNS：

  sudo resolvectl domain etrust '~venusgroup.com.cn'

  查看结果：

  resolvectl status etrust

  这样形成：

  etrust 接口
  ├─ DNS: 192.168.51.51
  └─ 域名: ~venusgroup.com.cn

  其他域名仍然可以通过普通网络接口的 DNS 查询。

  注意：直接运行 resolvectl dns 和 resolvectl domain 通常属于运行时配置，接口断开或系统重启后可能消失。永久配置应写入 NetworkManager、systemd-networkd 或 VPN 配置。

  全局配置文件是：

  /etc/systemd/resolved.conf

  例如：

  [Resolve]
  DNS=192.168.51.51 8.8.8.8
  FallbackDNS=1.1.1.1
  DNSOverTLS=opportunistic

  修改后：

  sudo systemctl restart systemd-resolved

  不过，接口级 DNS 通常应该在网络管理器里配置，而不是全部写进 resolved.conf。

  ## 4. 使用 systemd-networkd

  服务器环境可能使用 systemd-networkd。配置位于：

  /etc/systemd/network/*.network

  例如：

  [Match]
  Name=eth0

  [Network]
  DHCP=yes
  DNS=192.168.51.51
  DNS=8.8.8.8
  Domains=~venusgroup.com.cn

  然后重启：

  sudo systemctl restart systemd-networkd
  sudo systemctl restart systemd-resolved

  这里的：

  Domains=~venusgroup.com.cn

  也是 Split DNS routing domain。

  适合：

  - 使用 systemd 的服务器
  - 静态网络接口
  - 不使用 NetworkManager 的环境

  ## 5. 使用 Netplan

  Ubuntu Server 常使用 Netplan。配置位于：

  /etc/netplan/*.yaml

  例如静态 DNS：

  network:
    version: 2
    ethernets:
      eth0:
        dhcp4: true
        nameservers:
          addresses:
            - 192.168.51.51
            - 8.8.8.8
          search:
            - venusgroup.com.cn

  应用：

  sudo netplan try
  sudo netplan apply

  netplan try 比较安全：如果网络断开，超时后可以自动回滚。

  Netplan 只是配置生成器，底层通常仍然交给：

  NetworkManager
  或
  systemd-networkd

  需要注意，Netplan 的 search 主要表示搜索域，不一定等价于 systemd-resolved 的 ~domain 分流域。复杂 Split DNS 最好在底层 renderer 或 VPN 配置中处理。

  ## 6. 通过 DHCP 自动获得 DNS

  大多数机器默认由 DHCP 获得：

  IP 地址
  网关
  DNS 服务器
  搜索域

  例如公司网络接入后，DHCP 可能自动下发：

  DNS = 192.168.51.51
  Domain = venusgroup.com.cn

  不同系统可能使用：

  - NetworkManager 内置 DHCP
  - systemd-networkd
  - dhclient
  - dhcpcd

  老式 dhclient 可以在下面的文件中覆盖 DNS：

  /etc/dhcp/dhclient.conf

  例如强制替换：

  supersede domain-name-servers 192.168.51.51, 8.8.8.8;

  或者在 DHCP DNS 前面添加：

  prepend domain-name-servers 192.168.51.51;

  现代桌面系统通常不建议直接修改 dhclient.conf，优先使用 NetworkManager。

  ## 7. 使用 resolvconf 或 openresolv

  Debian、Gentoo、Alpine 和部分旧系统可能使用 resolvconf 合并多个来源的 DNS：

  物理网卡 DNS
  VPN DNS
  DHCP DNS
  静态 DNS
         ↓
  resolvconf
         ↓
  /etc/resolv.conf

  查看是否安装：

  command -v resolvconf

  配置位置因发行版而异，常见包括：

  /etc/resolvconf/resolv.conf.d/head
  /etc/resolvconf/resolv.conf.d/base
  /etc/resolvconf/resolv.conf.d/tail

  修改后更新：

  sudo resolvconf -u

  如果系统已经使用 NetworkManager 加 systemd-resolved，通常没有必要再额外引入 resolvconf。

  ## 8. 由 VPN 客户端配置 DNS

  企业 VPN 经常在连接后注入：

  - 内网 DNS
  - 内网搜索域
  - 到内网 DNS 的路由
  - Split DNS 规则

  你的 etrust 接口很可能属于这种情况：

  etrust
  ├─ 地址：10.8.249.126
  ├─ 内网 DNS：192.168.51.51
  ├─ 内网服务：10.20.8.50
  └─ 域名：venusgroup.com.cn

  正确的企业 VPN 配置应该同时建立：

  到 10.20.8.50 的网络路由
  +
  venusgroup.com.cn 的 DNS 分流

  如果 VPN 只建立路由，没有正确注入 DNS，就会出现“IP 可达，但域名解析失败”。

  最佳方案是让 VPN 客户端或 NetworkManager 自动配置：

  ~venusgroup.com.cn → 192.168.51.51

  而不是依赖 /etc/resolv.conf 中谁排第一。

  ## 9. 本地 DNS 缓存或转发器

  还可以在本机运行：

  - dnsmasq
  - Unbound
  - dnscrypt-proxy
  - cloudflared

  应用只查询本地地址：

  nameserver 127.0.0.1

  由本地服务完成分流：

  venusgroup.com.cn → 192.168.51.51
  其他域名           → 8.8.8.8 / 1.1.1.1

  dnsmasq 的分流示例：

  server=/venusgroup.com.cn/192.168.51.51
  server=8.8.8.8

  这种方式灵活，但会增加一个需要维护的本地服务。现代 systemd 系统通常优先使用 systemd-resolved 的 routing domain。

  ## 常用排查命令

  检查系统实际解析结果：

  getent hosts aigateway.venusgroup.com.cn

  getent 最接近普通应用的解析行为，因为它遵循 /etc/nsswitch.conf。

  检查 systemd-resolved：

  resolvectl query aigateway.venusgroup.com.cn
  resolvectl status

  直接询问指定 DNS：

  dig @192.168.51.51 aigateway.venusgroup.com.cn
  dig @8.8.8.8 aigateway.venusgroup.com.cn

  检查 DNS 之外的网络连接：

  curl -v https://aigateway.venusgroup.com.cn/

  这里要区分：

  Could not resolve host  → DNS 问题
  Connection timed out    → 路由、防火墙或服务问题
  TLS/certificate error   → 证书或代理问题
  401/403                 → 网络已通，进入鉴权阶段

  针对你现在的情况，短期保持内网 DNS 在前可以工作；长期更适合为 etrust 接口配置 Split DNS，让 venusgroup.com.cn 专门走 192.168.51.51，其他域名继续使用正常公网 DNS。





