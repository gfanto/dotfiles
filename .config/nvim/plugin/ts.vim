if exists('g:loaded_ts')
	finish
endif
let g:loaded_ts = 1

lua << EOF
  local ok, treesitter_config = pcall(require, "nvim-treesitter.configs")
  if ok then
    treesitter_config.setup {
      ensure_installed = "maintained",
      highlight = { enable = true },
      indent = { enable = true },
    }
  end
EOF
