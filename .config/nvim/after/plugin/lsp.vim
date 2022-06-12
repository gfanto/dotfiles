if get(g:, 'loaded_airline')
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


if get(g:, 'loaded_lspsaga')
  nnoremap <silent> K  <cmd>Lspsaga hover_doc<CR>
  nnoremap <silent> cr <cmd>Lspsaga rename<CR>
  nnoremap <silent> cd <cmd>Lspsaga preview_definition<CR>
  nnoremap <silent> [e <cmd>Lspsaga diagnostic_jump_prev<CR>
  nnoremap <silent> ]e <cmd>Lspsaga diagnostic_jump_next<CR>

  nnoremap <leader>a <cmd>Lspsaga code_action<CR>
  nnoremap <leader>d <cmd>Lspsaga show_line_diagnostics<CR>
  nnoremap <leader>h <cmd>Lspsaga signature_help<CR>

  hi! link LspSagaFinderSelection GruvboxGreenBold

  hi! link LspFloatWinBorder GruvboxBg0
  hi! link LspSagaBorderTitle GruvboxOrangeBold

  hi! link ProviderTruncateLine GruvboxBg0
  hi! link SagaShadow GruvboxBg0

  hi! link LspSagaFinderSelection GruvboxGreenBold

  hi! link DiagnosticTruncateLine GruvboxBlueBold
  hi! link DiagnosticInformation GruvboxBlueBold
  hi! link DiagnosticHint GruvboxBlue

  hi! link LspSagaDiagnosticBorder GruvboxPurple
  hi! link LspSagaDiagnosticHeader GruvboxYellowBold
  hi! link LspSagaDiagnosticTruncateLine GruvboxPurple
  hi! link LspDiagnosticsFloatingError GruvboxRed
  hi! link LspDiagnosticsFloatingWarn GruvboxYellow
  hi! link LspDiagnosticsFloatingInfor GruvboxBlue
  hi! link LspDiagnosticsFloatingHint GruvboxBlue

  hi! link LspSagaShTruncateLine GruvboxBg0
  hi! link LspSagaDocTruncateLine GruvboxBg0
  hi! link LspSagaCodeActionTitle GruvboxOrangeBold
  hi! link LspSagaCodeActionTruncateLine GruvboxBg0

  hi! link LspSagaCodeActionContent GruvboxGreenBold

  hi! link LspSagaRenamePromptPrefix GruvboxGreen

  hi! link LspSagaRenameBorder GruvboxBlue
  hi! link LspSagaHoverBorder GruvboxBlue
  hi! link LspSagaSignatureHelpBorder GruvboxGreen
  hi! link LspSagaLspFinderBorder GruvboxBlue
  hi! link LspSagaCodeActionBorder GruvboxBlue
  hi! link LspSagaAutoPreview GruvboxYellow
  hi! link LspSagaDefPreviewBorder GruvboxBlue
endif
