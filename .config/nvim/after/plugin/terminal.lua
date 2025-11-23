require("toggleterm").setup({
  shell = "fish",
  direction = "float"
})
vim.keymap.set("n", "<leader>t", function()
    require("toggleterm.terminal").Terminal:new():toggle()
end, { desc = "Toggle floating terminal" })
vim.keymap.set("n", "<leader>q", function()
  vim.cmd("ToggleTerm")
end, { desc = "Toggle floating terminal" })
vim.keymap.set("n", "<Right>", function()
  vim.cmd("ToggleTermToggleAll")
  vim.cmd("1ToggleTerm")
end)
vim.keymap.set("n", "<Left>", function()
  vim.cmd("ToggleTermToggleAll")
  vim.cmd("2ToggleTerm")
end)

local function get_terminals()
  local terms = require("toggleterm.terminal").get_all()
  -- convert map → list ordinata per id
  local list = {}
  for id, term in pairs(terms) do
    table.insert(list, { id = id, term = term })
  end
  table.sort(list, function(a, b) return a.id < b.id end)
  return list
end
local function rotate_terminals_next()
  local terms = get_terminals()
  if #terms == 0 then
    vim.notify("No terminals open", vim.log.levels.INFO)
    return
  end

  -- Find the currently visible terminal
  local current_id = nil
  for _, t in ipairs(terms) do
    if t.term:is_open() and t.term.window == vim.api.nvim_get_current_win() then
      current_id = t.id
      break
    end
  end

  -- Decide next terminal
  local next_index = 1
  if current_id then
    for i, t in ipairs(terms) do
      if t.id == current_id then
        next_index = (i % #terms) + 1
        break
      end
    end
  end

  -- Hide all terminals, then show the next
  for _, t in ipairs(terms) do
    t.term:close()
  end

  terms[next_index].term.dir = "float"
  terms[next_index].term:open()
end
local function rotate_terminals_prev()
  local terms = get_terminals()
  if #terms == 0 then
    vim.notify("No terminals open", vim.log.levels.INFO)
    return
  end

  -- Find the currently visible terminal
  local current_id = nil
  for _, t in ipairs(terms) do
    if t.term:is_open() and t.term.window == vim.api.nvim_get_current_win() then
      current_id = t.id
      break
    end
  end

  -- Decide previous terminal
  local prev_index = #terms
  if current_id then
    for i, t in ipairs(terms) do
      if t.id == current_id then
        prev_index = ((i - 2 + #terms) % #terms) + 1
        break
      end
    end
  end

  -- Hide all terminals, then show the previous one
  for _, t in ipairs(terms) do
    t.term:close()
  end

  terms[prev_index].term.dir = "float"
  terms[prev_index].term:open()
end

vim.keymap.set("n", "<Right>", rotate_terminals_next, { desc = "Next terminal" })
vim.keymap.set("n", "<Left>", rotate_terminals_prev,  { desc = "Prev terminal" })
