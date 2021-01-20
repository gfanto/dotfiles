set nocompatible
filetype indent on
syntax on

set noerrorbells
set lazyredraw
set ttyfast

set path+=**
set wildmenu
set wildignore+=*.o,*~,*.pyc,__pycache__

set tabstop=4 softtabstop=4 shiftwidth=4
set autoindent
set expandtab
set smartindent
set smartcase
set showmatch
set nojoinspaces
set hidden

set hlsearch
set incsearch
set ignorecase

set nowrap
set noswapfile

set mouse=a

set complete-=i

set ve=block
set scrolloff=8
set sidescroll=0
set cmdheight=1
set updatetime=250
set notimeout
set ttimeout
set ttimeoutlen=10

set foldmethod=syntax
set foldlevelstart=99

set laststatus=2

let g:netrw_banner = 0
let g:netrw_browse_split = 2
let g:netrw_liststyle=3

autocmd InsertLeave * set nopaste
autocmd FileType python,yaml setl foldmethod=indent
