local blink = require("blink.cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")

require("luasnip.loaders.from_vscode").lazy_load()

blink.setup({
  fuzzy = {
    implementation = "lua",
  },

  appearance = {
    use_nvim_cmp_as_default = false,
  },

  keymap = {
    preset = "default",

    ["<C-n>"] = { "select_next", "fallback" },
    ["<C-p>"] = { "select_prev", "fallback" },
    ["<CR>"] = { "accept", "fallback" },

    ["<C-Space>"] = { "show" },
    ["<C-e>"] = { "hide" },
  },

  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },

  snippets = {
    expand = function(args)
      luasnip.lsp_expand(args)
    end,
    active = function()
      return luasnip.expand_or_jumpable()
    end,
  },

  cmdline = {
    enabled = true,
    completion = {
      menu = { auto_show = true },
      list = { selection = { preselect = false, auto_insert = true } },
    },
  },

  completion = {
    list = { selection = { preselect = false, auto_insert = true } },
    trigger = { show_in_snippet = false },
    accept = {
      create_undo_point = true,
      auto_brackets = { enabled = true },
    },
    menu = {
      draw = {
        treesitter = { "lsp" },
        columns = function(ctx)
          local ret = { { "kind_icon" }, { "label", "label_description", gap = 1 } } -- default
          if ctx.mode ~= "cmdline" then
            table.insert(ret, { "kind", "source_name", gap = 1 })
          end
          return ret
        end,
        components = {
          kind_icon = {
            text = function(item)
              local kind = lspkind.symbol_map[item.kind] or ""
              return kind .. " "
            end,
          },
          label = {
            text = function(item)
              return item.label
            end,
          },
          kind = {
            text = function(item)
              return item.kind
            end,
          },
        },
      }
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 100,
    },
    ghost_text = { enabled = true },
  },

  signature = { enabled = true },
})
