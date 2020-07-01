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
"This is the annotation
"********************Basic setting*******************
"Set the Row Number
"set number
set termencoding=utf-8

"set hlsearch
"set incsearch

set ts=4
set softtabstop=4
"set shiftwidth=4
"set expandtab

set autoindent

"Set the Map
let mapleader=","
inoremap <leader>w <Esc>:w<cr>
inoremap jj <Esc>
"vnoremap jj <Esc>

"This is the plug: vim-plug
"********************The basic pulgin****************
call plug#begin('~/.vim/plugged')
"*****************Basic****************************
Plug 'mhinz/vim-startify'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'altercation/vim-colors-solarized'
Plug 'Yggdroot/indentLine'
"Plug 'w0ng/vim-hybrid'
"Plug 'yyzybb/cppenv'
"Plug 'suxpert/vimcaps'
"****************Highing **********************************
Plug 'easymotion/vim-easymotion'

Plug 'scrooloose/nerdtree'
Plug 'kien/ctrlp.vim'

Plug 'tpope/vim-commentary'
Plug 'lfv89/vim-interestingwords'
Plug 'tpope/vim-surround'

Plug 'majutsushi/tagbar'
" Plug 'godlygeek/tabular'
" Plug 'plasticboy/vim-markdown'
"******************Write code************************
""Formar-> neoformat
"Plug 'sbdchd/neoformat'
"auto complete the code
" if has('nvim')
"   Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" else
"   Plug 'Shougo/deoplete.nvim'
"   Plug 'roxma/nvim-yarp'
"   Plug 'roxma/vim-hug-neovim-rpc'
" endif
"
"GOLAND-> faith-go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
"PYTHON-> python-mode
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
"C++-> cland_complete
"Plug 'xavierd/clang_complete'
call plug#end()


"Set the Map in Plug

nmap ss <Plug>(easymotion-s2)
nnoremap <leader>v :NERDTreeFind<cr>
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.git$']

"deoplete.nvim
" let g:deoplete#enable_at_startup = 1
" set completeopt-=preview
"
let g:interestingWordsRandomiseColors = 1
let g:interestingWordsTermColors = ['154', '121', '211', '137', '214', '222']
let g:interestingWordsGUIColors = ['#8CCBEA', '#A4E57E', '#FFDB72', '#FF7272', '#FFB3FF', '#9999FF']

"tagbar
nnoremap <leader>t :TagbarToggle<CR>
"*******************************Write code**************************
"format->Neoformat
" let g:neoformat_python_autopep8 = {
"             \ 'exe': 'autopep8',
"             \ 'args': ['-s 4', '-E'],
"             \ 'replace': 1,
"             \ 'stdin': 1, 
"             \ 'env': ["DEBUG=1"],
"             \ 'valid_exit_codes': [0, 23],
"             \ 'no_append': 1,
"             \ }
" let g:neoformat_enabled_python = ['autopep8']
"Pythin->  python-mode
let g:pymode_python = 'python3'
let g:pymode_trim_whitespaces = 1
let g:pymode_rope = 1
let g:pymode_rope_goto_definition_bind = "<C-]>"
let g:pymode_rope_organize_imports_bind = '<C-c>ro'
let g:pymode_doc=1
let g:pymode_doc_bind='K'
let g:pymode_lint = 1
let g:pymode_lint_checkers = ['mccabe', 'pylint', 'pyflakes']
let g:pymode_options_max_line_length=120
"let g:pymode_run = 1
"let g:pymode_run_bind = '<leader>r'
"
"C++->clang-complete
"let g:clang_library_path='/usr/lib/llvm-3.8/lib'
```

