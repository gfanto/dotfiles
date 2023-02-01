if get(g:, 'loaded_airline') && luaeval('pcall(require, "lsp-status")')
  fun! LspStatus() abort
    if luaeval('#vim.lsp.buf_get_clients() > 0')
        return airline#util#shorten(luaeval("require('lsp-status').status()"), 91, 9)
    endif
    return ''
  endfun

  call airline#parts#define_function('lsp_status', 'LspStatus')
  call airline#parts#define_condition('lsp_status', 'luaeval("#vim.lsp.buf_get_clients() > 0")')
  let g:airline_section_c = airline#section#create(['%<', 'file', g:airline_symbols.space, 'readonly', 'lsp_status'])
  let g:airline#extensions#nvimlsp#enabled = 0
endif
