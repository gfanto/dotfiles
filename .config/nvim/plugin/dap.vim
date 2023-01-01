if exists('g:loaded_dap')
	finish
endif
let g:loaded_dap = 1

lua << EOF
  local ok, dap_virtual_text = pcall(require, "nvim-dap-virtual-text")
  if ok then
    dap_virtual_text.setup()
  end

  local ok, dapui = pcall(require, "dapui")
  if ok then
    dapui.setup()
    vim.api.nvim_create_user_command("DapUi", function() dapui.toggle() end, {})
  end
EOF
