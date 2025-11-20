if exists('g:loaded_join_with')
	finish
endif
let g:loaded_join_with = 1

function! JoinWith(delim) range
  let lines = getline(a:firstline, a:lastline)
  let text = join(map(lines, 'trim(v:val)'), a:delim)

  call setline(a:firstline, text)

  if a:lastline > a:firstline
    execute a:firstline + 1 . ',' . a:lastline . 'delete _'
  endif
endfunction

command! -range -nargs=1 JoinWith
      \ <line1>,<line2>call JoinWith(<q-args>)
