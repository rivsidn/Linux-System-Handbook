

```bash
sudo service network-manager stop
sudo rm /var/lib/NetworkManager/NetworkManager.state
sudo service network-manager start
sudo gedit /etc/NetworkManager/NetworkManager.conf
把false改成true
sudo service network-manager restart
```





## 参考资料

* [Ubuntu18.04中settings里Network界面中的Wired选项不见了](https://blog.csdn.net/kk_so_good/article/details/106025279)