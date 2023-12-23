# Conan(v2)

<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->

<!-- code_chunk_output -->

- [Conan(v2)](#conanv2)
  - [I. 基础](#i-基础)
    - [1. conanfile 文件](#1-conanfile-文件)
    - [2. 本机环境(profile)](#2-本机环境profile)
  - [II. 使用](#ii-使用)
    - [1.项目中使用 conan 安装包](#1项目中使用-conan-安装包)
    - [2. 使用 cmake 进行构建](#2-使用-cmake-进行构建)
    - [3. 进行编译](#3-进行编译)
    - [4. 使用共享库](#4-使用共享库)
  - [III. 制作](#iii-制作)
  - [IV. conan center](#iv-conan-center)

<!-- /code_chunk_output -->

conan 是 c++的一个包管理工具, 开源,免费, 具有私有化部署, 版本依赖的工能

## I. 基础

### 1. conanfile 文件

项目如果要使用 conan, 需要制作 conanfile.txt 文件或 conanfile.py 文件.

conanfile.txt 文件内容:

```txt
[requires]
# 下面是项目用到的依赖以及版本

[generators]
# 下面是将要生成的项目构建工具类型(cmake)
CMakeDeps
CMakeToolChain
```

### 2. 本机环境(profile)

设置本机环境(profile)

```bash
conan detach profile --force
```

profile 文件内容

```txt
[settings]
arch=x86_64
build_type=Release
compiler=gcc
compiler.cppstd=gnu17
compiler.libcxx=libstdc++11
compiler.version=12
os=Linux
```

## II. 使用

### 1.项目中使用 conan 安装包

```txt
[requires]
zlib/1.2.11

[generators]
CMakeDeps
CMakeToolchain
```

使用 cmake 进行安装

```bash
conan install . --output-folder=build --build=missing --settings=build_type=Debuug
```

output-folder 说明最后生成的文件将会在 build 目录下, 否则,将会在 conanfile.txt 目录下  
build=missing 说明如果服务器中的包不存在二进制源的话就下载源码进行编译  
settings 设置 conan 的变量, 默认存储在 profile 文件中, 这里可以指定进行覆盖

删除本机缓存的包

```bash
conan remove fmt
```

### 2. 使用 cmake 进行构建

进入 build 目录下

```bash
cd build
cmake .. -DCMAKE_TOOLCHAIN_FILE=conan_toolchain.cmake -DCMAKE_BUILD_TYPE=Debug
```

在这里通过 CMAKE_TOOLCHAIN_FILE 指定 conan 生成的 cmake 配置工具链, CMAKE_BUILD_TYPE 指定构建的类型是 Debug 还是 Release,
**note**:一定要和 conan install 中的 build_type 匹配

### 3. 进行编译

```bash
cmake --build .
```

### 4. 使用共享库

通过传递 --options=zlib/1.2.11:shared=True 进行指定

## III. 制作

创建 conanfile.py 文件

```bash
conan new basic(cmake_lib)
```

根据项目类型修改 conanfile.py 文件

打包进入本机的 local 环境

```bash
conan create .
```

## IV. conan center

[conan center 地址](https://github.com/conan-io/conan-center-index)

步骤:

1. 克隆项目
2. 根据里面的模板类型创建文件夹
3. 修改 sha256
4. 如果 c++标准 14 以上, 注意修改编译器类型
5. 测试

```bash
conan create all/conanfile.py --version 0.3.0
```
