if exists('g:loaded_bufresize')
	finish
endif
let g:loaded_bufresize = 1

fun! SmartWindowResize(direction) abort
  let l:window_resize_count = 1
  let l:current_window_is_last_window = (winnr() == winnr('$'))

  if a:direction == 'h'
    let [l:modifier_0, l:modifier_1, l:modifier_2] = ['vertical', '+', '-']
  elseif a:direction == 'k'
    let [l:modifier_0, l:modifier_1, l:modifier_2] = ['', '+', '-']
  elseif a:direction == 'j'
    let [l:modifier_0, l:modifier_1, l:modifier_2] = ['', '-', '+']
  elseif a:direction == 'l'
    let [l:modifier_0, l:modifier_1, l:modifier_2] = ['vertical', '-', '+']
  else
    echoerr 'Unexpected direction'
    return
  endif

  let l:modifier = l:current_window_is_last_window ? l:modifier_1 : l:modifier_2
  let l:command = l:modifier_0 . ' resize ' . l:modifier . l:window_resize_count . '<CR>'
  execute l:command
endfun

nnoremap <silent> <A-h> :call SmartWindowResize('h')<cr>
nnoremap <silent> <A-j> :call SmartWindowResize('j')<cr>
nnoremap <silent> <A-k> :call SmartWindowResize('k')<cr>
nnoremap <silent> <A-l> :call SmartWindowResize('l')<cr>

