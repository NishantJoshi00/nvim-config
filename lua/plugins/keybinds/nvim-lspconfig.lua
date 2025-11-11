-- Module-scoped state instead of global
local lsp_hidden = false

return function()
  local builtin = require('telescope.builtin')

  vim.keymap.set("n", "<leader>K", vim.lsp.buf.implementation,
    { desc = "View implementations" })
  vim.keymap.set("n", "<leader>D", function()
    builtin.lsp_definitions({ initial_mode = "normal" })
  end, { desc = "Go to Definition" })

  vim.keymap.set("n", "<c-s>", function() vim.lsp.buf.format { async = true } end, { desc = "format file" })

  vim.keymap.set("n", "<leader>re", "<cmd>RustLsp expandMacro<cr>", { desc = "Expand Macro" })

  vim.keymap.set("n", "<leader>hl", function()
    if lsp_hidden then
      vim.diagnostic.config({ virtual_text = true })
      lsp_hidden = false
    else
      vim.diagnostic.config({ virtual_text = false })
      lsp_hidden = true
    end
  end, { desc = "Toggle Hiding Lsp Hints" })
end
