"这是注释

"设置行号
"set number
set termencoding=utf-8

"set hlsearch
"set incsearch

set ts=4
set smartindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set autoindent
"定义映射
let mapleader=","
inoremap <leader>w <Esc>:w<cr>
noremap <leader>w :w<cr>
inoremap jj <Esc>
vnoremap jj <Esc>
inoremap kk <Esc>:w<cr>a

"这是安装插件 vim-plug
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
"Plug 'kannokanno/previm'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
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
Plug 'xavierd/clang_complete'
call plug#end()


"Set the Map in Plug

nmap ss <Plug>(easymotion-s2)
nnoremap <leader>g :NERDTreeToggle<cr>
nnoremap <leader>v :NERDTreeFind<cr>
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.git$']

" markdowm
let g:vim_markdown_fenced_languages = ['csharp=cs','c++=cpp', 'viml=vim', 'bash=sh', 'ini=dosini','py=py']

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
let g:clang_library_path='/usr/lib/llvm-10/lib/libclang-10.so.1'