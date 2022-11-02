# spring-boot

spring 官网: [spring.io](spring.io)

## I. 初始化项目

- 通过 idea 创建

创建时选择 maven 项目

![spring项目初始化-idea](../img/start-spring-idea.png)

在 archetype 选择添加修改项目信息

在高级设置里面设置项目信息

- 通过 spring 官网创建项目

[https://start.spring.io/](https://start.spring.io/)

![spring项目初始化](../image/../img/start-spring-io.png)

## II. 初始化依赖

pom.xml 添加 spring-boot 的依赖

```xml
<parent>
<!-- spring-的根依赖项, 里面会自动匹配项目所依赖各个包关联 -->
    <artifactId>spring-boot-starter-parent</artifactId>
    <groupId>org.springframework.boot</groupId>
    <version>2.7.3</version>
</parent>
<dependencies>
<!-- spring boot web项目 -->
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-web</artifactId>
    </dependency>

    <!-- myslq驱动和mybatis orm模型 -->
    <dependency>
        <groupId>mysql</groupId>
        <artifactId>mysql-connector-java</artifactId>
    </dependency>
    <dependency>
        <groupId>com.enbatis</groupId>
        <artifactId>mybatis-plugs-spring-boot-starter</artifactId>
        <version>1.2.1</version>
    </dependency>
</dependencies>
```

application.properties 文件

这里可以使用 idea 的付费插件无限免费试用进行自动补全

```properties
server.port=8000
spring.datasource.username=root
spring.datasource.password=123456
spring.datasource.url=jdbc:mysql://localhost/express?useSSL=false
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
```

## III. 配置项目

1. 配置项目启动程序

```java
// DemoApplication.java

@SpringBootApplication
// @MapperScan("") 可以配置 mapper 包路径
public class DemoApplication {
    public static void main(String []args) {
        SpringApplication.run(DemoApplication.class, args);
    }
}
```

2. 配置实体和 mapper

```java
// entity/User.java

public class User {
    private int id;
    private String username;
    private String password;
    private int age;
    // 添加 get,set, toString 方法
}
```

```java
// entity/UserMapper.java

// 这里的@Mapper 和 DemoApplication里面的MapperScan选一即可
@Mapper
public interace UserMapper BaseMapper<User> {
    @Select("select * from user;")
    List<User> find();
}
```

3. 配置 Controller 控制器

```java
// controller/UserController.java

// @RestController 用于rest风格的请求(前后端分离)
//

@RestController
public class UserController {
    @AutoWired
    private UserMapper userMapper;

    @GetRequest("/users")
    public List<User> find() {
        List<User> users = userMapper.find();
        System.out.println(users);
        return users;
    }
}
```

想在项目已经可以启动了, 通过 idea 启动即可

```bash
curl -X POST "http://localhost:8000/users"
```

## IV. 配置拦截器中间件

配置登录拦截器文件

```java
// interceptor/LoginInterceptor.java

public class LoginInterceptor implements HandleInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
//        return HandlerInterceptor.super.preHandle(request, response, handler);
        System.out.println("login interceptor");
        return true;
    }
}
```

把拦截器添加到项目请求中

```java
// config/MVCConfig.java

@Configuration
public class MVCCconfig implements WebMvcConfigure {
    @Override
    public void addInterceptor(InterceptorRegistry registry) {
        registry.addInterceptor(new LoginInterceptor());
    }
}
```

## V. 项目打包发布

配置 pom.xml

```xml
<!-- 添加build模块 -->
<build>
    <finalName>mvc01</finalName>
    <plugins>
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-jar-plugin</artifactId>
            <version>3.1.0</version>
            <configuration>
                <archive>
                    <manifest>
                        <mainClass>com.curve.mvc01.MVCApplication</mainClass>
                    </manifest>
                </archive>
            </configuration>
        </plugin>
        <plugin>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-maven-plugin</artifactId>
        </plugin>
    </plugins>
</build>
```
