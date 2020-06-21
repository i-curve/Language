# DOCKER-COMPOSE文件学习  

docker-compose.yml文件是批量启动docker的方法,首先会验证镜像是否存在,如果不存在会自动从网上进行下载,之后会根据里面的语法规则对容器进行启动  

## docker-compose语法

格式:
定义版本
定义服务
命令

```docker
version: '3'  #定义版本3  

services:   #定义服务,里面可以有多个服务
  mysql:    #定义mysql服务  
    image: mysql:5.7  需要的镜像名字,如果本地没有的话,户自动从网上进行下载
    container_name:mysql#镜像运行时的容器名称
    restart:always#如果失败的话,会自动重启
    volumns: #磁盘本地卷挂载到容器中
      - ./ /home/
    ports:  #端口挂载
      - 80:80
    depends_on: #容器的依赖,必须前面容器存在,这个才能运行,可以代替links
      - nginx
    environment: #定义环境变量
      TZ: Asia/Shanghai
    build:
     context: ./worker #dockerfile文件的目录
     dockerfile: dockerfile  #dockerfile文件
    command: bash -c "" #运行命令
    deploy: #只在部署时会运行

networks:  #定义网络
  new:
  old:
    

```

docker-compose up/down/stop -d