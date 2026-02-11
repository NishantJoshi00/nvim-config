local lsp_hidden = false

return function()
  local builtin = require("telescope.builtin")
  local keymap = vim.keymap.set

  keymap("n", "<leader>K", vim.lsp.buf.implementation, { desc = "View implementations" })
  keymap("n", "<leader>D", function()
    builtin.lsp_definitions({ initial_mode = "normal" })
  end, { desc = "Go to Definition" })

  keymap("n", "<c-s>", function() vim.lsp.buf.format({ async = true }) end, { desc = "format file" })
  keymap("n", "<leader>re", "<cmd>RustLsp expandMacro<cr>", { desc = "Expand Macro" })

  keymap("n", "<leader>hl", function()
    lsp_hidden = not lsp_hidden
    vim.diagnostic.config({ virtual_text = not lsp_hidden })
  end, { desc = "Toggle Hiding Lsp Hints" })
end
