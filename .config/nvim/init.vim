" *****************************************************************************
" Editor settings
" *****************************************************************************

set shell=/bin/bash

set nocompatible
filetype plugin indent on
syntax on

set noerrorbells
set termguicolors
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
set signcolumn=no

set hlsearch
set incsearch
set inccommand=nosplit
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

set ve=block
set scrolloff=8
set sidescroll=0
set cmdheight=1
set updatetime=250
set notimeout
set ttimeout
set ttimeoutlen=10
set shortmess+=c

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevelstart=999

set diffopt+=iwhite
set diffopt+=algorithm:patience
set diffopt+=indent-heuristic

" *****************************************************************************
" variables nad comands
" *****************************************************************************

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
  let g:rg_derive_root='true'
endif
let g:vrfr_rg = 'true'

let g:floaterm_autoclose = 2

let g:nvim_tree_follow = 1
let g:nvim_tree_auto_close = 1

com! OpenPython FloatermNew --width=0.5 --wintype=normal --name=ipython --position=right ipython -i --no-autoindent
com! OpenTerm FloatermNew --width=0.5 --wintype=normal --name=term --position=right fish

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

function! SmartWindowResize(direction) abort
  let l:window_resize_count = 1
  let l:current_window_is_last_window = (winnr() == winnr('$'))

  if a:direction == 'h'
    let [l:modifier_0, l:modifier_1, l:modifier_2] = ['vertical', '+', '-']
  elseif a:direction == 'k'
    let [l:modifier_0, l:modifier_1, l:modifier_2] = ['', '+', '-']
  elseif a:direction == 'j'
    let [l:modifier_0, l:modifier_1, l:modifier_2] = ['', '-', '+']
  elseif a:direction == 'l'
    let [l:modifier_0, l:modifier_1, l:modifier_2] = ['vertical', '-', '+']
  else
    echoerr 'Unexpected direction'
    return
  endif

  let l:modifier = l:current_window_is_last_window ? l:modifier_1 : l:modifier_2
  let l:command = l:modifier_0 . ' resize ' . l:modifier . l:window_resize_count . '<CR>'
  execute l:command
endfunction
nnoremap <silent> <A-h> :call SmartWindowResize('h')<cr>
nnoremap <silent> <A-j> :call SmartWindowResize('j')<cr>
nnoremap <silent> <A-k> :call SmartWindowResize('k')<cr>
nnoremap <silent> <A-l> :call SmartWindowResize('l')<cr>

" *****************************************************************************
" Plugs
" *****************************************************************************

call plug#begin('~/.config/nvim/plugged')

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'steelsojka/completion-buffers'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'tjdevries/lsp_extensions.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/completion-treesitter'

Plug 'sheerun/vim-polyglot'

Plug 'voldikss/vim-floaterm'

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-commentary'
Plug 'michaeljsmith/vim-indent-object'

Plug 'mbbill/undotree'

Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'vim-airline/vim-airline'
Plug 'gruvbox-community/gruvbox'

call plug#end()

set background=dark
colorscheme gruvbox

hi! TelescopeBorder guifg=#a89984 guibg=none gui=none
hi! FloatermBorder guifg=#a89984 guibg=none gui=none

" *****************************************************************************
" Personal key bindings
" *****************************************************************************

tnoremap <Esc> <C-\><C-n>

nnoremap <C-p> :Telescope git_files<CR>
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

nnoremap k gk
nnoremap j gj
xnoremap < <gv
xnoremap > >gv
vnoremap $ $h

nnoremap <leader>g :Telescope grep_string<CR>
nnoremap <leader>f :Telescope current_buffer_fuzzy_find<CR>
nnoremap <Leader>t :FloatermNew env fish<CR>
nnoremap <Leader>q :FloatermToggle<CR>
nnoremap <leader>u :UndotreeToggle<BAR>wincmd p<CR>
nnoremap <leader>e :NvimTreeToggle<CR>

map <silent> <A-s> :split<CR>
map <silent> <A-v> :vsplit<CR>
map <silent> <A-o> <C-w>o
map <silent> <A-n> <C-w><C-w>
map <silent> <A-b> <C-w><S-w>

" *****************************************************************************
" LSP settings
" *****************************************************************************

