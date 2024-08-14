return function()
  vim.g.undotree_WindowLayout = 3
  vim.g.undotree_SplitWidth = 50

  vim.keymap.set('n', '<C-u>', vim.cmd.UndotreeToggle, { desc = "Toggle Undo tree" })
end

