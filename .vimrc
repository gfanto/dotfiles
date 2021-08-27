unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

let g:mapleader = "\<Space>"
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_keepj = ""
let g:gruvbox_contrast_dark = 'hard'

set path=.,**
set wildmenu
set wildignore+=.git,.hg,.svn,.stversions,*.pyc,*.spl,*.o,*.out,*~,%*
set wildignore+=*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store
set wildignore+=**/node_modules/**,**/bower_modules/**,*/.sass-cache/*
set wildignore+=application/vendor/**,**/vendor/ckeditor/**,media/vendor/**
set wildignore+=__pycache__,*.egg-info,.pytest_cache,.mypy_cache/**
set wildignorecase
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

set ve=block
set scrolloff=8
set sidescroll=0

set timeout ttimeout
set ttimeoutlen=10

set foldmethod=manual
set foldlevelstart=99

set background=dark

colorscheme gruvbox
hi Normal ctermbg=none
hi Visual ctermbg=237 cterm=none

nnoremap <C-l> :noh<CR>
nnoremap K <NOP>

nnoremap [a :previous<CR>
nnoremap ]a :next<CR>
nnoremap [q :cp<CR>
nnoremap ]q :cn<CR>

nnoremap <silent> Y y$
nnoremap <silent> S "_S
nnoremap <silent> x "_x
nnoremap <silent> s "_s
vnoremap <silent> X "_d

nnoremap k gk
nnoremap j gj
xnoremap < <gv
xnoremap > >gv
vnoremap $ $h

nnoremap gs :buffer#<CR>
nnoremap <expr> gy '`[' . strpart(getregtype(), 0, 1) . '`]'

autocmd InsertLeave * set nopaste

let sys_config = split(&rtp, ",")[0].'/sys_init.vim'
if filereadable(sys_config)
  execute 'source '.sys_config
endif
