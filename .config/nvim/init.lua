-- ============
-- Editor settings
-- ============

vim.opt.shell = "/bin/bash"

vim.opt.compatible = false
vim.cmd("filetype plugin indent on")
vim.cmd("syntax on")

vim.opt.errorbells = false
vim.opt.termguicolors = true

vim.opt.hidden = true
vim.opt.lazyredraw = true

vim.opt.jumpoptions = "stack"
vim.opt.switchbuf = "useopen"

vim.opt.mouse = "a"

-- Clipboard (WSL check)
if vim.fn.system('[[ -v WSLENV ]]') and vim.v.shell_error == 0 then
    vim.g.clipboard = {
        name = "WslClipboard",
        copy = {
            ["+"] = "clip.exe",
            ["*"] = "clip.exe",
        },
        paste = {
            ["+"] = "powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace(\"`r\", \"\"))",
            ["*"] = "powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace(\"`r\", \"\"))",
        },
        cache_enabled = 0,
    }
    -- commented temporary because is really slow
    -- vim.opt.clipboard:append("unnamedplus")
else
    vim.opt.clipboard:append("unnamedplus")
end

vim.opt.path = ".,**"
vim.opt.wildmenu = true
vim.opt.wildignore:append({
    ".git",".hg",".svn",".stversions","*.pyc","*.spl","*.o","*.out","*~","%*",
    "*.jpg","*.jpeg","*.png","*.gif","*.zip","**/tmp/**","*.DS_Store",
    "**/node_modules/**","**/bower_modules/**","*/.sass-cache/*",
    "application/vendor/**","**/vendor/ckeditor/**","media/vendor/**",
    "__pycache__","*.egg-info",".pytest_cache",".mypy_cache/**",
})
vim.opt.wildignorecase = true
vim.opt.wildcharm = vim.fn.char2nr("<C-z>")

vim.opt.isfname:remove("=")

-- ============
-- Editor layout
-- ============

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.guicursor = ""
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 8
vim.opt.sidescroll = 0
vim.opt.shortmess:append("c")
vim.opt.equalalways = false

vim.opt.pumblend = 7
vim.opt.winblend = 10

-- ============
-- Text formatting
-- ============

vim.opt.expandtab = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = -1
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.shiftround = true

vim.opt.wrap = false
vim.opt.breakindentopt = "shift:4,min:20"

vim.opt.formatoptions:remove("1")
vim.opt.formatoptions:remove("o")
vim.opt.formatoptions:append("j")

vim.opt.virtualedit = "block"

vim.opt.showmatch = true
vim.opt.matchpairs:append("<:>")
vim.opt.matchtime = 1

vim.opt.list = true
vim.opt.listchars = {
  eol = "↲",
  tab = "» ",
  trail = "·",
  extends = "…",
  precedes = "…",
  nbsp = "␣",
}

-- ============
-- Search
-- ============

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.infercase = true
vim.opt.incsearch = true
vim.opt.wrapscan = true
vim.opt.hlsearch = true

vim.opt.gdefault = true
vim.opt.inccommand = "nosplit"

-- ============
-- Dirs & temp files
-- ============

vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.undofile = true
vim.opt.swapfile = false

vim.opt.directory = vim.fn.expand("~/.config/nvim/swapdir")
vim.opt.undodir = vim.fn.expand("~/.config/nvim/undodir")
vim.opt.backupdir = vim.fn.expand("~/.config/nvim/backupdir")
vim.opt.viewdir = vim.fn.expand("~/.config/nvim/viewdir")
vim.opt.shada = { "!", "'300", "<50", "@100", "s10", "h" }

-- ============
-- Completion
-- ============

vim.opt.complete:remove("i")
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.pumheight = 12

-- ============
-- Timings
-- ============

vim.opt.timeout = true
vim.opt.ttimeout = true
vim.opt.timeoutlen = 500
vim.opt.ttimeoutlen = 10
vim.opt.updatetime = 100

-- ============
-- Folds
-- ============

vim.opt.foldenable = true
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevelstart = 99

-- ============
-- Diff
-- ============

vim.opt.diffopt:append({
    "iwhite",
    "linematch:60",
    "algorithm:patience",
    "indent-heuristic",
})

-- ============
-- Globals
-- ============

vim.env.SHELL = "/bin/bash"
vim.env.BAT_THEME = "gruvbox-dark"
vim.env.FZF_DEFAULT_OPTS = "--reverse --no-separator"

vim.g.mapleader = " "

-- python host
if vim.fn.glob("~/.python3") ~= "" then
    vim.g.python3_host_prog = vim.fn.expand("~/.python3/bin/python")
else
    vim.g.python3_host_prog = vim.fn.systemlist("which python3")[1]
end

