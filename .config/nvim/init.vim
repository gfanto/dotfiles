" *****************************************************************************
" Editor settings
" *****************************************************************************

set shell=/bin/bash

set nocompatible
filetype plugin indent on
syntax on

set noerrorbells
set termguicolors

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
set signcolumn=yes

set hlsearch
set incsearch
set ignorecase

set nowrap
set noswapfile
set nobackup
set nowritebackup
set undodir=~/.config/nvim/undodir
set undofile

set complete-=i
set completeopt=menuone,noinsert,noselect
set pumheight=12

set mouse=a
set clipboard+=unnamedplus

set scrolloff=8
set sidescroll=0
set cmdheight=1
set updatetime=250
set ttimeout
set ttimeoutlen=100
set shortmess+=c

"set foldmethod=syntax
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable
set foldlevelstart=999

" *****************************************************************************
" variables nad comands
" *****************************************************************************

let g:mapleader = "\<Space>"

if glob('~/.python3') != ''
  let g:python3_host_prog = expand('~/.python3/bin/python')
else
  let g:python3_host_prog = systemlist('which python3')[0]
endif

let g:gruvbox_contrast_dark = 'hard'
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
let g:gruvbox_invert_selection='0'

if executable('rg')
  let g:rg_derive_root='true'
endif
let g:vrfr_rg = 'true'

let g:fzf_layout = {'window': {'height': 0.8, 'width': 0.8}}
let $FZF_DEFAULT_OPTS='--reverse'

com! OpenPython FloatermNew --width=0.5 --wintype=normal --name=ipython --position=right ipython -i --no-autoindent
com! OpenTerm FloatermNew --width=0.5 --wintype=normal --name=term --position=right fish
com! CopyRel let @+ = expand('%')

let g:floaterm_autoclose = 2

let g:lua_tree_follow = 1
let g:lua_tree_auto_close = 1

let g:fzf_branch_actions = {}
let g:fzf_tag_actions = {}

" *****************************************************************************
" Plugs
" *****************************************************************************

call plug#begin('~/.config/nvim/plugged')

Plug 'nvim-treesitter/nvim-treesitter'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'steelsojka/completion-buffers'
Plug 'tjdevries/lsp_extensions.nvim'
Plug 'nvim-treesitter/completion-treesitter'

Plug 'sheerun/vim-polyglot'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'michaeljsmith/vim-indent-object'

Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'voldikss/vim-floaterm'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'gfanto/fzf-lsp.nvim'
Plug 'stsewd/fzf-checkout.vim'

Plug 'vim-airline/vim-airline'
Plug 'gruvbox-community/gruvbox'

call plug#end()

set background=dark
colorscheme gruvbox

" *****************************************************************************
" Personal key bindings
" *****************************************************************************

tnoremap <Esc> <C-\><C-n>

nnoremap <C-p> :GFiles<CR>
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

nnoremap <leader>g :Rg<CR>
nnoremap <leader>f :BLines<CR>
nnoremap <Leader>t :FloatermNew env NOTMUX=yes fish<CR>
nnoremap <Leader>q :FloatermToggle<CR>
nnoremap <leader>e :LuaTreeToggle<CR>

" *****************************************************************************
" LSP settings
" *****************************************************************************

let g:airline#extensions#nvimlsp#enabled = 0
let g:completion_matching_strategy_list = ['fuzzy']
let g:completion_matching_ignore_case = 1
let g:completion_sorting = "none"
let g:completion_trigger_keyword_length = 3
let g:completion_chain_complete_list = [
    \{'complete_items': ['lsp', 'ts', 'buffers']}
\]

function! LspStatus() abort
  if luaeval('#vim.lsp.buf_get_clients() > 0')
      return airline#util#shorten(luaeval("require('lsp-status').status()"), 91, 9)
  endif
  return ''
endfunction
call airline#parts#define_function('lsp_status', 'LspStatus')
call airline#parts#define_condition('lsp_status', 'luaeval("#vim.lsp.buf_get_clients() > 0")')
let g:airline_section_c = airline#section#create(['%<', 'file', g:airline_symbols.space, 'readonly', 'lsp_status'])

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ completion#trigger_completion()

