return function()
  vim.api.nvim_set_keymap(
    "n",
    "<c-.>",
    "<cmd>lua vim.lsp.buf.code_action()<cr>",
    { desc = "Lsp Code Action" }
  )
  vim.api.nvim_set_keymap(
    "v",
    "<c-.>",
    "<cmd>lua vim.lsp.buf.code_action()<cr>",
    { desc = "Lsp Code Action" }
  )
  lua_keymap("n", "<Leader>a", vim.lsp.buf.code_action, { desc = "Lsp Code Action" })
  lua_keymap("v", "<Leader>a", vim.lsp.buf.code_action, { desc = "Lsp Code Action" })
  lua_keymap("n", "<Leader>q", vim.lsp.buf.hover, { desc = "Hover Code Action" })
  lua_keymap("n", "<Leader>Q", vim.lsp.buf.implementation, { desc = "Lsp Implementation" })
  lua_keymap("n", "<Leader><c-r>", vim.lsp.buf.rename, { desc = "Lsp Rename" })
  lua_keymap("n", "<Leader>R", vim.lsp.buf.references, { desc = "Lsp References" })
end
