os模块:

操作系统接口模块封装,直接此函数和操作系统进行交互

1. 文件路径相关内容

   os.getcwd()  : pwd显示路径

   os.chdir('srt')  :切换路径为指定路径

   os.listdir()  : 显示当前路径下所有文件

2. 系统

   os.system('')  : 运行系统命令

   os.environ  :  获取环境变量

   os.name     :获取操作系统,win='nt'  linux='posix'

3. 使用

   os.mkdir('name') :创建目录

   os.rmdir("name"):删除目录

   os.walk('path') :遍历访问,返回路径,目录,文件

   os.join(path1,path2) :目录连接