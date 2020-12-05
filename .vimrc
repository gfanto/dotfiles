set shell=/usr/bin/env\ bash

set nocompatible
filetype plugin indent on
syntax on

if !has('gui_running')
  set t_Co=256
  let &t_ut=''
endif
if (match($TERM, "-256color") != -1) && (match($TERM, "screen-256color") == -1)
  set termguicolors
endif
set noerrorbells

set path+=**
set wildmenu
set wildignore+=*.o,*~,*.pyc,__pycache__

set tabstop=4 softtabstop=4 shiftwidth=4
set autoindent
set expandtab
set smartindent
set smartcase
set showmatch
set hidden

set relativenumber
set nu
set guicursor=
set laststatus=2

set hlsearch
set incsearch
set ignorecase

set nowrap
set noswapfile
set nobackup
set nowritebackup
set undodir=~/.config/nvim/undodir
set undofile

set mouse=a
set clipboard+=unnamedplus

set complete-=i
set completeopt=menuone,noinsert,noselect
set pumheight=12

set scrolloff=8
set sidescroll=0
set cmdheight=1
set updatetime=250
set ttimeout
set ttimeoutlen=100
set shortmess+=c

set foldmethod=syntax
set nofoldenable
set foldlevelstart=999

highlight Pmenu ctermbg=238 gui=bold

let g:mapleader = "\<Space>"

let g:netrw_banner = 0
let g:netrw_browse_split = 2
let g:netrw_liststyle=3

com! CopyRel let @+ = expand('%')

fun! CleverTab(dir)
    if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
       return "\<Tab>"
    else
        if a:dir == 'j'
            return "\<C-N>"
        elseif a:dir == 'k'
            return "\<C-P>"
        endif
    endif
endfun
inoremap <Tab> <C-R>=CleverTab('j')<CR>
inoremap <S-Tab> <C-R>=CleverTab('k')<CR>

"tnoremap <Esc> <C-\><C-n>

nnoremap <C-b> :tabprevious<CR>
nnoremap <C-n> :tabnext<CR>
nnoremap <C-t> :tabnew<CR>
nnoremap <C-q> :tabclose<CR>
nnoremap <C-l> :noh<CR>

nnoremap Y y$
nnoremap S "_S
nnoremap x "_x
nnoremap s "_s
vnoremap X "_d

nnoremap <leader>e :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <leader>o :set paste<CR>

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

autocmd InsertLeave * set nopaste
autocmd BufWritePre * :call TrimWhitespace()
autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'netrw') | q | endif
autocmd StdinReadPre * let s:std_in=1
autocmd FileType python,yaml setl foldmethod=indent
