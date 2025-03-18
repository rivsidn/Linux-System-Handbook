
周报中的某些表格，通过自带的软件打开之后会格式会乱，安装wps处理。

```bash
sudo snap install wps-office  
sudo snap connect wps-office:removable-media
```

启动过程中报异常，需要安装字体到`/usr/share/fonts/wps-office` 下。
