return function()
  vim.keymap.set("n", "<leader>l", function()
    local current = vim.diagnostic.config().virtual_lines
    vim.diagnostic.config({ virtual_lines = not current })
  end, { desc = "Toggle diagnostic virtual lines" })
end
