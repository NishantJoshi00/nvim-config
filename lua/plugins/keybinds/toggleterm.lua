return function()
  local keymap = vim.keymap.set

  keymap("n", "<leader>tm", "<cmd>ToggleTerm<cr>", { desc = "Toggle Main Terminal" })
  keymap("n", "<leader>ta", "<cmd>ToggleTermToggleAll<cr>", { desc = "Toggle All Terminals" })
  keymap("i", "<c-t>", "<cmd>ToggleTerm<cr>", { silent = true, desc = "toggle terminal" })
  keymap("t", "<c-t>", "<cmd>ToggleTerm<cr>", { silent = true, desc = "toggle terminal" })
  keymap("n", "<c-t>", "<cmd>ToggleTerm<cr>", { desc = "toggle terminal" })
end
