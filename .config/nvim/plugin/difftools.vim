" Credits: https://github.com/imxiejie/ThinkVim.git

" MIT License

" Copyright (c) 2019 taigacute

" Permission is hereby granted, free of charge, to any person obtaining a copy
" of this software and associated documentation files (the "Software"), to deal
" in the Software without restriction, including without limitation the rights
" to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
" copies of the Software, and to permit persons to whom the Software is
" furnished to do so, subject to the following conditions:

" The above copyright notice and this permission notice shall be included in all
" copies or substantial portions of the Software.

" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
" IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
" FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
" AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
" LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
" OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
" SOFTWARE.

" Improve diff behavior
" ---
"
" Behaviors:
" - Update diff comparison once leaving insert mode
"
" Commands:
" - DiffOrig: Show diff of unsaved changes

if exists('g:loaded_difftools')
	finish
endif
let g:loaded_difftools = 1

augroup plugin_difftools
	autocmd!
	autocmd InsertLeave * if &l:diff | diffupdate | endif
	autocmd BufWinLeave __diff call s:close_diff()
augroup END

function! s:open_diff()
	" Open diff window and start comparison
	let filetype=&ft
	let l:bnr = bufnr('%')
	call setwinvar(winnr(), 'diff_origin', l:bnr)
	vertical new __diff
	let l:diff_bnr = bufnr('%')
	nnoremap <buffer><silent> q :quit<CR>
	exec 'setlocal buftype=nofile bufhidden=wipe filetype='.filetype
	r ++edit #
	0d_
	diffthis
	setlocal readonly
	wincmd p
	let b:diff_bnr = l:diff_bnr
	nnoremap <buffer><silent> q :execute bufwinnr(b:diff_bnr) . 'q'<CR>
	diffthis
endfunction

function! s:close_diff()
	" Close diff window, switch to original window and disable diff
	" Credits: https://github.com/chemzqm/vim-easygit
	let wnr = +bufwinnr(+expand('<abuf>'))
	let val = getwinvar(wnr, 'diff_origin')
	if ! len(val) | return | endif
	for i in range(1, winnr('$'))
		if i == wnr | continue | endif
		if len(getwinvar(i, 'diff_origin'))
			return
		endif
	endfor
	let wnr = bufwinnr(val)
	if wnr > 0
		execute wnr . 'wincmd w'
		diffoff
	endif
endfunction

" Display diff of unsaved changes
command! -nargs=0 DiffOrig call s:open_diff()

" vim: set ts=2 sw=2 tw=80 noet :

