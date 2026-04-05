local ts = require("nvim-treesitter")
local ts_textobjects = require("nvim-treesitter-textobjects")

ts.setup({
  install_dir = vim.fn.stdpath("data") .. "/site",
})

ts.install({
  "bash",
  "c",
  "cpp",
  "go",
  "javascript",
  "typescript",
  "json",
  "jsonc",
  "jsdoc",
  "lua",
  "python",
  "rust",
  "html",
  "yaml",
  "css",
  "toml",
  "markdown",
  "markdown_inline",
  "solidity",
  "vimdoc",
  "query",
  "regex",
})

ts_textobjects.setup({
  select = {
    lookahead = true,
    selection_modes = {
      ["@parameter.inner"] = "v",
      ["@parameter.outer"] = "v",
      ["@function.inner"]  = "V",
      ["@function.outer"]  = "V",
      ["@class.inner"]     = "V",
      ["@class.outer"]     = "V",
      ["@local.scope"]     = "v",
    },
    include_surrounding_whitespace = false,
  },

  move = {
    set_jumps = true,
  },
})

-- Enable treesitter highlighting
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "bash",
    "c",
    "cpp",
    "css",
    "go",
    "html",
    "javascript",
    "jsdoc",
    "json",
    "jsonc",
    "lua",
    "markdown",
    "python",
    "query",
    "rust",
    "solidity",
    "toml",
    "typescript",
    "vim",
    "yaml",
  },
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})

-- Enable treesitter indentexpr
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "c",
    "cpp",
    "css",
    "go",
    "html",
    "javascript",
    "lua",
    "python",
    "rust",
    "typescript",
    "yaml",
  },
  callback = function()
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

-- Optional: treesitter folding
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.wo.foldmethod = "expr"
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  end,
})

-- TEXTOBJECT SELECT MAPPINGS
local ts_sel = require("nvim-treesitter-textobjects.select")

vim.keymap.set({ "x", "o" }, "af", function()
  ts_sel.select_textobject("@function.outer", "textobjects")
end)

vim.keymap.set({ "x", "o" }, "if", function()
  ts_sel.select_textobject("@function.inner", "textobjects")
end)

vim.keymap.set({ "x", "o" }, "ap", function()
  ts_sel.select_textobject("@parameter.outer", "textobjects")
end)

vim.keymap.set({ "x", "o" }, "ac", function()
  ts_sel.select_textobject("@comment.outer", "textobjects")
end)

-- TEXTOBJECT MOVE MAPPINGS
local ts_move = require("nvim-treesitter-textobjects.move")

vim.keymap.set({ "n", "x", "o" }, "]f", function()
  ts_move.goto_next("@function.outer", "textobjects")
end, { desc = "Next function boundary" })

vim.keymap.set({ "n", "x", "o" }, "[f", function()
  ts_move.goto_previous("@function.outer", "textobjects")
end, { desc = "Previous function boundary" })

vim.keymap.set({ "n", "x", "o" }, "]F", function()
  ts_move.goto_next_start("@function.outer", "textobjects")
end, { desc = "Next function start" })

vim.keymap.set({ "n", "x", "o" }, "[F", function()
  ts_move.goto_previous_start("@function.outer", "textobjects")
end, { desc = "Previous function start" })

vim.keymap.set({ "n", "x", "o" }, "]p", function()
  ts_move.goto_next_start("@parameter.inner", "textobjects")
end, { desc = "Next parameter" })

vim.keymap.set({ "n", "x", "o" }, "[p", function()
  ts_move.goto_previous_start("@parameter.inner", "textobjects")
end, { desc = "Previous parameter" })

-- REPEATABLE MOVE
local ts_repeat = require("nvim-treesitter-textobjects.repeatable_move")

vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat.repeat_last_move_next)
vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat.repeat_last_move_previous)
vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat.builtin_f_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat.builtin_F_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat.builtin_t_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat.builtin_T_expr, { expr = true })
