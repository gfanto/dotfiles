if exists('g:loaded_lsp_preview_definition')
	finish
endif
let g:loaded_lsp_preview_definition = 1

lua <<EOF
  local function preview_location_callback(err, result, _, _)
    if err ~= nil then
      vim.notify("ERROR: " .. tostring(err), vim.log.levels.WARN)
      return
    end

    if result == nil or vim.tbl_isempty(result) then
      vim.notify("ERROR: No location found", vim.log.levels.WARN)
      return nil
    end
    if vim.tbl_islist(result) then
      result = result[1]
    end

    if result["range"] ~= nil and result["range"]["start"]["line"] == result["range"]["end"]["line"] then
      result["range"]["end"]["line"] = result["range"]["end"]["line"] + 64
    end
    vim.lsp.util.preview_location(result, {})
  end

  vim.lsp.buf.preview_definition = function()
    local params = vim.lsp.util.make_position_params()
    return vim.lsp.buf_request(0, 'textDocument/definition', params, preview_location_callback)
  end
EOF

nnoremap <silent> cd <cmd>lua vim.lsp.buf.preview_definition()<CR>
