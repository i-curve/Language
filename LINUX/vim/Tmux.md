分屏工具

基础命令

tmux new -s con:创建一个con分屏

tmux a -t con

tmux kill-session -t con

tmux kill-server

tmus ls

窗口命令:

<T-B> +s/w: 显示窗口,会话

<T-B> +c:新建一个窗口

<T-B> +&:关闭窗口

<T-B> +d:退出session

<T-B> +p/n:窗口切换

<T-B> +,:重命名窗口

窗格命令:

<T-B> +%":窗口分屏

<T-B> +z:最大化最小化

<T-B> +o:切换窗格

<T-B> +q:窗格编号

<T-B> +x:关闭窗格