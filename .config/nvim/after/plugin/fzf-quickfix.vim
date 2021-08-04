if !get(g:, 'loaded_fzf')
  finish
end

let s:is_win = has('win32') || has('win64')

fun! s:escape(path)
  let path = fnameescape(a:path)
  return s:is_win ? escape(path, '$') : path
endfun

fun! s:open(cmd, target)
  if stridx('edit', a:cmd) == 0 && fnamemodify(a:target, ':p') ==# expand('%:p')
    return
  endif
  execute a:cmd s:escape(a:target)
endfun

fun! s:centry(line)
  let l:parts = split(a:line, ':')

  return {
    \ 'filename': parts[0],
    \ 'lnum': parts[1],
    \ 'col': parts[2],
    \ 'text': join(parts[3:], ':'),
    \ }
endfun

fun! s:cline(key, line) abort
  let l:filepath = expand('#' . a:line.bufnr . ':p')
  let l:filepath = fnamemodify(l:filepath, ':.')
  return l:filepath . ':' . a:line.lnum . ':' . a:line.col . ':' . a:line.text
endfun

fun! s:sink(type, nr, lines) abort
  if len(a:lines) == 1
    let l:entry = s:centry(a:lines[0])

    call s:open('edit', l:entry['filename'])
    call cursor(l:entry['lnum'], l:entry['col'])
    normal! zz
    echo l:entry['text']
  elseif len(a:lines) > 1
    if a:type == 'c'
      call setqflist(map(a:lines, 's:centry(v:val)'))
      copen
    elseif a:type == 'l'
      call setloclist(a:nr, map(a:lines, 's:centry(v:val)'))
      lopen
    else
      echoerr 'Invalid type ' . a:type
    endif
  endif
endfun

fun! s:csink(lines) abort
  call s:sink('c', 0, a:lines)
endfun

fun! s:lsink(nr, lines) abort
  call s:sink('l', a:nr, a:lines)
endfun

fun! s:quickfix(bang) abort
  if winnr('$') > 1
    cclose
  endif

  call fzf#run(fzf#wrap('quickfix', {
    \ 'source': map(getqflist(), function('s:cline')),
    \ 'sink*': function('s:csink'),
    \ 'options': ['--multi', '--bind', 'ctrl-a:select-all,ctrl-d:deselect-all']
    \ }, a:bang))
endfun

fun! s:location(bang) abort
  if winnr('$') > 1
    cclose
  endif

  call fzf#run(fzf#wrap('location', {
    \ 'source': map(getloclist(bufnr()), function('s:cline')),
    \ 'sink*': function('s:lsink', [bufnr(0)]),
    \ 'options': ['--multi', '--bind', 'ctrl-a:select-all,ctrl-d:deselect-all']
    \ }, a:bang))
endfun

com! -bang Quickfix call s:quickfix(<bang>0)
com! -bang Location call s:location(<bang>0)

if get(g:, 'loaded_fzf_vim')
  fun! s:fquickfix(bang) abort
    if winnr('$') > 1
      cclose
    endif

    call fzf#run(fzf#vim#with_preview(fzf#wrap('quickfix', {
      \ 'source': map(getqflist(), function('s:cline')),
      \ 'sink*': function('s:csink'),
      \ 'options': ['--delimiter', ':', '--preview-window', '+{2}-/2', '--multi', '--bind', 'ctrl-a:select-all,ctrl-d:deselect-all']
      \ }, a:bang)))
  endfun

  fun! s:flocation(bang) abort
    if winnr('$') > 1
      cclose
    endif

    call fzf#run(fzf#vim#with_preview(fzf#wrap('location', {
      \ 'source': map(getloclist(bufnr()), function('s:cline')),
      \ 'sink*': function('s:lsink', [bufnr(0)]),
      \ 'options': ['--delimiter', ':', '--preview-window', '+{2}-/2', '--multi', '--bind', 'ctrl-a:select-all,ctrl-d:deselect-all']
      \ }, a:bang)))
  endfun

  com! -bang FQuickfix call s:fquickfix(<bang>0)
  com! -bang FLocation call s:flocation(<bang>0)
endif
