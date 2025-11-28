local vim = vim

-------------------------------------------------
-- CAPABILITIES
-------------------------------------------------
local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if ok_cmp then
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

-------------------------------------------------
-- GLOBAL COMMANDS
-------------------------------------------------
pcall(vim.api.nvim_del_user_command, "Format")
pcall(vim.api.nvim_del_user_command, "Diagnostics")

vim.api.nvim_create_user_command("Format", function()
  vim.lsp.buf.format({ timeout_ms = 5000 })
end, {})

vim.api.nvim_create_user_command("Diagnostics", function()
  vim.diagnostic.setloclist()
  vim.cmd("wincmd p")
end, {})

vim.api.nvim_create_user_command("DiagnosticsAll", function()
  vim.diagnostic.setqflist()
  vim.cmd("wincmd p")
end, {})

-------------------------------------------------
-- ON_ATTACH (YOUR KEYMAPS)
-------------------------------------------------

local function on_attach(client, bufnr)
  local function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, {
      buffer = bufnr,
      silent = true,
      desc = desc,
    })
  end

  map("n", "gd", function()
    require("fzf-lua.providers.lsp").definitions({jump1 = true})
  end, "Go to definition")
  map("n", "K", vim.lsp.buf.hover, "Hover")
  map("n", "gr", function()
    require("fzf-lua.providers.lsp").references()
  end, "References")
  map("n", "<leader>c", vim.lsp.buf.rename, "Rename")
  map("n", "<leader>a", function()
    require("fzf-lua.providers.lsp").code_actions()
  end, "Code action")
  map("n", "<leader>d", vim.diagnostic.open_float, "Diagnostic float")
  map("n", "<leader>r", function()
    require("fzf-lua.providers.lsp").document_symbols()
  end, "Document symbols")
  map("n", "<leader>w", function()
    require("fzf-lua.providers.lsp").live_workspace_symbols()
  end, "Workspace symbols")
  map("n", "<leader>D", function() vim.cmd("DiagnosticsAll") end, "Workspace diagnostic")

  -- performance improvements
  if client.name == "ts_ls" or client.name == "pyright" then
    client.server_capabilities.semanticTokensProvider = nil
  end

  client.flags = {
    debounce_text_changes = 150,
    allow_incremental_sync = true,
  }
end

-------------------------------------------------
-- MASON (INSTALL ONLY)
-------------------------------------------------
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "ts_ls",
    "pyright",
    "lua_ls",
    "rust_analyzer",
    "gopls",
    "clangd",
    "html",
    "cssls",
    "sqls",
  },
})

-------------------------------------------------
-- LSPCONFIG (STABLE API)
-------------------------------------------------
local servers = {
  ts_ls = {},
  pyright = {},
  html = {},
  cssls = {},
  sqls = {},
  clangd = {
    cmd = { "clangd", "--background-index", "--offset-encoding=utf-16" },
  },
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" } },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
      },
    },
  },
  gopls = {
    settings = {
      gopls = {
        analyses = { unusedparams = true },
        staticcheck = true,
      },
    },
  },
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        cargo = { allFeatures = true },
        checkOnSave = { command = "clippy" },
      },
    },
  },
}

for server, opts in pairs(servers) do
  opts.on_attach = on_attach
  opts.capabilities = capabilities
  vim.lsp.config(server, opts)
end

-------------------------------------------------
-- NONE-LS (FORMATTERS)
-------------------------------------------------
local null = require("null-ls")

local augroup = vim.api.nvim_create_augroup("LspFormat", {})

local function lsp_format_on_save(client, bufnr)
  if not client.server_capabilities.documentFormattingProvider then
    return
  end

  vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup,
    buffer = bufnr,
    callback = function()
      vim.lsp.buf.format({
        bufnr = bufnr,
        async = false,
      })
    end,
  })
end

null.setup({
  sources = {
    null.builtins.formatting.black.with({ extra_args = { "--fast" } }),
    null.builtins.formatting.prettier,
    null.builtins.formatting.gofumpt,
  },

  on_attach = function(client, bufnr)
    lsp_format_on_save(client, bufnr)
  end,
})

-------------------------------------------------
-- Diagnostic stup
-------------------------------------------------

vim.diagnostic.config({
  underline = true,
  update_in_insert = false,
  virtual_text = {
    spacing = 4,
    source = "if_many",
    severity = {
      min = vim.diagnostic.severity.HINT,
    },
    -- format = function(diagnostic)
    -- if diagnostic.severity == vim.diagnostic.severity.ERROR then
    --   return string.format('E: %s', diagnostic.message)
    -- end
    -- return ("%s"):format(diagnostic.message)
    -- end,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "", -- index:0
      [vim.diagnostic.severity.WARN]  = "", -- index:1
      [vim.diagnostic.severity.INFO]  = "", -- index:2
      [vim.diagnostic.severity.HINT]  = "󰌵", -- index:3
    },
  },
  severity_sort = true,
  float = {
    show_header = false,
    source = "if_many",
    border = "single",
  },
})
