# Kernel

<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->

<!-- code_chunk_output -->

- [Kernel](#kernel)
  - [I. 前提条件](#i-前提条件)
  - [II. 编译 kernel](#ii-编译-kernel)
  - [III. 编译 busybox](#iii-编译-busybox)
  - [IV. 制作 initramfs](#iv-制作-initramfs)

<!-- /code_chunk_output -->

编译 linux 内核, 使用 busybox 作用系统 util, 并制作 initramfs 文件, 在 qemu 下启动该内核的进程

## I. 前提条件

安装编译依赖

```bash
apt-get install ncurses-dev flex bison libssl-dev libelf-dev
```

## II. 编译 kernel

下载 kernel 源码: [kernel](https://kernel.org/)

编译:

```bash
make menuconfig # 启动图形配置界面
make defconfig # 生成 .config 默认配置文件
make -j 16
```

编译后的镜像在 source/arch/x86_64/boot/bzImage

新建一个目录, 如 run  
把 bzImge 放到其中 run/bzImage

```bash
cp ../linux-xx/arch/x86/boot/bzImage ./bzImage
```

## III. 编译 busybox

下载 busy box: [https://busybox.net/](https://busybox.net/)

编译配置:

```bash
make meunconfig # 在图形界面中找到 Build static binary 选项后按 y 选中
make -j 16
make install # 结果会安装到 ./_include 目录下
```

一定要在图形 setting 中选中 build static binary, 否则 qemu 启动时会报错:

```txt
Failed to execut /init (error -2)
```

## IV. 制作 initramfs

run 目录

把 bzImage 复制进去

把 busybox 复制进 run/initramfs/bin

在 run/initramfs 制作 init 启动脚本

```bash
#!/bin/busybox sh

/bin/busybox echo "Hello busybox linux"

export PS1="(kernel) =>"
/bin/busybox sh
```

给 init 文件执行权限 `chmod u+x init`

制作 Makefile 文件

```Makefile
.PHONY: initramfs
initramfs:
    cd ./initramfs && find . -print0 | cpio -ov --null --format=newc | gzip -9 > ../initramfs.img

run:
    qemu-system-x86_64 \
            -kernel bzImage \
            -initrd initramfs.img \
            -m 1G \
            -nographic \
            -append "earlyprintk=serial,ttyS0 console=ttyS0 loglevel=8"
```

制作 initramfs 并运行

```bash
make initramfs
make
```
