return function()
  vim.keymap.set("n", "<leader>gb", function()
    vim.cmd([[Gitsigns blame_line]])
  end, { desc = "Git blame" })
end
