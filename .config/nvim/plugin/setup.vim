if exists('g:loaded_setup')
  finish
endif
let g:loaded_setup = 1

lua << EOF
local ok, harpoon = pcall(require, "harpoon")
if ok then
  harpoon.setup({
    menu = {
      borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    },
  })
end
EOF
