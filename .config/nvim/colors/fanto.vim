" set background=dark

hi clear
if exists("syntax_on")
    syntax reset
endif

let colors_name = "fanto"

"hi! Normal guifg=#ebdbb2 guibg=#1d2021 gui=none

" Generic statement
hi! Statement guifg=#fb4934
" if, then, else, endif, swicth, etc.
hi! Conditional guifg=#fb4934
" for, do, while, etc.
hi! Repeat guifg=#fb4934
" case, default, etc.
hi! Label guifg=#fb4934
" try, catch, throw
hi! Exception guifg=#fb4934
" sizeof, +, *, etc.
hi! Operator guifg=#ebdbb2
" Any other keyword
hi! Keyword guifg=#fb4934

" Variable name
hi! Identifier guifg=#85a598
" Function name
hi! Function guifg=#b8bb26 gui=bold

" Generic preprocessor
hi! PreProc guifg=#8ec07c
" Preprocessor #include
hi! Include guifg=#8ec07c
" Preprocessor #define
hi! Define guifg=#8ec07c
" Same as Define
hi! Macro guifg=#8ec07c
" Preprocessor #if, #else, #endif, etc.
hi! PreCondit guifg=#8ec07c

" Generic constant
hi! Constant guifg=#d3869b
" Character constant: 'c', '/n'
hi! Character guifg=#d3869b
" String constant
hi! String guifg=#b8bb26
" Boolean constant: TRUE, false
hi! Boolean guifg=#d3869b
" Number constant: 234, 0xff
hi! Number guifg=#d3869b
" Floating point constant: 2.3e10
hi! Float guifg=#d3869b

" Generic type
hi! Type guifg=#fabd2f
" static, register, volatile, etc
hi! StorageClass guifg=#fe8019
" struct, union, enum, etc.
hi! Structure guifg=#8ec07c
" typedef
hi! Typedef guifg=#fabd2f

hi! Directory guifg=#b8bb26 gui=bold
hi! Title guifg=#b8bb26 gui=bold

" Visual selected text
hi! Visual guibg=#665c54
hi! Search guifg=#fabd2f guibg=#1d2021 gui=reverse
hi! IncSearch guifg=#fe8019 guibg=#1d2021 gui=reverse

" Code comments
hi! Comment guifg=#7c6f64 gui=italic
hi! Todo guifg=#ebdbb2 guibg=#1d2021 gui=none
hi! Error guifg=#cc241d guibg=#1d2021 gui=bold,inverse

hi! CursorLineNr guifg=#fabd2f
" Line number for :number and :# commands
hi! LineNr guifg=#a89984
" Column where signs are displayed
hi! SignColumn guifg=#a89984 guibg=#3c3836
" Line used for closed folds
hi! Folded guifg=#a89984 guibg=#3c3836 gui=italic
" Column where folds are displayed
hi! FoldColumn guifg=#a89984 guibg=#3c3836

hi! StatusLine guifg=#3c3836 guibg=#ae9984 gui=inverse
hi! StatusLineNC guifg=#3c3836 guibg=#ae9984 gui=inverse

" The column separating vertically split windows
hi! VertSplit guifg=#665c54 gui=none
hi! QuickFixLine guifg=#1d2021 guibg=#fabd2f gui=none

" Current match in wildmenu completion
hi! WildMenu guifg=#83a598 guibg=#504945 gui=bold

hi! MoreMsg guifg=#fabd2f gui=bold
" Current mode message: -- INSERT --
hi! ModeMsg guifg=#fabd2f gui=bold
" 'Press enter' prompt and yes/no questions
hi! Question guifg=#fe8019 gui=bold
" Warning messages
hi! WarningMsg guifg=#fb4934 gui=bold
hi! ErrorMsg guifg=#1d2021 guibg=#fb4934 gui=bold

hi! NonText guifg=#504945
hi! SpecialKey guifg=#504945

" Popup menu: normal item
hi! Pmenu guifg=#ebdbb2 guibg=#504945
" Popup menu: selected item
hi! PmenuSel guifg=#504945 guibg=#83a598 gui=bold
" Popup menu: scrollbar
hi! PmenuSbar guifg=none guibg=#504945
" Popup menu: scrollbar thumb
hi! PmenuThumb guifg=none guibg=#7c6f64

" Tab pages line filler
hi! TabLineFill guifg=#7c6f64 guibg=#3c3836 gui=none
" Active tab page label
hi! TabLineSel guifg=#b8bb26 guibg=#3c3836 gui=none
" Not active tab page label
hi! link TabLine TabLineFill

" Diffs
hi! DiffDelete guifg=#fb4934 guibg=#1d2021 gui=inverse
hi! DiffAdd guifg=#b8bb26 guibg=#1d2021 gui=inverse
hi! DiffChange guifg=#83a598 guibg=#1d2021 gui=inverse
hi! DiffText guifg=#fabd2f guibg=#1d2021 gui=inverse
