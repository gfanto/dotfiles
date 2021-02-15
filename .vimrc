set shell=/bin/bash

set nocompatible
filetype indent on
syntax on

set noerrorbells
set lazyredraw
set ttyfast

set path+=**
set wildmenu

set noexpandtab
set tabstop=4
set shiftwidth=4
set softtabstop=-1
set smarttab
set autoindent
set smartindent
set shiftround

set ignorecase
set smartcase
set infercase
set incsearch
set wrapscan
set hlsearch

set noswapfile

set mouse=a

set ve=block
set scrolloff=8
set sidescroll=0

set foldenable
set foldmethod=syntax
set foldlevelstart=99

set laststatus=2

let $SHELL = '/bin/bash'

let g:mapleader = "\<Space>"

let g:netrw_banner = 0
let g:netrw_browse_split = 2
let g:netrw_liststyle=3

autocmd InsertLeave * set nopaste
autocmd FileType python,yaml setl foldmethod=indent

nnoremap <C-l> :noh<CR>
