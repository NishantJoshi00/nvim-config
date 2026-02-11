return function()
  local keymap = vim.keymap.set
  local opts = { silent = true }

  keymap("n", "<c-h>", "<cmd>FocusSplitLeft<CR>", vim.tbl_extend("force", opts, { desc = "Focus Left" }))
  keymap("n", "<c-j>", "<cmd>FocusSplitDown<CR>", vim.tbl_extend("force", opts, { desc = "Focus Down" }))
  keymap("n", "<c-k>", "<cmd>FocusSplitUp<CR>", vim.tbl_extend("force", opts, { desc = "Focus Up" }))
  keymap("n", "<c-l>", "<cmd>FocusSplitRight<CR>", vim.tbl_extend("force", opts, { desc = "Focus Right" }))

  keymap("n", "<leader>wp", "<cmd>FocusSplitNicely<CR>", vim.tbl_extend("force", opts, { desc = "Split Nicely" }))
  keymap("n", "<leader>wo", "<cmd>FocusMaxOrEqual<CR>", vim.tbl_extend("force", opts, { desc = "Focus Max/Equal" }))
end
