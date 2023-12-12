# Docker doc

<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->

<!-- code_chunk_output -->

- [Docker doc](#docker-doc)
  - [I. 基础用法](#i-基础用法)
    - [1. 镜像管理(image)](#1-镜像管理image)
    - [2. 容器管理(container)](#2-容器管理container)
    - [3. 日志管理(logs)](#3-日志管理logs)
    - [4. 网络管理(network)](#4-网络管理network)
    - [5. 管理数据卷(volumn)](#5-管理数据卷volumn)
  - [II. 命令](#ii-命令)
    - [1. 镜像管理:](#1-镜像管理)
    - [2. 容器管理](#2-容器管理)
  - [III. 集群(swarm)](#iii-集群swarm)
    - [1. 集群构建](#1-集群构建)
    - [2. 管理集群节点(node)](#2-管理集群节点node)
    - [3. 查看集群启动的服务(service)](#3-查看集群启动的服务service)
    - [4. 集群服务(stack)](#4-集群服务stack)
  - [IV. Dockerfile 用法](#iv-dockerfile-用法)

<!-- /code_chunk_output -->

docker 的用法

## I. 基础用法

### 1. 镜像管理(image)

```bash
## 查询镜像
docker search ubuntu

## 拉取镜像
docker pull ubuntu

## 查看本地所有镜像
docker image ls
## 删除本地镜像
docker image rm ubuntu
```

### 2. 容器管理(container)

启动容器

```bash
docker container run -itd --name docker-name -p80:80 -v a.txt:/usr/local/a.txt ubuntu /bin/bash
## 参数说明
```

### 3. 日志管理(logs)

查看日志

```bash
docker logs [OPTIONS] [container]
```

相关参数

> -f: 实时显示
> --since,--until: 显示从什么时间到什么时间的日志
> -n: 从最后几行开始显示

### 4. 网络管理(network)

略

### 5. 管理数据卷(volumn)

略

## II. 命令

### 1. 镜像管理:

docker search name:查找镜像  
 docker pull name:tag:下载镜像  
 docker image rm name:tag:删除镜像  
 docker build 参数 .:构建镜像  
 -t name:tag :定义生成的镜像名字
. :查找 dockfile 文件位置

docker push name:tag:上传到服务器

### 2. 容器管理

docker container ps:显示正在运行容器

- -a:显示所有容器
- -a -q:只显示容器 id

docker container rm name:删除容器
docker container run 参数 image:tag

- -i:交互式
- -t:分配一个终端
- -d:后台运行
- -p:端口映射  
  docker container exec -it containerID /bin/bash  
  docker container stop/restart containerID

## III. 集群(swarm)

docker swarm 集群分为管理节点(manager), 工作节点(node)

node 节点用来运行 docker 服务, manager 节点既可以运行 docker 服务,也能用来管理当前 docker 集群

### 1. 集群构建

```bash
# 本机初始化一个docker集群
docker swarm init

## 查看其他docker节点键入本机集群所需要的命令
docker swarm join-token [worker|manager]

## 根据上面生成的命令, 本机加入docker集群中
docker swarm join ...

## 从当前集群中离开(manager)
docker swarm leave [-f]
```

### 2. 管理集群节点(node)

需要再 manager 权限

```bash
## 查看当前集群节点
docker node ls

## 修改node节点权限 (工作节点, 管理节点)
docker node [demote|promote] (node)

## 查看当前 node 节点运行的服务
docker node ps

## 查看当前集群中node节点的详细信息
docker node inspect (node)

## 从当前集群中删除node节点
docker node rm (node)
```

### 3. 查看集群启动的服务(service)

需要 manager 权限

```bash
## 查看所有服务
docker service ls

## 根据进行镜像创建服务
## 参数大多同 docker run
## --with-regiter-auth: 参数在进行私有仓库拉取时用manager节点的认证信息
docker service create [OPTIONS] IMAGE [COMMAND] [ARG...]

## 查看 service 的详细信息
docker service inspect [service]

## 伸缩服务的镜像个数
docker service scale [service]=[number]
## 更新镜像
docker service update
## 回滚镜像
docker service rollback
```

### 4. 集群服务(stack)

序言 manager 权限

```bash
## 根据compose.yaml文件进行部署
## 支持 --with-registry-auth参数
docker stack deploy -c (compose.yaml)

## 展示stack服务的信息
docker stack services (stack)

## 略
docker stack ls
docker stack rm
docker stack ps
```

其他:
config: 用来管理配置文件
secret: 用来管理秘钥

## IV. Dockerfile 用法

dockerfile 是构建镜像的文件,一般以.yml 文件结尾  
镜像描述文件,一个组装图纸

```Dockerfile
# 符号是dockerfile中的注释

# -镜像来源 ubuntu:latest
FROM ubuntu
# 定义作者是谁
MAINTAINER i-curve
# 拷贝文件并解压

# 定义环境变量
ENV HOME /usr/loca
&emsp;--ENV PATH=$PATH:/a
# 工作路径
WORKDIR /usr/local

ADD a.zip /usr/local
# 拷贝
COPY  a.txt /usr/local/a.txt

# 运行shell命令
RUN  apt update

# 对外保留的端口
EXPOSE 80

# 启动容器时,启动命令  会被命令行启动参数覆盖
CMD ["/bin/bash"]
# 启动容器时,执行命令   命令行参数会拼接到后面
ENTRYPOINT ["/bin/bash"]
```
