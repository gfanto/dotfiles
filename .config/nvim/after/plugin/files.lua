-- oil

require("oil").setup({
  default_file_explorer = false,
  columns = {
    "icon",
    "permissions",
    "size",
    "mtime",
  },
  delete_to_trash = true,
})

vim.keymap.set("n", "<leader>e", function()
  require("oil").open(vim.fn.getcwd())
end, { desc = "Open project root in oil" })
vim.keymap.set("n", "<leader>E", function()
  require("oil").open()
end)
vim.keymap.set("n", "-", "<Nop>")

-- harpoon

local harpoon = require("harpoon").setup()

local map = vim.keymap.set
map("n", "<leader>h", function()
  harpoon:list():add()
end, { desc = "Harpoon add file" })
map("n", "<leader>H", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon menu" })
for i = 1, 9 do
  map("n", "<leader>" .. i, function()
    harpoon:list():select(i)
  end, { desc = "Harpoon go to file " .. i })
end