call sign_define('LspDiagnosticsSignError', {'text' : '>>', 'texthl' : 'LspDiagnosticsVirtualTextError'})
call sign_define('LspDiagnosticsSignWarning', {'text' : '⚠', 'texthl' : 'LspDiagnosticsVirtualTextWarning'})
call sign_define('LspDiagnosticsSignInformation', {'text' : '>>', 'texthl' : 'LspDiagnosticsVirtualTextInformation'})
call sign_define('LspDiagnosticsSignHint', {'text' : '>>', 'texthl' : 'LspDiagnosticsVirtualTextHint'})

com! Format lua vim.lsp.buf.formatting()
com! LspStop lua vim.lsp.stop_client(vim.lsp.get_active_clients())
com! LspRestart lua vim.lsp.stop_client(vim.lsp.get_active_clients());vim.api.nvim_command('e')
com! OpenDiagnostic lua vim.lsp.diagnostic.set_loclist()

nmap <silent> gd :Definitions<CR>
nmap <silent> K  :lua vim.lsp.buf.hover()<CR>
nmap <silent> gr :References<CR>
nmap <silent> cr :lua vim.lsp.buf.rename()<CR>
nmap <silent> gp :lua vim.lsp.diagnostic.goto_prev({ enable_popup = false })<CR>
nmap <silent> gn :lua vim.lsp.diagnostic.goto_next({ enable_popup = false })<CR>

nnoremap <leader>r :DocumentSymbols<CR>
nnoremap <leader>w :WorkspaceSymbols<CR>
nnoremap <leader>a :CodeActions<CR>
nnoremap <leader>d :lua vim.lsp.diagnostic.show_line_diagnostics()<CR>

lua << EOF
    require'nvim-treesitter.configs'.setup {
      ensure_installed = "all",
      highlight = {
        enable = true,
        disable = {},
      },
    }

    vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = false,
        virtual_text = {
          spacing = 4,
        },
      }
    )

    local lsp = require 'lspconfig'
    local lsp_status = require('lsp-status')
    lsp_status.register_progress()
    lsp_status.config({
        status_symbol = "",
    })

    local on_attach = function(client, bufnr)
      require'completion'.on_attach(client, bufnr)
      require'lsp-status'.on_attach(client, bufnr)
    end

    lsp.tsserver.setup{ on_attach = on_attach }
    lsp.html.setup{ on_attach = on_attach }
    lsp.cssls.setup{ on_attach = on_attach }
    lsp.gopls.setup{ on_attach = on_attach }
    lsp.clangd.setup{ on_attach = on_attach }
    lsp.pyls.setup{
      on_attach = on_attach,
      capabilities = vim.tbl_extend("keep", lsp.pyls.capabilities or {}, lsp_status.capabilities),
      settings = {
        python = { workspaceSymbols = { enabled = true }},
        pyls = {
            plugins = {
              pycodestyle = { enabled = false },
              pyls_mypy = { enabled = true, live_mode = false },
              pyls_black = { enabled = true },
              rope = { enabled = true },
            }
        }
      }
    }
    lsp.rust_analyzer.setup{
      on_attach = on_attach,
      capabilities = vim.tbl_extend("keep", lsp.rust_analyzer.capabilities or {}, lsp_status.capabilities),
    }
EOF

autocmd CursorHold,CursorHoldI *.rs :lua require'lsp_extensions'.inlay_hints{
  \ aligned = flase,
  \ only_current_line = true,
  \ prefix = '     » ',
  \ highlight = 'NonText'
  \ }
autocmd FileType go,typescript*,javascript,rust,python,html,css,less,c,cc,cpp,h,hpp setlocal omnifunc=v:lua.vim.lsp.omnifunc

" *****************************************************************************
" autocmd
" *****************************************************************************

fun! TrimWhitespace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfun

autocmd BufWritePre * :call TrimWhitespace()
autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 120})
"autocmd FileType yaml,python setl foldmethod=indent
autocmd FileType markdown,rst setl spell spelllang=it,en

