set shell=/usr/bin/env\ bash

set nocompatible
filetype plugin indent on
syntax on

if !has('gui_running')
  set t_Co=256
endif
if (match($TERM, "-256color") != -1) && (match($TERM, "screen-256color") == -1)
  set termguicolors
endif
set noerrorbells

set lazyredraw

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

set relativenumber
set nu
set guicursor=

set hlsearch
set incsearch
set ignorecase

set nowrap
set noswapfile
set nobackup
set nowritebackup
set undodir=~/.vim/undodir
set undofile

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
set shortmess+=c

set foldmethod=syntax
set nofoldenable
set foldlevelstart=999

set diffopt+=iwhite
set diffopt+=algorithm:patience
set diffopt+=indent-heuristic

set laststatus=2

let g:mapleader = "\<Space>"

let g:netrw_banner = 0
let g:netrw_browse_split = 2
let g:netrw_liststyle=3

com! CopyRel let @+ = expand('%')
com! CopyAbs let @+ = expand('%:p')
function! s:DiffWithOrig()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffOrig call s:DiffWithOrig()

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

fun! RangeSearch(direction)
  call inputsave()
  let g:srchstr = input(a:direction)
  call inputrestore()
  if strlen(g:srchstr) > 0
    let g:srchstr = g:srchstr.
          \ '\%>'.(line("'<")-1).'l'.
          \ '\%<'.(line("'>")+1).'l'
  else
    let g:srchstr = ''
  endif
endfun
vnoremap <silent> / :<C-U>call RangeSearch('/')<CR>:if strlen(g:srchstr) > 0\|exec '/'.g:srchstr\|endif<CR>
vnoremap <silent> ? :<C-U>call RangeSearch('?')<CR>:if strlen(g:srchstr) > 0\|exec '?'.g:srchstr\|endif<CR>

nnoremap <C-b> :tabprevious<CR>
nnoremap <C-n> :tabnext<CR>
nnoremap <C-t> :tabnew<CR>
nnoremap <C-q> :tabclose<CR>
nnoremap <C-l> :noh<CR>

nnoremap <silent> Y y$
nnoremap <silent> S "_S
nnoremap <silent> x "_x
nnoremap <silent> s "_s
vnoremap <silent> X "_d

vnoremap $ $h

nnoremap <leader>e :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <leader>o :set paste<CR>

map <silent> <A-h> <C-w><
map <silent> <A-k> <C-W>-
map <silent> <A-j> <C-W>+
map <silent> <A-l> <C-w>>
map <silent> <A-s> :split<CR>
map <silent> <A-v> :vsplit<CR>
map <silent> <A-n> <C-w><C-w>
map <silent> <A-b> <C-w><S-w>

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