-- true color escape sequences
if vim.fn.exists("+termguicolors") == 1 then
    vim.cmd([[let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"]])
    vim.cmd([[let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"]])
end

vim.g.did_load_filetypes = 1
vim.g.golden_ratio_autocommand = 0

-- ============
-- Plugins
-- ============

vim.cmd("packadd cfilter")

vim.pack.add({
    { src = "https://github.com/tpope/vim-sensible" },
    { src = "https://github.com/tpope/vim-fugitive" },
    { src = "https://github.com/tpope/vim-surround" },
    { src = "https://github.com/tpope/vim-repeat" },
    { src = "https://github.com/tpope/vim-commentary" },
    { src = "https://github.com/tpope/vim-dispatch" },
    { src = "https://github.com/tpope/vim-unimpaired" },
    { src = "https://github.com/tpope/vim-eunuch" },
    { src = "https://github.com/tpope/vim-characterize" },
    { src = "https://github.com/tpope/vim-obsession" },
    { src = "https://github.com/tpope/vim-sleuth" },
    { src = "https://github.com/tpope/vim-abolish" },
    { src = "https://github.com/tpope/vim-vinegar" },

    { src = "https://github.com/michaeljsmith/vim-indent-object" },
    { src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" },
    { src = "https://github.com/akinsho/toggleterm.nvim", version = "*" },

    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },

    { src = "https://github.com/ibhagwan/fzf-lua" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },

    { src = "https://github.com/nvim-treesitter/nvim-treesitter", branch = 'master', lazy = false, build = ":TSUpdate" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter-context" },

    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/williamboman/mason.nvim" },
    { src = "https://github.com/williamboman/mason-lspconfig.nvim" },
    { src = "https://github.com/nvimtools/none-ls.nvim" },

    { src = "https://github.com/Saghen/blink.cmp", branch = "v1.8.0", },
    { src = "https://github.com/L3MON4D3/LuaSnip" },
    { src = "https://github.com/onsails/lspkind.nvim" },

    { src = "https://github.com/j-hui/fidget.nvim" },
    { src = "https://github.com/ray-x/lsp_signature.nvim" },

    { src = "https://github.com/nvim-lualine/lualine.nvim" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/ellisonleao/gruvbox.nvim" },
    { src = "https://github.com/roman/golden-ratio" },
})

-- ============
-- Mappings
-- ============

local map = vim.keymap.set
map("t", "<Esc>", [[<C-\><C-n>]])

map("n", "Q", "@q")
map("n", "k", "gk")
map("n", "j", "gj")
map("n", "Y", "y$", { silent = true })
map("v", "$", "$h")
map("x", "<", "<gv")
map("x", ">", ">gv")

map("n", "S", [["_S]], { silent = true })
map("n", "x", [["_x]], { silent = true })
map("n", "s", [["_s]], { silent = true })
map("x", "X", [["_d]], { silent = true })

map("n", "gs", ":buffer#<CR>", { silent = true })
map("n", "gy", function()
  local regtype = vim.fn.getregtype()
  local mode_char = string.sub(regtype, 1, 1)  -- like 'v' or 'V'
  return string.format("`[%s`]", mode_char)
end, { expr = true, silent = true })

map("n", "<leader><leader>", ":w ++p<CR>", { silent = true })
map("n", "<leader>n", ":e /dev/null<CR>", { silent = true })
map("n", "<leader>G", [[:gr! <C-r><C-w><CR>:bo copen<CR><C-w><C-w>]], { silent = true })
map("n", "<C-w>t", ":tabnew<CR>", { silent = true })

local win_modes = { "n", "v", "o" }
map(win_modes, "<A-o>", "<C-w>o", { silent = true })
map(win_modes, "<A-n>", "<C-w><C-w>", { silent = true })
map(win_modes, "<A-p>", "<C-w><S-w>", { silent = true })
map(win_modes, "<A-s>", ":split<CR>", { silent = true })
map(win_modes, "<A-v>", ":vsplit<CR>", { silent = true })
map(win_modes, "<A-m>", ":GoldenRatioResize<CR>", { silent = true })

-- ============
-- Command utils
-- ============

vim.api.nvim_create_user_command("CopyRel", function()
  vim.fn.setreg("+", vim.fn.expand("%"))
end, {})

vim.api.nvim_create_user_command("CopyAbs", function()
  vim.fn.setreg("+", vim.fn.expand("%:p"))
end, {})

vim.api.nvim_create_user_command("CopyNam", function()
  vim.fn.setreg("+", vim.fn.expand("%:t"))
end, {})

-- ============
-- Local system setting
-- ============

local base = vim.fn.expand("<sfile>:p:h")

local sys_lua = base .. "/sys_init.lua"
local sys_vim = base .. "/sys_init.vim"

if vim.fn.filereadable(sys_lua) == 1 then
  dofile(sys_lua)
elseif vim.fn.filereadable(sys_vim) == 1 then
  vim.cmd("source " .. sys_vim)
end
