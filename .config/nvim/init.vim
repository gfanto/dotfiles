" Editor settings {{{
set shell=/bin/bash

set nocompatible
filetype plugin indent on
syntax on

set noerrorbells
set termguicolors

set hidden
set lazyredraw

set jumpoptions=stack
set switchbuf=useopen,vsplit

set mouse=a
set clipboard& clipboard+=unnamedplus

set path=.,**
set wildmenu
set wildignore+=.git,.hg,.svn,.stversions,*.pyc,*.spl,*.o,*.out,*~,%*
set wildignore+=*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store
set wildignore+=**/node_modules/**,**/bower_modules/**,*/.sass-cache/*
set wildignore+=application/vendor/**,**/vendor/ckeditor/**,media/vendor/**
set wildignore+=__pycache__,*.egg-info,.pytest_cache,.mypy_cache/**
set wildcharm=<C-z>

set isfname-==
" }}}

" Editor Layout {{{
set number
set relativenumber
set guicursor=
set signcolumn=no
set scrolloff=8
set sidescroll=0
set shortmess+=c
set noequalalways

set pumblend=7
set winblend=10
" }}}

" Text edit configs {{{
set noexpandtab
set tabstop=4
set shiftwidth=4
set softtabstop=-1
set smarttab
set autoindent
set smartindent
set shiftround

set nowrap
set breakindentopt=shift:4,min:20
set formatoptions+=1
set formatoptions-=o
set formatoptions+=j

set ve=block

set showmatch
set matchpairs+=<:>
set matchtime=1

" set conceallevel=2
" set concealcursor=niv
" }}}

" Search {{{
set ignorecase
set smartcase
set infercase
set incsearch
set wrapscan
set hlsearch

set inccommand=nosplit
" }}}

" Dirs and temp data {{{
set nobackup
set nowritebackup
set undofile noswapfile
set directory=~/.config/nvim/swapdir
set undodir=~/.config/nvim/undodir
set backupdir=~/.config/nvim/backupdir
set viewdir=~/.config/nvim/viewdir
set shada=!,'300,<50,@100,s10,h
" }}}

" Completion {{{
set complete-=i
set completeopt=menuone,noinsert,noselect
set pumheight=12
" }}}

" Times {{{
set timeout ttimeout
set timeoutlen=500
set ttimeoutlen=10
set updatetime=100
" }}}

" Folds {{{
set foldenable
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevelstart=99
" }}}

" Diffs {{{
set diffopt+=iwhite
set diffopt+=algorithm:patience
set diffopt+=indent-heuristic
" }}}

" Globals {{{
let $SHELL = '/bin/bash'
let $FZF_DEFAULT_OPTS = '--reverse'

let g:mapleader = "\<Space>"

if glob('~/.python3') != ''
  let g:python3_host_prog = expand('~/.python3/bin/python')
else
  let g:python3_host_prog = systemlist('which python3')[0]
endif

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_invert_selection = 0
let g:gruvbox_italic = 1
let g:gruvbox_italicize_comments = 1

if executable('rg')
  set grepformat=%f:%l:%m
  let &grepprg = 'rg --vimgrep' . (&smartcase ? ' --smart-case' : '')
  let g:rg_derive_root='true'
endif

let g:floaterm_autoclose = 2

let g:nvim_tree_follow = 1
let g:nvim_tree_auto_close = 1

let g:fzf_lsp_layout = { 'down': '30%' }
let g:fzf_lsp_preview_window = 'right:50%:noborder'
let g:fzf_lsp_colors = 'bg+:-1'

let g:completion_timer_cycle = 80
let g:completion_matching_strategy_list = ['fuzzy']
let g:completion_matching_ignore_case = 1
let g:completion_trigger_on_delete = 1
let g:completion_sorting = "none"
let g:completion_trigger_keyword_length = 3
let g:completion_chain_complete_list = [
    \{'complete_items': ['lsp', 'buffers']}
\]

com! OpenPython FloatermNew --width=0.5 --wintype=vsplit --name=ipython --position=right ipython -i --no-autoindent
com! OpenTerm FloatermNew --width=0.5 --wintype=vsplit --name=term --position=right fish

com! CopyRel let @+ = expand('%')
com! CopyAbs let @+ = expand('%:p')
" }}}

" Plugins {{{
runtime macros/matchit.vim

packadd cfilter

call plug#begin('~/.config/nvim/plugged')

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'steelsojka/completion-buffers'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'tjdevries/lsp_extensions.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/completion-treesitter'

Plug 'sheerun/vim-polyglot'

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-eunuch'
Plug 'michaeljsmith/vim-indent-object'

Plug 'mbbill/undotree'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'voldikss/vim-floaterm'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'
Plug 'gfanto/fzf-lsp.nvim'

Plug 'Yggdroot/indentLine'
Plug 'vim-airline/vim-airline'
Plug 'gruvbox-community/gruvbox'

call plug#end()
" }}}

" Colors {{{
set background=dark
colorscheme gruvbox
hi link FloatermBorder GruvboxFg4
" }}}

" Key bindings {{{
tnoremap <Esc> <C-\><C-n>

nnoremap <C-p> :GFiles<CR>
nnoremap <C-b> :tabprevious<CR>
nnoremap <C-n> :tabnext<CR>
nnoremap <C-t> :tabnew<CR>
nnoremap <C-q> :tabclose<CR>

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

nnoremap <leader>g :Rg<CR>
nnoremap <leader>f :BLines<CR>
nnoremap <Leader>t :FloatermNew env fish<CR>
nnoremap <Leader>q :FloatermToggle<CR>
nnoremap <leader>u :UndotreeToggle<BAR>wincmd p<CR>
nnoremap <leader>e :NvimTreeToggle<CR>

map <silent> <A-s> :split<CR>
map <silent> <A-v> :vsplit<CR>
map <silent> <A-o> <C-w>o
map <silent> <A-n> <C-w><C-w>
map <silent> <A-b> <C-w><S-w>

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" }}}

" Autocommands {{{
autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 120})
" }}}

" Load system settings {{{
let sys_config = expand('<sfile>:p:h').'/sys_init.vim'
if filereadable(sys_config)
  execute 'source '.sys_config
endif
" }}}
