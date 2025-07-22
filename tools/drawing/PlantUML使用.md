## PlantUML使用

### 安装

```bash
sudo apt install plantuml
```

这样安装的可能不是最新的，导致有些符号不支持.

可以直接通过官网下载最新版本.

```bash
wget http://sourceforge.net/projects/plantuml/files/plantuml.jar/download -O plantuml.jar

# 使用方式：java -jar plantuml.jar your_file.puml
# 可以将这个命令封装成一个别名，就可以通过plantuml来调用了
```


### 使用

源码文件`demo.puml`

```plantuml
@startuml
Bob -> Alice : hello
@enduml
```



图片生成命令。

```bash
# 生成png文件
plantuml -tpng demo.puml
# 生成svg文件
plantuml -tsvg demo.puml
# 生成txt文件
plantuml -ttxt demo.puml
```



执行后，会在本地生成相应尾缀的图片文件。

### 数据结构图关系图

```plantuml
@startuml

left to right direction

struct root {
  int v1
  int v2
  struct leaf* leaf1
  struct leaf* leaf2
}

struct leaf {
  int v
  struct root* root
}

root::leaf1 ..> leaf : "leaf1"
root::leaf2 ..> leaf : "leaf2"
leaf::root  ..> root

@enduml
```

执行图片生成命令之后，可以生成对应的数据结构图.

### 参考资料

* [plantUML官网](https://plantuml.com/)
