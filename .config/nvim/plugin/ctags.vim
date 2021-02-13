if exists('g:loaded_qftags')
	finish
endif
let g:loaded_qftags = 1

fun s:CTags(name)
  let tags = taglist(a:name)
  let qf_taglist = []
  for entry in tags
    call add(qf_taglist, {
      \ 'pattern':  entry['cmd'],
      \ 'filename': entry['filename'],
      \ })
  endfor
  if len(qf_taglist) > 0
    call setqflist(qf_taglist)
    copen
  else
    echo "No tags found for ".a:name
  endif
endfun

com! -nargs=1 CTags call s:CTags(<f-args>)

