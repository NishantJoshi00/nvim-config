return function()
  -- Copilot mappings
  vim.keymap.set("n", "<leader>nce", "<cmd>Copilot enable<cr>", { desc = "Enable Copilot" })
  vim.keymap.set("n", "<leader>ncd", "<cmd>Copilot disable<cr>", { desc = "Disable Copilot" })
  vim.keymap.set("n", "<leader>ncs", "<cmd>Copilot status<cr>", { desc = "Copilot Status" })
  vim.keymap.set("n", "<leader>ncp", "<cmd>Copilot panel<cr>", { desc = "Copilot Panel" })
  vim.keymap.set("n", "<leader>ncr", "<cmd>Copilot restart<cr>", { desc = "Copilot Restart" })

  vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })
end
