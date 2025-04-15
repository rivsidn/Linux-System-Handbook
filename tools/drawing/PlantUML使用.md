### 安装

```bash
sudo apt install plantuml
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