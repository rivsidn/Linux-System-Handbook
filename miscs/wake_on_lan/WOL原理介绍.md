公司电脑关机之后，回到家里发现电脑自动开机了，怀疑网络中杂包影响，导致电脑自己开机的。

查看原理，发现报文结构比较特殊，出现这种情况几率非常小，另外，`wol`支持密码功能，如果再出现类似情况后续可以给电脑`wol`添加密码。



## 参考资料

* [网络唤醒（WOL）全解指南：原理篇](https://www.cnblogs.com/zhanggaoxing/p/9657545.html)
* [Wake on Lan password](https://superuser.com/questions/123479/wake-on-lan-password)

