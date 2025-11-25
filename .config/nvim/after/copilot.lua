if not vim.g.loded_copilot then
    -- this plugin is needed only if there is copilot
    return
end

vim.g.copilot_no_tab_map = true

vim.keymap.set("i", "<Tab>", function()
  if vim.fn['copilot#Visible']() == 1 then
    return vim.fn['copilot#Accept']("")
  else
    return "<Tab>"
  end
end, { expr = true, silent = true })

