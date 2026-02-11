return function()
  local keymap = vim.keymap.set

  keymap("n", "<c-.>", vim.lsp.buf.code_action, { desc = "Lsp Code Action" })
  keymap("v", "<c-.>", vim.lsp.buf.code_action, { desc = "Lsp Code Action" })
  keymap("n", "<Leader>a", vim.lsp.buf.code_action, { desc = "Lsp Code Action" })
  keymap("v", "<Leader>a", vim.lsp.buf.code_action, { desc = "Lsp Code Action" })
  keymap("n", "<Leader>q", vim.lsp.buf.hover, { desc = "Hover Code Action" })
  keymap("n", "<Leader>Q", vim.lsp.buf.implementation, { desc = "Lsp Implementation" })
  keymap("n", "<Leader><c-r>", vim.lsp.buf.rename, { desc = "Lsp Rename" })
  keymap("n", "<Leader>R", vim.lsp.buf.references, { desc = "Lsp References" })
end
