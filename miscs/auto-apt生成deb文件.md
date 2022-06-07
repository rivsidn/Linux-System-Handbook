手动安装的软件，卸载的时候不是很方便，可以通过`auto-apt` 和 `checkintall` 一起生成deb 文件之后安装，可以方便得卸载。



## 软件安装

### auto-apt 安装

```bash
wget https://mirrors.edge.kernel.org/ubuntu/pool/universe/a/auto-apt/auto-apt_0.3.24_amd64.deb
sudo dpkg -i auto-apt_0.3.24_amd64.deb
sudo apt install -f
```

### checkinstall 安装

```bash
sudo apt-get install checkinstall
```



## 生成deb 文件

```bash
auto-apt run ./configure
make
sudo checkinstall
```



## 注意

* `checkinstall` 过程中需要`root`权限
* `checkinstall` 过程中需要设置`version`



