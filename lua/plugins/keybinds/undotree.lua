return function()
  vim.keymap.set('n', '<C-u>', '<cmd>Undotree<cr>', { desc = "Toggle Undo tree" })
end
