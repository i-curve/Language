# 编辑器



## 移动：

```bash
h,j,k,l移动
w,e,b移动
$:移动到行尾
ctrl+u:向上翻页
ctrl+f:向下翻页
```



## 改:

```bash
i,a,o
x:删除一个字符
d+_:删除一个文本对象

r:光标处替换一个字符  R:不断向后替换
s:删除并进入插入模式  S:删除整行并进入插入模式
c+a/t+_:删除并进入插入模式
```



## 查:

```
行中查找:
	f_  +;(查找下一个) +,(查找上一个)
	t_  查找到前面一个字母
	F_
/ ?:向下查,向上查 n/N:结果的转换
```



## 替换

```
:[range]s/{pattern}/{string}/{flags(g,c,n)}
```



## 插件

使用vim-plug插件管理器:[github上网址](https://github.com/junegunn/vim-plug)

插件查找网站 [VimAwesome](https://vimawesome.com/)



```bash
#安装管理器
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

在~/.vimrc文件中添加一些内容

```bash
call plug#begin('~/.vim/plugged')
"安装的插件名
call plug#end()
```

PlugInstall:安装

PlugUpdate\PlugUpgrade::更新

PlugClean:清除不在列表中的插件



## 贴上自己vim配置(.vimrc):

```shell
"这是注释

"设置行号
"set number
set termencoding=utf-8

"set hlsearch
"set incsearch

set ts=4
set softtabstop=4
"set shiftwidth=4
"set expandtab

set autoindent

"定义映射
let mapleader=","
inoremap <leader>w <Esc>:w<cr>
inoremap jj <Esc>
vnoremap jj <Esc>

"这是安装插件 vim-plug
call plug#begin('~/.vim/plugged')
Plug 'mhinz/vim-startify'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'altercation/vim-colors-solarized'
"Plug 'Yggdroot/indentLine'
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
"Plug 'yyzybb/cppenv'
"Plug 'xavierd/clang_complete'
"Plug 'suxpert/vimcaps'
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/nerdtree'
Plug 'kien/ctrlp.vim'
call plug#end()

"插件中的定义的映射
nnoremap <leader>v :NERDTreeFind<cr>
nnoremap <leader>g :NERDTreeToggle<cr>
let g:ctrlp_map = '<c-p>'

nmap ss <Plug>(easymotion-s2)
" python-mode
"
let g:pymode_python = 'python3'
"let g:python_python
"
"
" g++-mode
"
"let g:clang_library_path='/usr/lib/llvm-3.8/lib'
 "" or path directly to the library file
"let g:clang_library_path='/usr/lib64/libclang.so.3.8'
```

