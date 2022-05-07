```
IPVSADM(8)             Linux Administrator's Guide             IPVSADM(8)

NAME
       ipvsadm - Linux Virtual Server administration
                 Linux 虚拟服务器管理
SYNOPSIS
       ipvsadm -A|E virtual-service [-s scheduler] [-p [timeout]] [-M netmask] [-b sched-flags]
       ipvsadm -D virtual-service
       ipvsadm -C
       ipvsadm -R
       ipvsadm -S [-n]
       ipvsadm -a|e virtual-service -r server-address [-g|i|m] [-w weight] [-x upper] [-y lower]
       ipvsadm -d virtual-service -r server-address
       ipvsadm -L|l [virtual-service] [options]
       ipvsadm -Z [virtual-service]
       ipvsadm --set tcp tcpfin udp
       ipvsadm --start-daemon state [daemon-options] [--syncid syncid]
       ipvsadm --stop-daemon state
       ipvsadm -h

DESCRIPTION
       Ipvsadm(8)  is  used  to  set  up, maintain or inspect the virtual
       server table in the Linux kernel. The Linux Virtual Server can  be
       used  to build scalable network services based on a cluster of two
       or more nodes. The active node of the  cluster  redirects  service
       requests  to  a collection of server hosts that will actually per‐
       form the services.  Supported  features  include  three  protocols
       (TCP, UDP and SCTP), three packet-forwarding methods (NAT, tunnel‐
       ing, and direct routing),  and  eight  load  balancing  algorithms
       (round  robin,  weighted  round  robin, least-connection, weighted
       least-connection, locality-based least-connection,  locality-based
       least-connection   with   replication,   destination-hashing,  and
       source-hashing).
       ipvsadm 用于建立、维护、监控内核中的虚拟服务器。Linux虚拟服务器可以基于一个或
       多个节点的集群构建一个可拓展的网络服务。集群active的节点将服务请求重定向到真实的
       服务器处理。支持三种协议(TCP,UDP,SCTP)，三种报文转发模式(NAT,隧道,直接路由),
       八种负载均衡算法。

       The command has two basic formats for execution:
       命令有两种最基本的格式:

       ipvsadm COMMAND virtual-service
               [scheduling-method] [persistence options]

       ipvsadm command virtual-service
               server-address [packet-forwarding-method]
               [weight options]

       The first format manipulates a virtual service and  the  algorithm
       for assigning service requests to real servers. Optionally, a per‐
       sistent timeout and network mask for the granularity of a  persis‐
       tent service and a persistence engine may be specified. The second
       format manipulates a real server that is associated with an exist‐
       ing  virtual  service.  When specifying a real server, the packet-
       forwarding method and the weight of the real server,  relative  to
       other real servers for the virtual service, may be specified, oth‐
       erwise defaults will be used.
       第一种格式用于设置虚拟服务和将服务请求分配给实际物理设备的算法。维持时间、用于
       维持服务粒度的子网掩码、维持引擎，是可选项。
       第二种格式用于设置与虚拟服务关联的具体服务器，指定具体服务器的时候，可以指定转发
       方式和服务器的权重，如果不指定，使用默认值。

   COMMANDS
       ipvsadm(8) recognises the  commands  described  below.  Upper-case
       commands  maintain  virtual services. Lower-case commands maintain
       real servers that are associated with a virtual service.
       ipvsadm 命令如下，大写命令管理虚拟服务，小写命令管理与虚拟服务相关的服务器。

       -A, --add-service
              Add a virtual service. A service address  is  uniquely  de‐
              fined  by a triplet: IP address, port number, and protocol.
              Alternatively, a virtual service may be defined by a  fire‐
              wall-mark.
              添加一个虚拟服务。虚拟服务的地址可以被三元组唯一指定: IP地址、端口号、协议。
              也可以通过防火墙标识指定虚拟服务。

       -E, --edit-service
              Edit a virtual service.
              编译一个虚拟服务。

       -D, --delete-service
              Delete  a  virtual  service, along with any associated real
              servers.
              删除一个虚拟服务和与其相关的真是服务器。

       -C, --clear
              Clear the virtual server table.
              清空虚拟服务器表。

       -R, --restore
              Restore Linux Virtual Server rules from  stdin.  Each  line
              read from stdin will be treated as the command line options
              to a separate invocation of ipvsadm. Lines read from  stdin
              can optionally begin with "ipvsadm".  This option is useful
              to avoid executing a large number or ipvsadm  commands when
              constructing an extensive routing table.
              从标准输入中导入虚拟服务器配置规则，从输入读取的每行都是条ipvsadm命令，
              每行开始可以有"ipvsadm"也可以没有。

       -S, --save
              Dump  the  Linux Virtual Server rules to stdout in a format
              that can be read by -R|--restore.
              将虚拟服务器的配置规则，以一种 -R|--restore 可以识别的方式导出到标准
              输出。

       -a, --add-server
              Add a real server to a virtual service.
              添加真实的服务器到虚拟服务中

       -e, --edit-server
              Edit a real server in a virtual service.
              编辑服务中的真实服务器

       -d, --delete-server
              Remove a real server from a virtual service.
              删除服务中的真实服务器

       -L, -l, --list
              List the virtual server table if no argument is  specified.
              If  a  service-address is selected, list this service only.
              If the -c option is selected, then display  the  connection
              table.  The exact output is affected by the other arguments
              given.
              如果没有指定其他参数，显示虚拟服务器表；如果指定了服务地址，只显示该指定
              地址的；如果指定了 -c 选项，将显示链接表。
              该选项的输出收其他参数影响。

       -Z, --zero
              Zero the packet, byte and rate counters in a service or all
              services.
              清空一个服务或者所有服务的报文、字节、速率统计

       --set tcp tcpfin udp
              Change  the  timeout values used for IPVS connections. This
              command  always  takes  3  parameters,   representing   the
              timeout  values (in seconds) for TCP sessions, TCP sessions
              after receiving a  FIN packet, and  UDP   packets,  respec‐
              tively.   A  timeout value 0 means that the current timeout
              value of the  corresponding  entry  is preserved.
              修改链接超时时间，0 表示保持当前时间不变。

       --start-daemon state
              Start the connection synchronization daemon. The  state  is
              to indicate that the daemon is started as master or backup.
              The connection synchronization daemon is implemented inside
              the  Linux kernel. The master daemon running at the primary
              load balancer multicasts changes  of  connections  periodi‐
              cally,  and  the  backup  daemon running at the backup load
              balancers receives multicast  message  and  creates  corre‐
              sponding  connections.  Then, in case the primary load bal‐
              ancer fails, a backup load balancer will takeover,  and  it
              has state of almost all connections, so that almost all es‐
              tablished connections can continue to access the service.
              开启链接同步守护进程。

       The sync daemon supports IPv4 and IPv6 connections.
       同步进程支持IPv4和IPv6链接。

       --stop-daemon
              Stop the connection synchronization daemon.
              关闭链接同步守护进程。

       -h, --help
              Display a description of the command syntax.
              显示帮助信息。

   virtual-service
       Specifies the virtual service based on protocol/addr/port or fire‐
       wall mark.
       指定虚拟服务。

       -t, --tcp-service service-address
              Use  TCP  service.  The  service-address  is  of  the  form
              host[:port].  Host may be one of a plain IP  address  or  a
              hostname.  Port  may  be  either a plain port number or the
              service name of port. The Port may  be  omitted,  in  which
              case  zero  will  be used. A Port  of zero is only valid if
              the service is persistent as the -p|--persistent option, in
              which case it is a wild-card port, that is connections will
              be accepted to any port.
              使用TCP服务，服务地址格式为host[:port]。

       -u, --udp-service service-address
              Use UDP service. See the -t|--tcp-service for the  descrip‐
              tion of  the service-address.
              使用UDP服务。

       --sctp-service service-address
              Use SCTP service. See the -t|--tcp-service for the descrip‐
              tion of the service-address.
              使用SCTP服务。

       -f, --fwmark-service integer
              Use a firewall-mark, an integer value greater than zero, to
              denote  a  virtual  service instead of an address, port and
              protocol (UDP, TCP or SCTP). The marking of packets with  a
              firewall-mark  is  configured using the -m|--mark option to
              iptables(8), the meta mark set value option  to  nft(8)  or
              via an eBPF program. It can be used to build a virtual ser‐
              vice associated with the same real servers, covering multi‐
              ple  IP  address,  port  and protocol triplets. If IPv6 ad‐
              dresses are used, the -6 option must be used.
              通过firewall-mark 指定虚拟服务。

              Using firewall-mark virtual services provides a  convenient
              method  of  grouping together different IP addresses, ports
              and protocols into a single virtual service. This is useful
              for  both  simplifying  configuration  if a large number of
              virtual services  are  required  and  grouping  persistence
              across what would otherwise be multiple virtual services.

   PARAMETERS
       The commands above accept or require zero or more of the following
       parameters.

       -s, --scheduler scheduling-method
              scheduling-method  Algorithm for allocating TCP connections
              and  UDP  datagrams to real servers.  Scheduling algorithms
              are implemented as kernel modules. Ten are shipped with the
              Linux Virtual Server:
              调度算法

              rr  -  Round  Robin:  distributes  jobs equally amongst the
              available real servers.
              每个真实的服务器之间按照同等优先级分配工作。

              wrr - Weighted Round Robin: assigns jobs  to  real  servers
              proportionally  to there real servers' weight. Servers with
              higher weights receive new jobs first  and  get  more  jobs
              than servers with lower weights. Servers with equal weights
              get an equal distribution of new jobs.
              真实的服务器之间按照权重分配工作，权重越高，服务器优先级越高，分配工作
              越多。

              lc - Least-Connection: assigns more jobs  to  real  servers
              with fewer active jobs.
              为实际工作少的服务器分配工作。

              wlc  -  Weighted  Least-Connection:  assigns  more  jobs to
              servers with fewer jobs and relative to the  real  servers'
              weight (Ci/Wi). This is the default.

              lblc  -  Locality-Based Least-Connection: assigns jobs des‐
              tined for the same IP address to the  same  server  if  the
              server  is  not  overloaded and available; otherwise assign
              jobs to servers with fewer jobs, and keep it for future as‐
              signment.

              lblcr  -  Locality-Based Least-Connection with Replication:
              assigns jobs destined for the same IP address to the least-
              connection  node  in  the server set for the IP address. If
              all the node in the server set are over loaded, it picks up
              a  node  with  fewer jobs in the cluster and adds it in the
              sever set for the target. If the server set  has  not  been
              modified  for  the  specified time, the most loaded node is
              removed from the server set, in order to avoid high  degree
              of replication.

              dh  -  Destination Hashing: assigns jobs to servers through
              looking up a statically assigned hash table by their desti‐
              nation IP addresses.

              sh  - Source Hashing: assigns jobs to servers through look‐
              ing up a statically assigned hash table by their source  IP
              addresses.   This  scheduler  has  two  flags: sh-fallback,
              which enables fallback to a different  server  if  the  se‐
              lected  server was unavailable, and sh-port, which adds the
              source port number to the hash computation.

              sed - Shortest Expected Delay: assigns an incoming  job  to
              the  server  with the shortest expected delay. The expected
              delay that the job will experience is (Ci  +  1)  /  Ui  if
              sent  to  the ith server, in which Ci is the number of jobs
              on the the ith server and Ui  is  the  fixed  service  rate
              (weight) of the ith server.

              nq - Never Queue: assigns an incoming job to an idle server
              if there is, instead of waiting for a fast one; if all  the
              servers  are  busy,  it  adopts the Shortest Expected Delay
              policy to assign the job.

              fo - Weighted Failover: assigns  an  incoming  job  to  the
              server with the highest weight that is currently available.

              ovf  -  Weighted  Overflow:  assigns an incoming job to the
              server with the highest weight that is currently  available
              and  overflows  to  the next when active connections exceed
              the node's weight. Note that this scheduler  might  not  be
              suitable for UDP because it only uses active connections.

              mh  -  Maglev  Hashing:  assigns  incoming  jobs  based  on
              Google's Maglev  hashing  algorithm,  providing  an  almost
              equal  share of jobs to each real server and provides mini‐
              mal disruption. When the set of  real  servers  changes,  a
              connection  will  likely be sent to the same real server as
              it was before.  This scheduler has two flags:  mh-fallback,
              which  enables  fallback  to  a different server if the se‐
              lected server was unavailable, and mh-port, which adds  the
              source port number to the hash computation.

       -p, --persistent [timeout]
              Specify  that  a virtual service is persistent. If this op‐
              tion is specified, multiple  requests  from  a  client  are
              redirected  to  the same real server selected for the first
              request.  Optionally, the timeout  of  persistent  sessions
              may be specified given in seconds, otherwise the default of
              300 seconds will be used. This option may be used  in  con‐
              junction  with protocols such as SSL or FTP where it is im‐
              portant that clients consistently  connect  with  the  same
              real server.
              指定虚拟服务的持续时间。

              Note:  If  a  virtual  service is to handle FTP connections
              then persistence must be set for the virtual service if Di‐
              rect Routing or Tunnelling is used as the forwarding mecha‐
              nism. If Masquerading is used in conjunction  with  an  FTP
              service   than   persistence  is  not  necessary,  but  the
              ip_vs_ftp kernel module must be used.  This module  may  be
              manually inserted into the kernel using insmod(8).

       -M, --netmask netmask
              Specify  the granularity with which clients are grouped for
              persistent virtual services.  The source address of the re‐
              quest  is  masked  with  this netmask to direct all clients
              from a network to the same  real  server.  The  default  is
              255.255.255.255,  that  is,  the persistence granularity is
              per client host. Less specific netmasks may be used to  re‐
              solve  problems  with  non-persistent cache clusters on the
              client side.  IPv6 netmasks should be specified as a prefix
              length  between  1  and  128.  The default prefix length is
              128.

       --pe persistence-engine
              Specify an alternative persistence engine to be used.  Cur‐
              rently the only alternative persistence engine available is
              sip.

       -b, --sched-flags sched-flags
              Set scheduler flags for this virtual  server.   sched-flags
              is  a comma-separated list of flags.  See the scheduler de‐
              scriptions for valid scheduler flags.
              设置虚拟服务器的调度器标志位。

       -r, --real-server server-address
              Real server that an associated request for service  may  be
              assigned  to.   The server-address is the host address of a
              real server, and may plus port. Host can be either a  plain
              IP  address or a hostname.  Port can be either a plain port
              number or the service name of port.  In  the  case  of  the
              masquerading  method,  the  host  address is usually an RFC
              1918 private IP address, and the port can be different from
              that  of the associated service. With the tunneling and di‐
              rect routing methods, port must be equal  to  that  of  the
              service  address.  For  normal services, the port specified
              in the service address will be used if port is  not  speci‐
              fied.  For  fwmark  services, port may be omitted, in which
              case  the destination port on the real server will  be  the
              destination  port  of  the request sent to the virtual ser‐
              vice.
              指定真实的服务器地址。

       [packet-forwarding-method]

              -g, --gatewaying  Use gatewaying (direct routing). This  is
              the default.
              直接路由模式

              -i, --ipip  Use ipip encapsulation (tunneling).
              隧道模式

                      --tun-type tun-type
                              tun-type  is  one of ipip|gue|gre.  The de‐
              fault value of tun-type is ipip.

                      --tun-port tun-port
                              tun-port is an integer specifying the  des‐
              tination port.  Only valid for tun-type gue.

                      --tun-nocsum
                              Specify that tunnel checksums are disabled.
              This is the default.  Only valid for tun-type gue and gre.

                      --tun-csum
                              Specify that tunnel checksums are  enabled.
              Only valid for tun-type gue and gre.

                      --tun-remcsum
                              Specify that Remote Checksum Offload is en‐
              abled.  Only valid for tun-type gue.

              -m, --masquerading  Use masquerading (network access trans‐
              lation, or NAT).
              伪装模式(NAT模式)

              Note:  Regardless of the packet-forwarding mechanism speci‐
              fied, real servers for addresses for which there are inter‐
              faces  on  the  local node will be use the local forwarding
              method, then packets for the servers will be passed to  up‐
              per  layer  on  the local node. This cannot be specified by
              ipvsadm, rather it set by the kernel as  real  servers  are
              added or modified.

       -w, --weight weight
              Weight  is  an integer specifying the capacity  of a server
              relative to the others in the pool.  The  valid  values  of
              weight  are 0 through to 2147483647. The default is 1. Qui‐
              escent servers are specified with a weight of zero. A  qui‐
              escent  server will receive no new jobs but still serve the
              existing jobs, for all  scheduling  algorithms  distributed
              with  the  Linux Virtual Server. Setting a quiescent server
              may be useful if the server is overloaded or  needs  to  be
              taken out of service for maintenance.
              设置服务器权重

       -x, --u-threshold uthreshold
              uthreshold  is  an  integer specifying the upper connection
              threshold of a server. The valid values of uthreshold are 0
              through  to  65535. The default is 0, which means the upper
              connection threshold is not set. If uthreshold is set  with
              other values, no new connections will be sent to the server
              when the number of its connections exceeds its  upper  con‐
              nection threshold.
              最大链接阈值设置

       -y, --l-threshold lthreshold
              lthreshold  is  an  integer specifying the lower connection
              threshold of a server. The valid values of lthreshold are 0
              through  to  65535. The default is 0, which means the lower
              connection threshold is not set. If lthreshold is set  with
              other  values, the server will receive new connections when
              the number of its connections drops below its lower connec‐
              tion  threshold. If lthreshold is not set but uthreshold is
              set, the server will receive new connections when the  num‐
              ber of its connections drops below three forth of its upper
              connection threshold.
              最低阈值设置

       -c, --connection
              Connection output. The list command with this  option  will
              list current IPVS connections.
              输出链接信息

       --timeout
              Timeout output. The list command with this option will dis‐
              play the  timeout values (in seconds) for TCP sessions, TCP
              sessions after receiving a FIN packet, and UDP packets.
              输出超时信息

       --daemon
              Daemon  information  output. The list command with this op‐
              tion will display the daemon status and its  multicast  in‐
              terface.
              输出守护进程信息

       --stats
              Output  of  statistics  information.  The list command with
              this option will display the statistics information of ser‐
              vices and their servers.
              输出统计信息

       --rate Output  of rate information. The list command with this op‐
              tion will display the rate  information  (such  as  connec‐
              tions/second,  bytes/second and packets/second) of services
              and their servers.
              输出速率信息

       --thresholds
              Output of thresholds information.  The  list  command  with
              this option will display the upper/lower connection thresh‐
              old information of each server in service listing.
              输出阈值信息

       --persistent-conn
              Output of persistent connection information. The list  com‐
              mand  with  this option will display the persistent connec‐
              tion counter information of each server in service listing.
              The  persistent  connection  is  used to forward the actual
              connections  from  the  same  client/network  to  the  same
              server.
              输出维持链接信息

              The  list command with the -c, --connection option and this
              option will include persistence  engine  data,  if  any  is
              present, when listing connections.

       --tun-info
              Output of tunneling information. The list command with this
              option will display the tunneling information  of  services
              and their servers.
              输出隧道信息

       --sort Sort  the  list  of  virtual services and real servers. The
              virtual service entries are sorted in  ascending  order  by
              <protocol,  address,  port>.  The  real  server entries are
              sorted in ascending order by <address, port>. (default)

       --nosort
              Do not sort the list of virtual services and real servers.

       -n, --numeric
              Numeric output.  IP addresses  and  port  numbers  will  be
              printed  in numeric format rather than as as host names and
              services respectively, which is the  default.
              以数字形式输出IP地址信息

       --exact
              Expand numbers.  Display the exact value of the packet  and
              byte  counters,  instead  of only the rounded number in K's
              (multiples of 1000) M's (multiples of 1000K) or G's (multi‐
              ples   of  1000M).  This option is only relevant for the -L
              command.
              显示确切的数字信息

       -6, --ipv6
              Use with -f to signify fwmark rule uses IPv6 addresses.

       -o, --ops
              One-packet scheduling.  Used in conjunction with a UDP vir‐
              tual  service or a fwmark virtual service that handles only
              UDP packets.  All connections are created  such  that  they
              only schedule one packet.

   PARAMETERS FOR SYNCHRONIZATION DAEMON
       The  --start-daemon requires zero or more of the following parame‐
       ters.
       --start-daemon 可以使用下边的参数

       --syncid syncid
              Specify the syncid that the sync master daemon fills in the
              SyncID header while sending multicast messages, or the sync
              backup daemon uses to filter  out  multicast  messages  not
              matched  with  the SyncID value. The valid values of syncid
              are 0 through to 255. The default is 0, which means no fil‐
              tering at all.

       --sync-maxlen length
              Specify  the  desired  length of sync messages (UDP payload
              size).  It is expected that backup server  will  use  value
              not  less  than the used value in master server.  The valid
              values of length are in the 1 .. (65535 - 20 - 8) range but
              the  kernel  ensures a space for at least one sync message.
              If value is lower than MTU the sync messages will be  frag‐
              mented  by IP layer.  The default value is derived from the
              MTU value when daemon is started but master daemon will not
              default to value above 1500 for compatibility reasons.

       --mcast-interface interface
              Specify the multicast interface that the sync master daemon
              sends outgoing multicasts through, or the sync backup  dae‐
              mon listens to for multicasts.

       --mcast-group address
              Specify  IPv4  or  IPv6 multicast address for the sync mes‐
              sages.  The default value is 224.0.0.81.

       --mcast-port port
              Specify the UDP port for sync messages.  The default  value
              is 8848.

       --mcast-ttl ttl
              Specify  the  TTL  value for sync messages (1 .. 255).  The
              default value is 1.

EXAMPLE 1 - Simple Virtual Service(简单的虚拟服务)
       The following commands configure a Linux  Director  to  distribute
       incoming  requests  addressed to port 80 on 207.175.44.110 equally
       to port 80 on five real servers. The  forwarding  method  used  in
       this  example is NAT, with each of the real servers being masquer‐
       aded by the Linux Director.

       # 添加虚拟服务
       ipvsadm -A -t 207.175.44.110:80 -s rr
       # 虚拟服务添加实际的服务器，转发模式为地址伪装(NAT)
       ipvsadm -a -t 207.175.44.110:80 -r 192.168.10.1:80 -m
       ipvsadm -a -t 207.175.44.110:80 -r 192.168.10.2:80 -m
       ipvsadm -a -t 207.175.44.110:80 -r 192.168.10.3:80 -m
       ipvsadm -a -t 207.175.44.110:80 -r 192.168.10.4:80 -m
       ipvsadm -a -t 207.175.44.110:80 -r 192.168.10.5:80 -m

       Alternatively, this could be achieved in a single ipvsadm command.

       echo "
       -A -t 207.175.44.110:80 -s rr
       -a -t 207.175.44.110:80 -r 192.168.10.1:80 -m
       -a -t 207.175.44.110:80 -r 192.168.10.2:80 -m
       -a -t 207.175.44.110:80 -r 192.168.10.3:80 -m
       -a -t 207.175.44.110:80 -r 192.168.10.4:80 -m
       -a -t 207.175.44.110:80 -r 192.168.10.5:80 -m
       " | ipvsadm -R

       As masquerading is used as the forwarding mechanism in this  exam‐
       ple,  the  default  route  of  the real servers must be set to the
       linux director, which will need to be configured  to  forward  and
       masquerade  packets. This can be achieved using the following com‐
       mands:
       因为配置了地址伪装，所以真实服务器的默认路由必须要设置为分发器地址，分发器需要配
       置NAT和转发。

       echo "1" > /proc/sys/net/ipv4/ip_forward

EXAMPLE 2 - Firewall-Mark Virtual Service
       The following commands configure a Linux  Director  to  distribute
       incoming  requests  addressed  to  any  port  on 207.175.44.110 or
       207.175.44.111 equally to the  corresponding  port  on  five  real
       servers.  As  per the previous example, the forwarding method used
       in this example is NAT, with each of the real servers  being  mas‐
       queraded by the Linux Director.

       ipvsadm -A -f 1  -s rr
       ipvsadm -a -f 1 -r 192.168.10.1:0 -m
       ipvsadm -a -f 1 -r 192.168.10.2:0 -m
       ipvsadm -a -f 1 -r 192.168.10.3:0 -m
       ipvsadm -a -f 1 -r 192.168.10.4:0 -m
       ipvsadm -a -f 1 -r 192.168.10.5:0 -m

       As  masquerading is used as the forwarding mechanism in this exam‐
       ple, the default route of the real servers  must  be  set  to  the
       linux  director,  which  will need to be configured to forward and
       masquerade packets. The real server should also be  configured  to
       mark  incoming packets addressed to any port on 207.175.44.110 and
       207.175.44.111 with firewall-mark 1. If FTP traffic is to be  han‐
       dled  by  this  virtual  service, then the ip_vs_ftp kernel module
       needs to be inserted into the kernel.   These  operations  can  be
       achieved using the following commands:

       echo "1" > /proc/sys/net/ipv4/ip_forward
       modprobe ip_tables
       iptables  -A PREROUTING -t mangle -d 207.175.44.110/31 -j MARK --set-mark 1
       modprobe ip_vs_ftp

EXAMPLE 3 - Virtual Service with GUE Tunneling
       The  following  commands  configure a Linux Director to distribute
       incoming requests addressed to port 80 on  207.175.44.110  equally
       to  port  80  on  five real servers. The forwarding method used in
       this example is tunneling with gue encapsulation.

       ipvsadm -A -t 207.175.44.110:80 -s rr
       ipvsadm -a -t 207.175.44.110:80 -r 192.168.10.1:80 -i --tun-type gue --tun-port 6080 --tun-nocsum
       ipvsadm -a -t 207.175.44.110:80 -r 192.168.10.2:80 -i --tun-type gue --tun-port 6080 --tun-csum
       ipvsadm -a -t 207.175.44.110:80 -r 192.168.10.3:80 -i --tun-type gue --tun-port 6080 --tun-remcsum
       ipvsadm -a -t 207.175.44.110:80 -r 192.168.10.4:80 -i --tun-type gue --tun-port 6078
       ipvsadm -a -t 207.175.44.110:80 -r 192.168.10.5:80 -i --tun-type gue --tun-port 6079

       Alternatively, this could be achieved in a single ipvsadm command.

       echo "
       -A -t 207.175.44.110:80 -s rr
       -a -t 207.175.44.110:80 -r 192.168.10.1:80 -i --tun-type gue --tun-port 6080 --tun-nocsum
       -a -t 207.175.44.110:80 -r 192.168.10.2:80 -i --tun-type gue --tun-port 6080 --tun-csum
       -a -t 207.175.44.110:80 -r 192.168.10.3:80 -i --tun-type gue --tun-port 6080 --tun-remcsum
       -a -t 207.175.44.110:80 -r 192.168.10.4:80 -i --tun-type gue --tun-port 6078
       -a -t 207.175.44.110:80 -r 192.168.10.5:80 -i --tun-type gue --tun-port 6079
       " | ipvsadm -R

EXAMPLE 4 - Virtual Service with GRE Tunneling
       The following commands configure a Linux Director to use  GRE  en‐
       capsulation.

       ipvsadm -A -t 10.0.0.1:80 -s rr
       ipvsadm -a -t 10.0.0.1:80 -r 192.168.11.1:80 -i --tun-type gre --tun-csum

IPv6
       IPv6 addresses should be surrounded by square brackets ([ and ]).

       ipvsadm -A -t [2001:db8::80]:80 -s rr
       ipvsadm -a -t [2001:db8::80]:80 -r [2001:db8::a0a0]:80 -m

       fwmark IPv6 services require the -6 option.

NOTES
       The  Linux  Virtual  Server  implements  three  defense strategies
       against some types of denial of service (DoS) attacks.  The  Linux
       Director creates an entry for each connection in order to keep its
       state, and each entry occupies 128 bytes effective  memory.  LVS's
       vulnerability  to  a  DoS attack lies in the potential to increase
       the number entries as much as possible until  the  linux  director
       runs  out  of memory. The three defense strategies against the at‐
       tack are: Randomly drop some entries in  the  table.  Drop  1/rate
       packets  before  forwarding them. And use secure tcp state transi‐
       tion table and short timeouts. The strategies  are  controlled  by
       sysctl  variables  and corresponding entries in the /proc filesys‐
       tem:

       /proc/sys/net/ipv4/vs/drop_entry /proc/sys/net/ipv4/vs/drop_packet
       /proc/sys/net/ipv4/vs/secure_tcp

       Valid  values  for  each  variable are 0 through to 3. The default
       value is 0, which disables the respective defense strategy. 1  and
       2  are automatic modes - when there is no enough available memory,
       the respective strategy will be enabled and the variable is  auto‐
       matically  set  to  2,  otherwise the strategy is disabled and the
       variable is set to 1. A value of 3  denotes  that  the  respective
       strategy  is  always  enabled.  The available memory threshold and
       secure TCP timeouts can be tuned using the  sysctl  variables  and
       corresponding entries in the /proc filesystem:

       /proc/sys/net/ipv4/vs/amemthresh /proc/sys/net/ipv4/vs/timeout_*

FILES
       /proc/net/ip_vs
       /proc/net/ip_vs_app
       /proc/net/ip_vs_conn
       /proc/net/ip_vs_stats
       /proc/sys/net/ipv4/vs/am_droprate
       /proc/sys/net/ipv4/vs/amemthresh
       /proc/sys/net/ipv4/vs/drop_entry
       /proc/sys/net/ipv4/vs/drop_packet
       /proc/sys/net/ipv4/vs/secure_tcp
       /proc/sys/net/ipv4/vs/timeout_close
       /proc/sys/net/ipv4/vs/timeout_closewait
       /proc/sys/net/ipv4/vs/timeout_established
       /proc/sys/net/ipv4/vs/timeout_finwait
       /proc/sys/net/ipv4/vs/timeout_icmp
       /proc/sys/net/ipv4/vs/timeout_lastack
       /proc/sys/net/ipv4/vs/timeout_listen
       /proc/sys/net/ipv4/vs/timeout_synack
       /proc/sys/net/ipv4/vs/timeout_synrecv
       /proc/sys/net/ipv4/vs/timeout_synsent
       /proc/sys/net/ipv4/vs/timeout_timewait
       /proc/sys/net/ipv4/vs/timeout_udp

SEE ALSO
       The  LVS  web  site  (http://www.linuxvirtualserver.org/) for more
       documentation about LVS.

       ipvsadm-save(8), ipvsadm-restore(8), iptables(8),
       insmod(8), modprobe(8)

AUTHORS
       ipvsadm - Wensong Zhang <wensong@linuxvirtualserver.org>
              Peter Kese <peter.kese@ijs.si>
       man page - Mike Wangsmo <wanger@redhat.com>
               Wensong Zhang <wensong@linuxvirtualserver.org>
               Horms <horms@verge.net.au>

4th Berkeley Distribution     5th July 2003                    IPVSADM(8)
```
