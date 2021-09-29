if exists('g:loaded_file_explorer')
	finish
endif
let g:loaded_file_explorer = 1

lua ok, nvim_tree = pcall(require, "nvim-tree"); if ok then
  \ nvim_tree.setup()
  \ end
