# gorm 是 go 的数据库连接模块

- [gorm 是 go 的数据库连接模块](#gorm-是-go-的数据库连接模块) - [学习路径](#学习路径)
  - [I. 所在包](#i-所在包)
  - [II. 数据库基本操作](#ii-数据库基本操作)
  - [III.表的模型](#iii表的模型)
  - [IV.表层操作](#iv表层操作)
  - [V.事务操作](#v事务操作)
  - [VI.数据库构建规则](#vi数据库构建规则)
  - [VII. data 层模板](#vii-data-层模板)

[参考官网学习](https://gorm.io/index.html)

#### 学习路径

掌握数据库的基本用法-学会设计数据库

## I. 所在包

导入包

```go
import (
    "github.com/jinshu/gorm"
    _ "github.com/jinshu/gorm/dialects/mysql"
)
```

## II. 数据库基本操作

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

## III.表的模型

模型定义

```go
type Name struct{
    gorm.Model
    Name string `gorm:"size:255"`
    Password string `gorm:"default:'curve'"`//设置默认值
}
```

## IV.表层操作

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

执行 mysql 操作

```
db.Exec("sql语句")
```

## V.事务操作

```go
tx := db.Begin()
//执行数据库操作

tx.Create()

//发生错误时,回滚
tx.Rollback()

//没有错误时，提交
tx.Commit()
```

## VI.数据库构建规则

函数依赖：对于 X 的每一个值，Y 都有唯一的值与之对应，称为 X-> Y,Y 依赖于 X

第一范式：每个属性都不能都再次划分  
第二范式：非主属性都完全函数依赖于主属性  
第三范式：属性中不存在传递函数依赖

## VII. data 层模板

```go
var db *gorm.DB
var M struct{}
var Req struct{
    PageSize int32
    PageNumber int32
}

// ctx 超时取消

// CreateXXX 创建数据
func CreateXXX(ctx context.Context, data *M) error {
    return db.WithContext(ctx).Model(data).Create(data).Error
}
// DeleteXXX 删除数据
func DeleteXXX(ctx context.Context, data *M) error {
    return db.WithContext(ctx).Model(data).Where(data).Delete(data).Error
}
// UpdateXXX 更新数据
func UpdateXXX(ctx context.Context, data *M) error {
    return db.WithContext(ctx).Omit(clause.Associations).Model(data).Save(data).Error
}
// PatchXXX 更新数据
func PatchXXX(ctx context.Context, data *M) error {
    return db.WithContext(ctx).Model(data).Updates(data).Error
}
// GetXXX 获取详情
func GetXXX(ctx context.Context, data *M) (res *M,err error)  {
    return db.WithContext(ctx).Model(data).Where(data).
        Preload(clause.Associations).
        First(&res).Error
}
// ListXXX 获取列表
func ListXXX(ctx context.Context, req *Req) (res []*M, count int64, err error) {
    t := db.WithContext(ctx).Model(&M{})
    // 各种条件

    err = t.Count(&count).
    Preload(clause.Associations).
    Limit(int(req.PageSize)).Offset(int(req.PageNumber)).
    Find(&res).Error
    return
}

// 其他
```
