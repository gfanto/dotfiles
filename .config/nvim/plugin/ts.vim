if exists('g:loaded_ts')
  finish
endif
let g:loaded_ts = 1

lua << EOF
  local ok, ts_config = pcall(require, "nvim-treesitter.configs")
  if ok then
    ts_config.setup {
      ensure_installed = "all",
      highlight = {
	enable = true,
	use_languagetree = true,
      },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
      textobjects = {
        move = {
          enable = true,
          goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
          goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
          goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
          goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
        },
      },
    }
  end
  local ok, ts_context = pcall(require, "treesitter-context")
  if ok then
    ts_context.setup()
  end
EOF
