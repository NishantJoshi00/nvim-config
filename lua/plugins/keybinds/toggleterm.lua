return function()
  vim.keymap.set("n", "<leader>tm", "<cmd>ToggleTerm<cr>", { desc = "Toggle Main Terminal" })
  vim.keymap.set("n", "<leader>ta", "<cmd>ToggleTermToggleAll<cr>", { desc = "Toggle All Terminals" })

  vim.keymap.set("i", "<c-t>", "<cmd>ToggleTerm<cr>", { silent = true, desc = "toggle terminal" })
  vim.keymap.set("t", "<c-t>", "<cmd>ToggleTerm<cr>", { silent = true, desc = "toggle terminal" })
  vim.keymap.set("n", "<c-t>", "<cmd>ToggleTerm<cr>", { desc = "toggle terminal" })
end
