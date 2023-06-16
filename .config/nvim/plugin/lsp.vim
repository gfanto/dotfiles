if exists('g:loaded_lsp')
	finish
endif
let g:loaded_lsp = 1

call sign_define('DiagnosticSignError', {'text': '>>', 'texthl': 'DiagnosticSignError'})
call sign_define('DiagnosticSignWarn', {'text': '', 'texthl': 'DiagnosticSignWarn'})
call sign_define('DiagnosticSignInfo', {'text': '>>', 'texthl': 'DiagnosticSignInfo'})
call sign_define('DiagnosticSignHint', {'text': '>>', 'texthl': 'DiagnosticSignHint'})

com Format lua vim.lsp.buf.format(nil, 5000)
com Diagnostics lua vim.lsp.diagnostic.set_loclist();vim.api.nvim_command("wincmd p")

nnoremap <silent> gd <cmd>lua if #vim.tbl_keys(vim.lsp.buf_get_clients()) > 0 then
  \ vim.lsp.buf.definition() else
  \ vim.api.nvim_command("norm! gd")
  \ end<CR>
nnoremap <silent> K  <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> [e <cmd>lua vim.diagnostic.goto_prev({ enable_popup = true })<CR>
nnoremap <silent> ]e <cmd>lua vim.diagnostic.goto_next({ enable_popup = true })<CR>

nnoremap <leader>c <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <leader>r <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <leader>w <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <leader>a <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>d <cmd>lua vim.diagnostic.open_float()<CR>

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

  local ok, lsp_status = pcall(require, "lsp-status")
  if ok then
    lsp_status.register_progress()
    lsp_status.config({
        status_symbol = "",
    })
  else
    lsp_status = {}
  end

  local ok, lsp_inlayhints = pcall(require, "lsp-inlayhints")
  if ok then
    lsp_inlayhints.setup({
      inlay_hints = {
        parameter_hints = {
          prefix = "» ",
          remove_colon_start = true,
        },
        type_hints = {
          prefix = "» ",
          remove_colon_start = true,
        },
        only_current_line = true,
      },
    })
  end

  local on_attach = function(client, bufnr)
    local ok, lsp_status = pcall(require, "lsp-status")
    if ok then
      lsp_status.on_attach(client, bufnr)
    end

    local ok, lsp_inlayhints = pcall(require, "lsp-inlayhints")
    if ok then
      lsp_inlayhints.on_attach(client, bufnr)
    end

    local ok, lsp_signature = pcall(require, "lsp_signature")
    if ok then
      lsp_signature.on_attach({
        floating_window_above_cur_line = true,
        hint_enable = false,
        handler_opts = {
          border = "none",
        },
      }, bufnr)
    end
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local ok, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
  if ok then
    capabilities = cmp_lsp.default_capabilities(capabilities)
  end

  local servers = {
    clangd = {},
    gopls = {},
    pyright = {},
    rust_analyzer = {},
    tsserver = {},
    vimls = {},
    pyright = {},
    lua_ls = {
      Lua = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
      },
    },
  }

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if ok then
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
  end
  local flags = { debounce_text_changes = 150 }

  local ok, mason = pcall(require, "mason")
  if ok then
    mason.setup()
  end

  local ok, mason_lspconfig = pcall(require, "mason-lspconfig")
  if ok then
    mason_lspconfig.setup {
      ensure_installed = vim.tbl_keys(servers),
    }

    local lspconfig = require"lspconfig"
    mason_lspconfig.setup_handlers {
      function(server_name)
        lspconfig[server_name].setup {
          capabilities = capabilities,
          on_attach = on_attach,
          settings = servers[server_name],
          flags=flags,
        }
      end,
    }
  end

  local ok, null_ls = pcall(require, "null-ls")
  if ok then
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.prettier,
        -- null_ls.builtins.diagnostics.staticcheck,
        -- null_ls.builtins.diagnostics.eslint_d,
        -- null_ls.builtins.completion.spell,
      },
    })
  end
EOF

augroup plugin_lsp
  autocmd FileType go,typescript*,javascript,rust,python,html,css,less,c,cc,cpp,h,hpp,vim,lua
    \ setlocal omnifunc=v:lua.vim.lsp.omnifunc
augroup END
