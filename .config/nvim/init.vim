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
set switchbuf=useopen

set mouse=a
if system('[[ -v WSLENV ]]') == 0 && v:shell_error == 0
  let g:clipboard = {
      \   'name': 'WslClipboard',
      \   'copy': {
      \      '+': 'clip.exe',
      \      '*': 'clip.exe',
      \    },
      \   'paste': {
          \      '+': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
          \      '*': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      \   },
      \   'cache_enabled': 0,
      \ }

  set clipboard=
else
  set clipboard& clipboard+=unnamedplus
endif

set path=.,**
set wildmenu
set wildignore+=.git,.hg,.svn,.stversions,*.pyc,*.spl,*.o,*.out,*~,%*
set wildignore+=*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store
set wildignore+=**/node_modules/**,**/bower_modules/**,*/.sass-cache/*
set wildignore+=application/vendor/**,**/vendor/ckeditor/**,media/vendor/**
set wildignore+=__pycache__,*.egg-info,.pytest_cache,.mypy_cache/**
set wildignorecase
set wildcharm=<C-z>

set isfname-==
" }}}

" Editor Layout {{{
set number
set relativenumber
set guicursor=
set signcolumn=yes
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
set formatoptions-=1
set formatoptions-=o
set formatoptions+=j

set ve=block

set showmatch
set matchpairs+=<:>
set matchtime=1

" set conceallevel=2
" set concealcursor=niv
" set list
" set listchars=eol:↲,tab:»\ ,trail:·,conceal:┊,nbsp:␣
" }}}

" Search {{{
set ignorecase
set smartcase
set infercase
set incsearch
set wrapscan
set hlsearch

set gdefault

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
set completeopt=menuone,noselect
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
set diffopt+=linematch:60
set diffopt+=algorithm:patience
set diffopt+=indent-heuristic
" }}}

" Globals {{{
let $SHELL = '/bin/bash'
let $BAT_THEME = 'gruvbox-dark'
let $FZF_DEFAULT_OPTS = '--reverse --no-separator'

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

let g:did_load_filetypes = 1

let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_invert_selection = 0
let g:gruvbox_italic = 1
let g:gruvbox_italicize_comments = 1

let g:golden_ratio_autocommand = 0

if executable('rg')
  set grepformat=%f:%l:%m
  let &grepprg = 'rg --vimgrep' . (&smartcase ? ' --smart-case' : '')
  let g:rg_derive_root='true'
endif

let g:floaterm_autoclose = 2

let g:indent_blankline_show_first_indent_level = v:false
let g:indent_blankline_buftype_exclude = ['terminal', 'help']
let g:indent_blankline_char = "¦"

let g:fzf_lsp_layout = { 'down': '30%' }
let g:fzf_lsp_preview_window = 'right:50%:noborder'
let g:fzf_lsp_colors = 'bg+:-1'

com! CopyRel let @+ = expand('%')
com! CopyAbs let @+ = expand('%:p')
com! CopyNam let @+ = expand('%:t')
com! -bang Term execute (<bang>0 ?
  \'FloatermNew --width=0.5 --position=right --wintype=vsplit --name=term fish'
  \:
  \'FloatermNew --height=0.4 --position=bottom --wintype=split --name=term fish'
  \)
" }}}

" Plugins {{{
runtime macros/matchit.vim

packadd cfilter
packadd termdebug

call plug#begin('~/.config/nvim/plugged')
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
" Plug 'spywhere/detect-language.nvim'

Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lsp-document-symbol'
Plug 'hrsh7th/cmp-cmdline'
Plug 'onsails/lspkind-nvim'
Plug 'ray-x/lsp_signature.nvim'
Plug 'lvimuser/lsp-inlayhints.nvim'

Plug 'nathom/filetype.nvim'
Plug 'sheerun/vim-polyglot'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-vinegar'

Plug 'rhysd/conflict-marker.vim'
Plug 'psliwka/vim-dirtytalk', { 'do': ':DirtytalkUpdate' }
Plug 'michaeljsmith/vim-indent-object'
Plug 'nvim-lua/plenary.nvim'
Plug 'ThePrimeagen/harpoon'
Plug 'mbbill/undotree'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'ahmedkhalf/project.nvim'
Plug 'voldikss/vim-floaterm'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'
Plug 'gfanto/fzf-lsp.nvim'

Plug 'roman/golden-ratio'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'vim-airline/vim-airline'
Plug 'gruvbox-community/gruvbox'
call plug#end()
" }}}

" Colors {{{
set background=dark
colorscheme gruvbox
" }}}

" Key bindings {{{
tnoremap <Esc> <C-\><C-n>

nnoremap <C-p> :call execute(isdirectory('.git') ? ':GFiles' : ':Files')<CR>
nnoremap <C-t> :tabnew<CR>
nnoremap <C-q> :tabclose<CR>

nnoremap <silent> Y y$
nnoremap <silent> S "_S
nnoremap <silent> x "_x
nnoremap <silent> s "_s
vnoremap <silent> X "_d

nnoremap Q @q
nnoremap k gk
nnoremap j gj
xnoremap < <gv
xnoremap > >gv
vnoremap $ $h

nnoremap <silent> gs :buffer#<CR>
nnoremap <expr> gy '`[' . strpart(getregtype(), 0, 1) . '`]'

nnoremap <leader><leader> <cmd>w ++p<CR>
nnoremap <leader>f <cmd>BLines<CR>
nnoremap <Leader>t <cmd>FloatermNew --height=0.8 --width=0.8 env fish<CR>
nnoremap <Leader>q <cmd>FloatermToggle<CR>
nnoremap <leader>u <cmd>UndotreeToggle<CR>
nnoremap <leader>e <cmd>NvimTreeToggle<CR>
nnoremap <leader>E <cmd>NvimTreeFindFile<CR>
nnoremap <leader>g <cmd>Rg<CR>
nnoremap <leader>G :gr! <C-r><C-w><CR>
nnoremap <leader>h :lua require("harpoon.mark").add_file()<CR>
nnoremap <leader>H :lua require("harpoon.ui").toggle_quick_menu()<CR>
for i in [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
  exec 'nnoremap <leader>'.i.' :lua require("harpoon.ui").nav_file('.i.')<CR>'
endfor

map <silent> <A-o> <C-w>o
map <silent> <A-n> <C-w><C-w>
map <silent> <A-p> <C-w><S-w>
map <silent> <A-s> :split<CR>
map <silent> <A-v> :vsplit<CR>
map <silent> <A-m> :GoldenRatioResize<CR>

nnoremap <right> :FloatermNext<CR>
nnoremap <left> :FloatermPrev<CR>

" inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" }}}

" Autocommands {{{
augroup InitAutoCommand
  autocmd!
  autocmd TermOpen * startinsert
  autocmd TermOpen * setlocal norelativenumber nonumber
  autocmd TermClose * call nvim_input('<CR>')
  autocmd TextYankPost *
    \ silent! lua require'vim.highlight'.on_yank {timeout = 120}
augroup end
" }}}

" Load system settings {{{
let sys_config = expand('<sfile>:p:h').'/sys_init.vim'
if filereadable(sys_config)
  execute 'source '.sys_config
endif
" }}}
