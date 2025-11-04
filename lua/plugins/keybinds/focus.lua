return function()
  vim.keymap.set("n", "<c-h>", ":FocusSplitLeft<CR>", { silent = true, desc = "Focus Left" })
  vim.keymap.set("n", "<c-j>", ":FocusSplitDown<CR>", { silent = true, desc = "Focus Down" })
  vim.keymap.set("n", "<c-k>", ":FocusSplitUp<CR>", { silent = true, desc = "Focus Up" })
  vim.keymap.set("n", "<c-l>", ":FocusSplitRight<CR>", { silent = true, desc = "Focus Right" })

  vim.keymap.set("n", "<leader>wp", ":FocusSplitNicely<CR>", { silent = true, desc = "Split Nicely" })
  vim.keymap.set("n", "<leader>wo", ":FocusMaxOrEqual<CR>", { silent = true, desc = "Focus Max/Equal" })
end
