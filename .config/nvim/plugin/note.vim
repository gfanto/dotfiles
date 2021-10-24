if exists('g:loaded_note')
	finish
endif
let g:loaded_note = 1

let g:note_folder = get(g:, "note_folder", "~/notes")
let g:note_fileending = get(g:, "note_fileending", ".md")
let g:note_set_keybindings = get(g:, "note_set_keybindings", 1)

function! s:note_new()
  let name = input("New note name: ")
  execute 'edit ' . g:note_folder . '/' . name
endfunction

function! s:note_handler(lines)
  if len(a:lines) < 1 | return | endif

  if len(a:lines) == 1
    let query = a:lines[0]
    let new_filename = fnameescape(query . g:note_fileending)
    let new_title = "# " . query

    execute "edit " . new_filename

    let failed = append(0, [new_title, ''])
    if (failed)
      echo "Unable to insert title file!"
    else
      let &modified = 1
    endif
  else
    execute "edit " fnameescape(a:lines[1])
  endif
endfunction

command! -nargs=* Notes call fzf#run(fzf#wrap({
  \ 'sink*':   function('<sid>note_handler'),
  \ 'options': '--print-query ',
  \ 'dir':     g:note_folder
  \ }))

function! s:rg_to_quickfix(line)
  let parts = split(a:line, ':')
  return {'filename': parts[0], 'lnum': parts[1], 'col': parts[2],
        \ 'text': join(parts[3:], ':')}
endfunction

function! s:find_notes_handler(lines)
  if len(a:lines) < 2 | return | endif

  let cmd = get({'ctrl-x': 'split',
               \ 'ctrl-v': 'vertical split',
               \ 'ctrl-t': 'tabe'}, a:lines[0], 'e')
  let list = map(a:lines[1:], 's:rg_to_quickfix(v:val)')

  let first = list[0]
  execute cmd escape(first.filename, ' %#\')
  execute first.lnum
  execute 'normal!' first.col.'|zz'

  if len(list) > 1
    call setqflist(list)
    copen
    wincmd p
  endif
endfunction

command! -nargs=* FindNotes call fzf#run(fzf#wrap({
  \ 'source':  printf('rg --column --color=always "%s"',
  \                   escape(empty(<q-args>) ? '' : <q-args>, '"\')),
  \ 'sink*':    function('<sid>find_notes_handler'),
  \ 'options': '--ansi --expect=ctrl-t,ctrl-v,ctrl-x --delimiter : --nth 4.. '.
  \            '--multi --bind=ctrl-a:select-all,ctrl-d:deselect-all '.
  \            '--color hl:68,hl+:110',
  \ 'dir':     g:note_folder
  \ }))

command! -bang -nargs=* FindNotesWithPreview
  \ 'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \ call fzf#vim#grep(
  \ fzf#vim#with_preview({'dir': g:note_folder}, 'right:50%'),
  \ 0,
  \ )

command! NewNote call s:note_new()

if g:note_set_keybindings
  nmap <silent> <leader>ne :NewNote<CR>
  nmap <silent> <leader>nn :Notes<CR>
  nmap <silent> <leader>nf :FindNotes<CR>
  nmap <silent> <leader>nw :FindNotesWithPreview<CR>
end
