# c# 微服务

<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->

<!-- code_chunk_output -->

- [c# 微服务](#c-微服务)
  - [项目初始化](#项目初始化)
  - [user 微服务开发](#user-微服务开发)
    - [1. 添加 UserController 文件](#1-添加-usercontroller-文件)
    - [2. 在 Models 目录下添加 User 实体类](#2-在-models-目录下添加-user-实体类)
  - [Api 客户端开发](#api-客户端开发)
    - [1. 添加 User 实体类](#1-添加-user-实体类)
    - [2. 添加 UserClient 接口](#2-添加-userclient-接口)
    - [3. 实现 UserClient 接口](#3-实现-userclient-接口)
  - [实现 Gateway 网关](#实现-gateway-网关)
    - [1. 添加 UserController](#1-添加-usercontroller)
    - [2. 添加 UserClient 映射](#2-添加-userclient-映射)

<!-- /code_chunk_output -->

## 项目初始化

在 visual studio 上进行项目创建

1. 创建网关 Gateway

类型 webapi

2. 创建 user 微服务

类型 webapi

3. 创建 Api 客户端

类型 类库

使用 NuGet 包管理器给 Api 客户端添加 Refit 包

4. 给要进行远程调用的服务添加 Api 引用

- 创建完成后大致目录如下所示

```bash
├───Api
│   ├───Clients
│   │   └───impl
│   ├───Models
├───Gateway
│   ├───Controllers
│   ├───Properties
│   └───Services
└───User
    ├───Controllers
    ├───Models
    └───Properties
```

## user 微服务开发

### 1. 添加 UserController 文件

在 UserService/UserController 下添加

```c#
// /UserService/Controller/UserController.cs

namespace UserService.Controllers {
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase {


        List<User> users;
        public UserController() {
            users = new List<User>(){
                new User{Id = 1, Name = "用户1", Age=10,Sex=true  },
                new User{Id = 2, Name = "用户2", Age=11,Sex=false  },
                new User{Id = 3, Name = "用户3", Age=12 ,Sex=false },
            };
        }

        [HttpGet("/users")]
        public List<User> GetUsers() {
            Console.WriteLine("entry userService GetUsers");
            return users;
        }

        [HttpGet("/user/{id}")]
        public User GetUser(int id) {
            Console.WriteLine($"entry userService GetUser: id = {id}");
            if (id < users.Count) return users[id];
            return new User { Id = id, Name = $"用户{id}", Age = 10 };
        }
    }
}
```

### 2. 在 Models 目录下添加 User 实体类

在 UserService/Models 下添加

```c#
// /UserService/Models/User.cs
namespace UserService.Models {
    public class User {
        public int Id { get; set; }
        public string? Name { get; set; }
        public int Age { get; set; }
        public bool Sex { get; set; }
    }
}
```

## Api 客户端开发

### 1. 添加 User 实体类

在 Api/Models 目录下添加

```c#
// Api/Models/User.cs
namespace Api.Models {
    public class User {
        public int Id { get; set; }
        public string? Name { get; set; }
        public int Age { get; set; }
        public bool Sex { get; set; }
    }
}
```

### 2. 添加 UserClient 接口

在 Api/Clients 目录下添加

```c#
// /Api/Clients/IUserClient.cs
namespace Api.Clients {
    public interface IUserClient {
        [Get("/users")]
        Task<List<User>> GetUsers();

        [Get("/user/{id}")]
        Task<User> GetUser(int id);
    }
}
```

### 3. 实现 UserClient 接口

在 Api/Clients/impl 目录下添加

```c#
namespace Api.Clients.impl {

    public class UserClient : IUserClient {
        public IUserClient userClient;
        public UserClient() {
            this.userClient = RestService.For<IUserClient>("http://localhost:5244");
        }

        public Task<User> GetUser(int id) {
            return this.userClient.GetUser(id);
        }

        public Task<List<User>> GetUsers() {
            return this.userClient.GetUsers();
        }
    }
}
```

## 实现 Gateway 网关

### 1. 添加 UserController

在 Gateway/Controller 下添加

```c#
// Gateway/Controller/UserController
namespace gateway.Controllers {
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase {
        private IUserClient _userClient;

        public UserController(IUserClient userClient) {
            _userClient = userClient;
        }

        [HttpGet("/users")]
        public async Task<List<User>> GetUsers() {
            Console.WriteLine($"entry gateway GetUsers");
            return await this._userClient.GetUsers();
        }

        [HttpGet("/user/{id}")]
        public async Task<User> GetUser(int id) {
            Console.WriteLine($"entry gateway GetUsers: id = {id}");
            return await this._userClient.GetUser(id);
        }
    }
}
```

### 2. 添加 UserClient 映射

修改 Gateway/Program.cs 文件

```c#
// ...
// 添加改行文件
builder.Services.AddTransient<IUserClient, UserClient>();


var app = builder.Build();
// ...
```
