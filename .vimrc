set nocompatible
syntax on

let $SHELL = '/bin/bash'
set shell=/bin/bash

set path=.,**
set wildmenu
set wildignore+=.git,.hg,.svn,.stversions,*.pyc,*.spl,*.o,*.out,*~,%*
set wildignore+=*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store
set wildignore+=**/node_modules/**,**/bower_modules/**,*/.sass-cache/*
set wildignore+=application/vendor/**,**/vendor/ckeditor/**,media/vendor/**
set wildignore+=__pycache__,*.egg-info,.pytest_cache,.mypy_cache/**
set wildcharm=<C-z>

set noerrorbells
set lazyredraw
set ttyfast
set hidden
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=-1
set shiftround
set ignorecase
set noswapfile

set mouse=a

set ve=block
set scrolloff=8
set sidescroll=0

set timeout ttimeout
set ttimeoutlen=10

set foldmethod=manual
set foldlevelstart=99

colorscheme desert
hi Visual ctermbg=237 cterm=none

let g:netrw_banner = 0
let g:netrw_liststyle=3

autocmd InsertLeave * set nopaste

nnoremap <C-l> :noh<CR>
nnoremap K <NOP>

nnoremap <silent> Y y$
nnoremap <silent> S "_S
nnoremap <silent> x "_x
nnoremap <silent> s "_s
vnoremap <silent> X "_d

nnoremap Q <NOP>
nnoremap k gk
nnoremap j gj
xnoremap < <gv
xnoremap > >gv
vnoremap $ $h

nnoremap gs :buffer#<CR>
