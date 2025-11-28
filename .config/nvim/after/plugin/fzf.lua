local fzf = require("fzf-lua")
fzf.setup({
  winopts = {
    backdrop = 100,
    border = "single",
    preview = {
      border = "single",
    },
  },

  lsp = {
    winopts = {
      width   = 1.00,
      row     = 1.00,
      height  = 0.40,
      preview = {
        layout     = "horizontal",
        horizontal = "right:40%",
      },
    },

    code_actions = {
      winopts = {
        width   = 1.00,
        row     = 1.00,
        height  = 0.40,
        preview = {
          layout     = "horizontal",
          horizontal = "right:40%",
        },
      },
    },
  },

  quickfix = {
    winopts = {
      width   = 1.00,
      row     = 1.00,
      height  = 0.40,
      preview = {
        layout     = "horizontal",
        horizontal = "right:40%",
      },
    },
  },
})

local map = vim.keymap.set
map("n", "<C-p>", function()
  if vim.fn.isdirectory(".git") == 1 then
    fzf.git_files()
  else
    fzf.files()
  end
end, { silent = true })
map("n", "<leader>f", fzf.blines, { silent = true })
map("n", "<leader>g", fzf.live_grep, { silent = true })
map("n", "<leader>G", function()
  fzf.grep_cword({ actions = { ["default"] = fzf.actions.file_quickfix } })
end)
map("n", "<leader>b", fzf.buffers, { silent = true })
map("n", "<leader>p", fzf.files, { silent = true })
map("n", "<leader>Q", function()
  if #vim.fn.getqflist() > 0 then
    vim.cmd("cclose")
    vim.cmd("FzfLua quickfix")
  elseif #vim.fn.getloclist(0) > 0 then
    vim.cmd("lclose")
    vim.cmd("FzfLua loclist")
  end
end, { silent = true })
