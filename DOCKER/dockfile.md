# Dockfile学习
dockerfile是构建镜像的文件,一般以.yml文件结尾  
镜像描述文件,一个组装图纸  

## 语法
\# 符号是dockerfile中的注释

FROM    :镜像来源
  FROM ubuntu:latest
MAINTAINER :定义作者是谁 
  MAINTAINER curve
ADD   :拷贝文件并解压
  ADD ./a.zip /
COPY  :拷贝
  COPY ./a.zip /
RUN   :运行shell命令
  RUN unzip /a.zip
ENV   :定义环境变量
  ENV PATH=$PATH:/a
WORKDIR  :工作路径
  WORKDIR /a
EXPOSE  :对外保留的端口
CMD   :启动容器时,启动命令
  CMD ["/bin/bash"]
ENTRYPOINT :启动容器时,执行命令