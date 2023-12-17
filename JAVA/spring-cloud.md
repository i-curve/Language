# spring-cloud

<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->

<!-- code_chunk_output -->

- [spring-cloud](#spring-cloud)
  - [前置知识](#前置知识)
  - [I. 创建父工程](#i-创建父工程)
  - [II. 添加注册中心项目](#ii-添加注册中心项目)

<!-- /code_chunk_output -->

## 前置知识

dependencies 和 dependencyManagement 区别

1. dependencies 中的包子类均会继承
2. dependencyManagement 中的包在子工程中不会自动引入, 当子项目中声明后不指定版本, 会自动使用父工程的版本

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
