# gorm是go的数据库连接模块

### 1. 所在包
导入包

```go
import (
    "github.com/jinshu/gorm"
    _ "github.com/jinshu/gorm/dialects/mysql"
)
```
### 2. 数据库基本操作

数据库连接
```go
// mysql
db,err:=gorm.Open("mysql","user:password@(ip:port)/dbname?charset=utf8&parseTime=True)
//sqlite
db,err:=gorm.Open("sqlite3","dbname")
```
表的创建,删除
```go
//判断是否存在
db.HasTable(name)
//自动融合
db.AutoMigrate(name)
//创建
db.CreateTable(name)
//删除
db.DropTable(name)
```
表的修改
```go
db.Model(name).ModifyColumn()
db.Model(name).DropColumn()
```

### 3.表的模型
模型定义
```go
type Name struct{
    gorm.Model
    Name string `gorm:"size:255"`
    Password string `gorm:"default:'curve'"`//设置默认值
}
```

### 4.表层操作
查询
```go
db.First(&user)//获取第一个记录,根据主键排序
db.Last(&user)//获取最后一个记录,根据主键排序
db.Find(&user)//获取所有记录
db.Where("name=?",10).First(user)
```