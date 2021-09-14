if exists('g:loaded_lsp')
	finish
endif
let g:loaded_lsp = 1

call sign_define('LspDiagnosticsSignError', {'text' : '>>', 'texthl' : 'LspDiagnosticsVirtualTextError'})
call sign_define('LspDiagnosticsSignWarning', {'text' : '', 'texthl' : 'LspDiagnosticsVirtualTextWarning'})
call sign_define('LspDiagnosticsSignInformation', {'text' : '>>', 'texthl' : 'LspDiagnosticsVirtualTextInformation'})
call sign_define('LspDiagnosticsSignHint', {'text' : '>>', 'texthl' : 'LspDiagnosticsVirtualTextHint'})

com Format lua vim.lsp.buf.formatting_sync(nil, 5000)
com Diagnostics lua vim.lsp.diagnostic.set_loclist();vim.api.nvim_command("wincmd p")

nmap <silent> gd <cmd>lua if #vim.lsp.buf_get_clients() > 0 then
  \ vim.lsp.buf.definition() else
  \ vim.api.nvim_command("norm! gd")
  \ end<CR>
nmap <silent> K  <cmd>lua vim.lsp.buf.hover()<CR>
nmap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nmap <silent> cr <cmd>lua vim.lsp.buf.rename()<CR>
nmap <silent> [e <cmd>lua vim.lsp.diagnostic.goto_prev({ enable_popup = false })<CR>
nmap <silent> ]e <cmd>lua vim.lsp.diagnostic.goto_next({ enable_popup = false })<CR>

nnoremap <leader>r <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <leader>w <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <leader>a <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>d <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>

lua << EOF
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      underline = false,
      virtual_text = {
        spacing = 4,
        -- prefix = "»",
      },
    }
  )

  local ok, fzf_lsp = pcall(require, "fzf_lsp")
  if ok then
    fzf_lsp.setup()
  end

  -- local ok, saga = pcall(require, "lspsaga")
  -- if ok then
  --   saga.init_lsp_saga()
  -- end

  local ok, lsp_status = pcall(require, "lsp-status")
  if ok then
    lsp_status.register_progress()
    lsp_status.config({
        status_symbol = "",
    })
  else
    lsp_status = {}
  end

  local on_attach = function(client, bufnr)
    local ok, lsp_status = pcall(require, "lsp-status")
    if ok then
      lsp_status.on_attach(client, bufnr)
    end

    local ok, lsp_signature = pcall(require, "lsp_signature")
    if ok then
      lsp_signature.on_attach({
        handler_opts = {
          border = "none"
        },
      }, bufnr)
    end
  end

  local lsp = require"lspconfig"
  lsp.tsserver.setup{ on_attach = on_attach }
  lsp.html.setup{ on_attach = on_attach }
  lsp.cssls.setup{ on_attach = on_attach }
  lsp.gopls.setup{ on_attach = on_attach }
  lsp.clangd.setup{ on_attach = on_attach }
  lsp.vimls.setup{ on_attach = on_attach }
  lsp.sumneko_lua.setup{ on_attach = on_attach, cmd = { "lua-language-server" } }
  lsp.pyright.setup{
    on_attach = on_attach,
    root_dir = function(fname)
      return vim.fn.getcwd()
    end,
    settings = {
      python = {
        formatting = { provider = "black" },
        linting = { enabled = true, mypyEnabled = true, },
        analysis = {
          autoImportCompletions = true,
          autoSearchPaths = true,
          diagnosticMode = "openFilesOnly",
          typeCheckingMode = "basic",
          useLibraryCodeForTypes = true,
        }
      }
    }
  }
  lsp.rust_analyzer.setup{
    on_attach = on_attach,
    capabilities = vim.tbl_extend("keep", lsp.rust_analyzer.capabilities or {}, lsp_status.capabilities or {}),
  }
EOF

fun! s:lsp_extensions()
  lua local ok, ext = pcall(require, "lsp_extensions"); if ok then ext.inlay_hints{
  \ aligned = flase,
  \ only_current_line = true,
  \ prefix = '     » ',
  \ highlight = 'NonText'
  \ }
  \ end
endfun

augroup plugin_lsp
  autocmd CursorHold,CursorHoldI *.rs call s:lsp_extensions()
  autocmd FileType go,typescript*,javascript,rust,python,html,css,less,c,cc,cpp,h,hpp,vim,lua
    \ setlocal omnifunc=v:lua.vim.lsp.omnifunc
augroup END
