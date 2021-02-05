if exists('g:loaded_whitespaces')
	finish
endif
let g:loaded_whitespaces = 1

let g:whitespaces_auto_trim = get(g:, 'whitespaces_auto_trim', 1)

fun! s:TrimWhitespace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfun

if g:whitespaces_auto_trim
  augroup plugin_whitespaces
   autocmd!
   autocmd BufWritePre * :call s:TrimWhitespace()
  augroup END
endif
