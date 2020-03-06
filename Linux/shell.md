bash中所有变量统统是做字符型。

无浮点型，除非用外部工具



变量：

默认创建本地变量，可以用export 变为环境变量

特殊变量：shell内置的特殊变量。

​	$?: 上一个变量的执行状态信息 0：成功  1-255：失败

运算： 1. let a="3+3"  2. a="3+3"|bc 

文本三剑客：

​	grep：过滤，行。-i 忽略大小写。-o仅显示字符串本身q，v。

​	sed：文本编辑器

​	gawk：格式化文本

正则表达式

​	基本(BRE)：

​	扩展(ERE)：去掉了{}，+，？符号之前的\，是以前认知 中的正则表达式

read [option] a b

option: -s 隐藏  -p “要显示的文字”  -t 倒计时 -n 长度 -r：一行包括特殊符

grep [option]:

-i   -o   -v   -q         -A -B -C

sed [option] command

option:-i 原文件编辑 -e多个命令

​	

command:

​	' s/apple/dog/g'  :s替换，apple匹配，dog替换结果，g全局

​	i，a：添加，d删除，c替换



wc: -l   -w   -c

cut:-d   -f



sort:-n  -t  -k  -f  -r

uniq:-c



