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

local ok, filetype = pcall(require, "filetype")
if ok then
  filetype.setup({
    overrides = {
      complex = {
        ["Dockerfile.*"] = "dockerfile",
      },
    }
  })
end
EOF

if get(g:, 'loaded_conflict_marker')
  hi! ConflictMarkerBegin guibg=#2f7366
  hi! ConflictMarkerOurs guibg=#2e5049
  hi! ConflictMarkerTheirs guibg=#344f69
  hi! ConflictMarkerEnd guibg=#2f628e
  hi! ConflictMarkerCommonAncestorsHunk guibg=#754a81
end
