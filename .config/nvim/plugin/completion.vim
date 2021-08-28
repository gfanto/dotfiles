if exists('g:loaded_completion')
	finish
endif
let g:loaded_completion = 1

lua << EOF
local ok, cmp = pcall(require, "cmp")
if ok then
  cmp.setup {
    mapping = {
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      }),
  	-- ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' })
  	-- ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' })
      ["<Tab>"] = function(fallback)
        if vim.fn.pumvisible() == 1 then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
        else
          fallback()
        end
      end,
      ["<S-Tab>"] = function(fallback)
        if vim.fn.pumvisible() == 1 then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
        else
          fallback()
        end
      end,
    },
    sources = {
      { name = "nvim_lsp" },
      { name = "path" },
      { name = "buffer" },
      { name = "calc" },
      { name = "emoji" },
    },
    formatting = {
      format = function(entry, vim_item)
        local ok, lspkind = pcall(require, "lspkind")
  	  if ok then
          vim_item.kind = lspkind.presets.default[vim_item.kind]
            .. " "
            .. vim_item.kind
  	  end
        vim_item.menu = ({
          buffer = "[Buffer]",
          nvim_lsp = "[LSP]",
          luasnip = "[LuaSnip]",
          nvim_lua = "[Lua]",
          latex_symbols = "[Latex]",
        })[entry.source.name]
        return vim_item
      end,
    },
  }
end
EOF
