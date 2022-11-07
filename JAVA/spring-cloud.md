# spring-cloud

## I. 创建父工程

- 创建 spring-boot 项目

略

- 添加 spring-cloud 依赖

pom.xml

```xml
<dependencyManagement>
    <dependencies>
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-dependencies</artifactId>
            <version>2021.0.4</version>
            <type>pom</type>
            <scope>import</scope>
        </dependency>
    </dependencies>
</dependencyManagement>
```

## II. 添加注册中心项目
