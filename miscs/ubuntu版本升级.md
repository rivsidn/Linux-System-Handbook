## 备份

**TODO：本地主机，升级时暂时没备份。**



## 升级

```bash
# 更新本地软件
sudo apt update
sudo apt list --upgradable
sudo apt upgrade

# 卸载用不到的软件
sudo apt --purge autoremove

# 更新
sudo apt install update-manager-core
sudo do-release-upgrade

# 确认
lsb_release -a
```



## 问题

* 启动不起来问题

  启动不起来时，网络正常，ssh可以正常访问，执行如下命令之后正常。

  ```bash
  sudo apt update
  sudo apt --fix-broken install
  ```

* 频繁报内部错误

  ```bash
  sudo apt update
  sudo apt upgrade
  sudo apt autoremove
  ```





## 参考资料

* [Upgrade Ubuntu 18.04 to 20.04 LTS using command line](https://www.cyberciti.biz/faq/upgrade-ubuntu-18-04-to-20-04-lts-using-command-line/)
