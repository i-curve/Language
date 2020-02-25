# 编辑器

## 移动：

```bash
h,j,k,l移动
w,e,b移动
0:移动到行首
\$:移动到行尾
ctrl+u:向上翻页
ctrl+f:向下翻页
```

## 改: 

```bash
i,a,o
x:删除一个字符
d+_:删除一个文本对象
```

## 查:  

```
行中查找:
	f_  +;(查找下一个) +,(查找上一个)
	t_  查找到前面一个字母
	F_
/ ?:向下查,向上查 n/N:结果的转换
```





## 贴上自己vim配置(.vimrc):

```shell
"这是注释

"设置行号
"set number
set termencoding=utf-8

set ts=4
set softtabstop=4
"set shiftwidth=4
"set expandtab

set autoindent

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
"Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
"Plug 'yyzybb/cppenv'
"Plug 'xavierd/clang_complete'
"Plug 'suxpert/vimcaps'
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/nerdtree'
call plug#end()



nmap ss <Plug>(easymotion-s2)
" python-mode
"
"let g:pymode_python = 'python3'
"let g:python_python
"
"
" g++-mode
"
"let g:clang_library_path='/usr/lib/llvm-3.8/lib'
 "" or path directly to the library file
"let g:clang_library_path='/usr/lib64/libclang.so.3.8'
```

