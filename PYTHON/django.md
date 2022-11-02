# Django

django 是 python 的一个网络框架, 用于快速服务端开发

## I. 安装和初始化项目

- 安装

```bash
pip install django
```

会安装相应的包以及 djanbo-admin 管理程序

- 创建项目

```bash
django-admin startproject 项目名
```

- 目录结构

```
├── django01
│   ├── __init__.py
│   ├── asgi.py      // [不用动]
│   ├── settings.py  // [设置, 经常修改]
│   ├── urls.py      // [url和处理函数, 经常修改]
│   └── wsgi.py      // [不用动]
└── manage.py      // 用于管理app
```

## II. 常用命令

- 添加一个 app

```bash
python manage.py startapp user
```

添加 app 的目录结构

```
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

- 配置项目

1. 注册 app
   在项目根目录下的 setting 文件的 INSTALLED_APPS 后面添加上新注册的 app, user 目录中 apps.py 文件内的类名 (user.apps.UserConfig)
2. 编写视图和函数的对应关系

- 启动项目

命令行启动

```bash
python manage.py runserver 8000(端口)
```

## III. 数据库操作

- 安装 mysqlclient

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

- 创建 model 模型

model.py

```py
from django.db import models
class User(models.Model):
    username = models.CharField(max_length=255)
    password = models.CharField(max_length=255)
    age = models.IntegerField()
```

- 进行表迁移

```bash
python manage.py makemigrations
python manage.py migrate
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
