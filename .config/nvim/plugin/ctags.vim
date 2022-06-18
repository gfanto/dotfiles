if exists('g:loaded_qftags')
	finish
endif
let g:loaded_qftags = 1

fun! s:CTags(name)
  let l:tags = taglist(a:name)
  let l:qf_taglist = []
  for l:entry in l:tags
    call add(l:qf_taglist, {
      \ 'filename': l:entry['filename'],
      \ 'pattern':  l:entry['cmd'][1:-2],
      \ })
  endfor
  if len(l:qf_taglist) > 0
    call setqflist(l:qf_taglist)
    copen
  else
    echo "No tags found for ".a:name
  endif
endfun

com! -nargs=1 CTags call s:CTags(<f-args>)

