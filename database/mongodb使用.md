# 前期准备

## 安装

```bash
sudo apt-get update
sudo apt-get install mongodb
```

## 启动

```bash
sudo mkdir -p /data/db
sudo mongod
```

## 访问内容

### 链接数据库

```bash
mongo mongodb://127.0.0.1:27017
```

**exit、quit() 退出.**

### 显示所有数据库

```bash
show dbs
```

### 选择数据库

```bash
use <db-name>
```

### 显示集合

```bash
show collections
```

### 查看内容

```bash
# 查看集合中数据数量
db.users.count()

# 查看集合中内容(假设集合名为users)

# 查看所有数据
db.users.find()
# 查看所有数据，更好看
db.users.find().pretty()
# 之查一条
db.users.findOne()
```

### 条件过滤

```bash
# 条件查询
db.users.find({ age: 18 })
# 条件大于某值
db.users.find({ age: { $gt: 18 } })
# 查询特定字段
db.users.find({}, { name: 1, age: 1 })
```

