if get(g:, 'loaded_tree')
  fun! s:NvimTreeOSOpen()
    lua local ok, lib = pcall(require, "nvim-tree.lib");
    \ if ok then
    \ local ok, node = pcall(lib.get_node_at_cursor)
    \ if ok and node then
    \ vim.fn.jobstart("xdg-open '" .. node.absolute_path .. "' &")
    \ end
    \ end
  endfun

  com! NvimTreeOSOpen call s:NvimTreeOSOpen()
endif
