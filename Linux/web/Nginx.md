# 特性

比apache出现较晚，轻量级，高并发，负载均衡

# 安装

yum install gcc-c++ 

yum install pcre pcre-devel

yum install zlib zlib-devel

yum install openssl openssl

wget 下载地址

tar zxvf  name

./configure --prefix=/opt/nginx   :安装到opt/nginx目录下

Make

make install 

# 命令

./nginx    :启动

./nginx -s stop ：立刻杀死进程

./nginx -s quit ：待完成任务后结束进程

./nginx -s reload 

开启防火墙端口：

iptables -I INPUT -p tcp --dport 80 -j ACCEPT