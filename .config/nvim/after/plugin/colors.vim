if exists('g:after_colors')
  finish
endif
let g:after_colors = 1

if get(g:, 'loaded_floaterm')
  hi! link FloatermBorder GruvboxFg4
endif

if luaeval('pcall(require, "harpoon")')
  hi! link HarpoonBorder GruvboxFg4
  execute printf('hi! HarpoonWindow guibg=%s guifg=%s', g:terminal_color_0, g:terminal_color_15)
endif