let g:completion_timer_cycle = 120
let g:completion_matching_strategy_list = ['fuzzy']
let g:completion_matching_ignore_case = 1
let g:completion_sorting = "none"
let g:completion_trigger_keyword_length = 3
let g:completion_chain_complete_list = [
    \{'complete_items': ['lsp', 'buffers']}
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
let g:airline#extensions#nvimlsp#enabled = 0

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
call sign_define('LspDiagnosticsSignWarning', {'text' : '', 'texthl' : 'LspDiagnosticsVirtualTextWarning'})
call sign_define('LspDiagnosticsSignInformation', {'text' : '>>', 'texthl' : 'LspDiagnosticsVirtualTextInformation'})
call sign_define('LspDiagnosticsSignHint', {'text' : '>>', 'texthl' : 'LspDiagnosticsVirtualTextHint'})

com! Format lua vim.lsp.buf.formatting_sync(nil, 5000)
com! LspStop lua vim.lsp.stop_client(vim.lsp.get_active_clients())
com! LspRestart lua vim.lsp.stop_client(vim.lsp.get_active_clients());vim.api.nvim_command('e')

com! Diagnostics lua require'telescope'.module_addons.show_diagnostics()

nmap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nmap <silent> K  <cmd>lua vim.lsp.buf.hover()<CR>
nmap <silent> gr <cmd>Telescope lsp_references<CR>
nmap <silent> cr <cmd>lua vim.lsp.buf.rename()<CR>
nmap <silent> gp <cmd>lua vim.lsp.diagnostic.goto_prev({ enable_popup = false })<CR>
nmap <silent> gn <cmd>lua vim.lsp.diagnostic.goto_next({ enable_popup = false })<CR>

nnoremap <leader>r <cmd>Telescope lsp_ducument_symbols<CR>
nnoremap <leader>w <cmd>Telescope lsp_workspace_symbols<CR>
nnoremap <leader>a <cmd>Telescope lsp_code_actions<CR>
nnoremap <leader>d <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>

lua << EOF
    local telescope_actions = require("telescope.actions")
    require"telescope".setup {
      defaults = {
        sorting_strategy = "ascending",
        border = {},
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        mappings = {
          i = {
            ["<C-j>"] = telescope_actions.move_selection_next,
            ["<C-k>"] = telescope_actions.move_selection_previous,
          }
        }
      }
    }
    require"telescope".load_extension("fzy_native")
    local telescope = require('telescope')
    telescope.module_addons = {}
    telescope.module_addons.show_diagnostics = function(opts)
      opts = opts or {}
      vim.lsp.diagnostic.set_loclist({open_loclist = false})
      require'telescope.builtin'.loclist(opts)
    end

    require"nvim-treesitter.configs".setup {
      ensure_installed = "maintained",
      highlight = { enable = true },
      indent = { enable = true },
    }

    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = false,
        virtual_text = {
          spacing = 4,
        },
      }
    )

    local lsp = require "lspconfig"
    local lsp_status = require("lsp-status")
    lsp_status.register_progress()
    lsp_status.config({
        status_symbol = "",
    })

    local on_attach = function(client, bufnr)
      if client.config.flags then
        client.config.flags.allow_incremental_sync = true
      end
      require"completion".on_attach(client, bufnr)
      require"lsp-status".on_attach(client, bufnr)
    end

    lsp.tsserver.setup{ on_attach = on_attach }
    lsp.html.setup{ on_attach = on_attach }
    lsp.cssls.setup{ on_attach = on_attach }
    lsp.gopls.setup{ on_attach = on_attach }
    lsp.clangd.setup{ on_attach = on_attach }
    lsp.vimls.setup{ on_attach = on_attach }
    lsp.sumneko_lua.setup{ on_attach = on_attach }
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
autocmd FileType go,typescript*,javascript,rust,python,html,css,less,c,cc,cpp,h,hpp,vim.lua setlocal omnifunc=v:lua.vim.lsp.omnifunc

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
autocmd FileType markdown,rst setl wrap textwidth=80 spell spelllang=it,en

" *****************************************************************************
" load current system settings
" *****************************************************************************

let sys_config = expand('<sfile>:p:h').'/sys_init.vim'
if filereadable(sys_config)
  execute 'source '.sys_config
endif
