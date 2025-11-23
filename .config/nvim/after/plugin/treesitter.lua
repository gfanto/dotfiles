local configs = require("nvim-treesitter.configs")

configs.setup({
  highlight = { enable = true },
  indent = { enable = true },
  sync_install = false,
  auto_install = true,
  ignore_install = { "all" },
  modules = {},

  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      selection_modes = {
        ["@parameter.inner"] = "v",
        ["@parameter.outer"] = "v",
        ["@function.inner"]  = "V",
        ["@function.outer"]  = "V",
        ["@class.inner"]     = "V",
        ["@class.outer"]     = "V",
        ["@scope"]           = "v",
      },
    },

    move = {
      enable = true,
      set_jumps = true,
    },
  },

  ensure_installed = {
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
  },
})

-- TEXTOBJECT SELECT MAPPINGS
local ts_sel = require("nvim-treesitter.textobjects.select")
vim.keymap.set({ "x", "o" }, "af", function() ts_sel.select_textobject("@function.outer", "textobjects") end)
vim.keymap.set({ "x", "o" }, "if", function() ts_sel.select_textobject("@function.inner", "textobjects") end)
vim.keymap.set({ "x", "o" }, "ap", function() ts_sel.select_textobject("@parameter.outer", "textobjects") end)
vim.keymap.set({ "x", "o" }, "ac", function() ts_sel.select_textobject("@comment.outer", "textobjects") end)

-- TEXTOBJECT MOVE MAPPINGS
local ts_move = require("nvim-treesitter.textobjects.move")

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
local ts_repeat = require("nvim-treesitter.textobjects.repeatable_move")
vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat.repeat_last_move)
vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat.repeat_last_move_opposite)
vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat.builtin_f_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat.builtin_F_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat.builtin_t_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat.builtin_T_expr, { expr = true })
