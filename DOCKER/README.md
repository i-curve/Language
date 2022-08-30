# Docker doc

- [Docker doc](#docker-doc)
  - [I. 基础用法](#i-基础用法)
  - [II. 集群](#ii-集群)
  - [Dockerfile 用法](#dockerfile-用法)

docker 的面向对象用法

## I. 基础用法

- image: 镜像管理

查询镜像

```bash
docker search ubuntu
```

拉取镜像

```bash
docker pull ubuntu
```

通用镜像操作

```bash
docker image ls # 查看本地所有镜像
docker image rm ubuntu # 删除本地镜像
```

- container: 容器管理

启动容器

```bash
docker container run -itd --name docker-name -p80:80 -v a.txt:/usr/local/a.txt ubuntu /bin/bash
## 参数说明
```

- log: 日志管理

- network: 网络管理

- volumn: 管理数据卷

## II. 集群

- swarm: 构建集群

- node: 管理集群节点

- service: 查看集群启动的服务

- stack: docker-compose 方式启动的集群

## Dockerfile 用法

dockerfile 是构建镜像的文件,一般以.yml 文件结尾  
镜像描述文件,一个组装图纸

```docker
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
