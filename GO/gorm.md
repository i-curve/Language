# gorm是go的数据库连接模块

#### 学习路径  
掌握数据库的基本用法-学会设计数据库
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
修改表
```go
db.Model(&user).Where().Updata("name",value)
```
执行mysql操作
```
db.Exec("sql语句")
```

#### 5.事务操作

```go
tx := db.Begin()
//执行数据库操作

tx.Create()

//发生错误时,回滚
tx.Rollback()

//没有错误时，提交
tx.Commit()
```
#### 6.数据库构建规则

函数依赖：对于X的每一个值，Y都有唯一的值与之对应，称为X-> Y,Y依赖于X

第一范式：每个属性都不能都再次划分  
第二范式：非主属性都完全函数依赖于主属性  
第三范式：属性中不存在传递函数依赖