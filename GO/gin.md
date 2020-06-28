# web框架

### 1.构成部分
包
```
"github.com/gin-gonic/gin"
```
内容
```go
router := gin.Default()
/*
GET
POST
PUT
DELETE
不常用
PATCH
HEAD
OPTIONS
*/
```
### 2.GET请求
获取参数

```
//get参数
router.GET("/ping",func(c *gin.Context{
    a:=c.DefaultQuery("name","value")
    b:=c.Query("name")
    c.String(200,"hello,%s%s",a,b)
})
//POST参数
router.POST("ping",func(c *gin.Context){
    a:=c.DefaultForm("name","value")
    b:=c.PostForm("name")
    c.JSON(200,gin.H{
        "data":"hello",
    })
})

```
分组操作
```
v1 := router.group("/user")
{
    v1.JSON()
    v1.String()
}
```