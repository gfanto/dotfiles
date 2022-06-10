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
    }
  end
EOF
