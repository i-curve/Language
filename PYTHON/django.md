# Django

django 是 python 的一个 web 框架, 用于快速服务端开发

<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->

<!-- code_chunk_output -->

- [Django](#django)
  - [I. django 使用](#i-django-使用)
    - [django 常用命令](#django-常用命令)
    - [MVC 语法](#mvc-语法)
    - [django 数据库](#django-数据库)
      - [1. 安装 mysqlclient](#1-安装-mysqlclient)
      - [2. 创建 model 模型](#2-创建-model-模型)
  - [II. django admin 使用](#ii-django-admin-使用)
  - [III. djangorestframework 使用](#iii-djangorestframework-使用)

<!-- /code_chunk_output -->

## I. django 使用

- django 的安装和项目创建

```bash
# 安装
pip install django # conda install django
# 项目创建
django-admin startproject demo
```

django 项目的命令行 **startproject** 表明是项目, **startapp** 表明是子项目

- django 目录结构

根 app

```bash
├── django01
│   ├── __init__.py
│   ├── asgi.py      // [不用动]
│   ├── settings.py  // [设置, 经常修改]
│   ├── urls.py      // [url和处理函数, 经常修改]
│   └── wsgi.py      // [不用动]
└── manage.py      // 用于管理app
```

添加 app 的目录结构

```bash
user
├── __init__.py
├── admin.py               // [不用动]
├── apps.py                // [不用动] app启动
├── migrations             // [不用动] 数据库字段变更
│   └── __init__.py
├── models.py              // 数据库操作
├── tests.py               // [单元测试, 不用动 ]
└── views.py               // 经常动 视图函数
```

### django 常用命令

```bash
#添加一个 app
python manage.py startapp user

# 数据库更新
python manage.py makemigrations
python manage.py migrate

# 项目启动
python manage.py runserver 8000(端口)
```

添加完 app 之后, 需要在把 apps.\*Config 内容添加到根 app 的 setting.py 文件的变量 INSTALLED_APPS 中, 并且在 urls.py 中添加相应的 url 路径

### MVC 语法

view.py 文件内容

```python
from django.shortcuts import render, HttpResponse
def Login(request):
    if request.method == 'GET':
        return render(request, "login.html")
    elif request.method == 'POST':
        print('发送了post请求,data: ', request.POST)
        if request.POST.get('user') == 'admin' and request.POST.get('pwd') == 'admin':
            return render(request, "login.html", {"message": "登录成功"})
        else:
            return render(request, 'login.html', {"message": "登录失败"})
    else:
        return render(request, "404.html")
def ShowPage(request):
    uid = 1000
    names = ["小王", "小李", "小黑", "小白"]
    properties = {
        "小王": 20,
        "小李": 40,
        "小白": 70,
    }
    return render(request, "show_page.html", {
        "uid": 1000,
        "names": names,
        "properties": properties
    })

```

说明: render 渲染的模板 html, HttpResponse 返回的是状态响应

render 第二个参数默认会从根 app.setting.py 中 INSTALLED_APP 注册的 app 目录下的 templates 一个个的找, 当修改 app.setting.py 的 TEMPLATES 的 DIRS 为 os.path.join(BASE_DIR,"templates")后会从根目录的 templates 寻找  
render 第三个参数传入模板里面可以使用的变量  
静态资源默认在/static 目录下

login.html
{% raw %}

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=<device-width>, initial-scale=1.0" />
    <title>Document</title>
  </head>
  <body>
    <div>login page.</div>
    <form method="post" action="/login">
      {% csrf_token %}
      <input type="text" name="user" placeholder="用户名" />
      <input type="password" name="pwd" placeholder="密码" />
      <input type="submit" value="提交" />
    </form>
    {{ message }}
  </body>
</html>
```

show_page.html

```html
{% load static %}
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>ShowPage</title>
  </head>
  <body>
    <h1>this is Show Page.</h1>
    <p>this is a static image: <img src="{% static 'img/images.jpg' %}" /></p>
    <p>the uid is: {{ uid }}</p>
    <p>the o in value: {{ names.0 }}</p>
    <p>foreach list:</p>
    <ol>
      {% for item in names %}
      <li>name: {{ item }}</li>
      {% endfor %}
    </ol>
    <p>foreach in dict:</p>
    <ul>
      {% for key in properties.keys %}
      <li>key: {{ key }}</li>
      {% endfor %} {% for key, val in properties.items %}
      <li>the key: {{ key }},the value: {{ val }}</li>
      {% endfor %} {% for val in properties.values %}
      <li>key: {{ val }}</li>
      {% endfor %}
    </ul>
    {% if uid == 100 %}
    <p>this will show if uid == 100</p>
    {% elif uid == 1000 %}
    <p>this will show if uid == 1000</p>
    {% else%}
    <p>this will show if uid is not 100, 1000</p>
    {% endif %}
  </body>
</html>
```

{% endraw %}

### django 数据库

#### 1. 安装 mysqlclient

```bash
pip install mysqlclient
```

setting.py

```py
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'express',
        'USER': 'root',
        'PASSWORD': '123456',
        'HOST': '127.0.0.1',
        'PORT': '3306',
    }
}
```

#### 2. 创建 model 模型

model.py

```py
from django.db import models


class SoftDelete(models.Model):
    deleted_at = models.DateTimeField(verbose_name="删除时间", null=True)

    def get_queryset(self):
        return super().get_queryset().filter(deleted_at__isnull=True)

    def get_delete_queryset(self):
        return super().get_queryset().fileter(deleted_at__isnull=False)


class User(models.Model):
    # id = models.BigAutoField(primary_key=True) 自动添加
    name = models.CharField(verbose_name="用户名", max_length=255)
    password = models.CharField(verbose_name="密码", max_length=255)
    age = models.IntegerField(verbose_name="年龄", default=0)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    deleted_at = models.DateTimeField(verbose_name="删除时间", null=True)
```

- 结果 json 化

```py
from django.forms import model_to_dict
from django.core import serializers

# 单个对象
user = User.objects.get(id=1)
print(model_to_dict(user))
# 列表
users = User.objects.all()
# print(model_to_dict(users))
print(serializers.serialize('json', users))
```

## II. django admin 使用

django 自带一套后台管理界面 django admin, 默认开启种状态.

修改 django admin 的 ui, 推荐 [django-simpleui 文档](https://newpanjing.github.io/simpleui_docs/config.html)

- **django 的 debug 模式**

django 开发情况下默认开启 debug=True, 此时 django 会自动处理分目录和 app 目录下的 static 静态资源,但是当 debug=False 时, 就不会处理, 此时如何依赖一些静态资源就无法加载

解决方法:

1. settings.py 中添加 STATIC_ROOT 目录

```py
STATIC_ROOT=os.path.join(BASE_DIR, "templates/static")
```

2. 执行`python manager.py collectstatic` 命令

此命令会收集项目中使用的静态资源并统一给放到 STATIC_ROOT 目录下

3. 此时如果想访问静态资源可以通过 nginx 方式或者添加 url 路由

添加 url 方式:

```py
# urls.py
from django.urls import re_path
from django.conf import settings
from django.views import static

urlpatterns = [
    ...
    re_path(r"^static/(?P<path>.*)$", static.serve,
            {'document_root': settings.STATIC_ROOT}, name='static'),
]
```

## III. djangorestframework 使用

---

前言
django 自带 View 类, 其中具有 as_view(), 和 dispatch 方法, 原理是根据请求的 method 类型, 转发到对应的类方法上, 需要自己实现, 没实现就会抛出异常

---

正文

1. APIView 继承自 View

- as_view()

通过调用 as_view 方法, 会把请求根据请求方式分发给 get, post, put, delete, patch 方法

```python
class UserView(ApiView):
    def get(self,req):
        return Response("get 方法",status_code = 200)
    def post(self,req):
        return Response("post 方法", status_code=201)

class User2View(ApiView):
    def patch(self, req):
          return Response("patch 方法",status_code = 200)
    def put(self,req):
        return Response("put 方法",status_code = 200)
    def delete(self, req):
        return Response("delete 方法",status_code = 200)
```

APIView 对请求参数进行了封装, 此时的 req 是封装后的请求对象

.\_request: 获取原始的请求头  
.data: 获取请求体, 可以自动解析 json 和 x-www-form-urlencoded  
.query_params: 获取 query 参数  
.headers: 获取请求头

- 序列化

这里序列化中的限定, 是对前端传来的参数进行验证的, 如果是序列化, 需要传给 instance(数据库返回的值), 如果是反序列化, 需要传给 data(前端你返回的值)

Serializer:

```python
from rest_framework import serializers

class UserSerializer(serializers.Serializer):
    username = serializers.CharField( max_length=50)
    # 可以通过 source 指定数据库中对应的字段是什么, 实现前端字段和数据库字段分割

```

Serializer 实现了 save 方法, 具体是如果改序列器有 instance 参数, 那就是调用 create 方法新增, 如果没有那就是 update 方法更新, 这两个方法需要自己写

ModelSerializer:

```python
class User2Serializer(serializers.ModelSerializer):
    # source参数说明数据库中字段名, 此时会覆盖默认的pub_data解析
    data = serializers.CharField(max_length=50, source="pub_data")
    class Meta:
        object = User
        field = "__all__"
        # exclude
    pass
```

serializers.Serializer 需要手动指定相应字段, serializers.ModelSerializer 通过制定模型自动添加相应字段, 此时也可以通过手动声明方式进行覆盖

其中 ModelSerializer 比 Serializer 增加了 Meta 来指明数据模型是什么  
实现了 create 和 update 方法, 此时可以通过 .save() 方法直接在序列化器中保存或者创建数据

2. GenericAPIView

```python
from rest_framework.generics import GenericAPIView
class UserView(GenericAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer
```

相对比 ApiView 来说, GenericAPIView 内部集成了 queryset 和序列化器类, 此时可以写出更加通用的代码
self.get_queryset(): 获取多有的数据集
self.get_object(): 根据参数中的 pk 进行主键查询
self.get_serializer(): 调用序列化器类的对象

<!-- ViewSet -->

3. minins 混合类

restframework 根据上面的 GenericAPIView 添加了 minins 混合类 ListModelMixin, CreateModelMixin, RetrieveModelMixin, UpdateModelMixin, DestroyModelMixin等一系列混合类, 可以根据需求选择使用

4. GenericViewSet

```python
from rest_framework import viewsets
class UserView(views.GenericViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    def list(self,req):
        pass
    def create(self,req):
        pass
    def retrive(self,req):
        pass
    def update(self,req):
        pass
    def partial_update(self,req):
        pass
    def destroy(self,req):
        pass
```

5. urls.py 修改

```python
from rest_framework import routers
router = routers.DefaultRouter(trailing_slash=False)
router.register("article", ArticleView, basename="article")

urlpatterns = []

urlpatterns += router.urls
```

6. ModelViewSet

```python
from rest_framework import viewsets

class UserView(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer
```

urls.py 修改同 GenericViewSet

ModelViewSet 封装最高, 但是灵活性最差
