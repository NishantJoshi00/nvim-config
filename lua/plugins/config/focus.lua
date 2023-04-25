return function()
  local focus = require("focus")
  focus.setup()

  vim.api.nvim_set_keymap('n', '<c-h>', ':FocusSplitLeft<CR>', { silent = true })
  vim.api.nvim_set_keymap('n', '<c-j>', ':FocusSplitDown<CR>', { silent = true })
  vim.api.nvim_set_keymap('n', '<c-k>', ':FocusSplitUp<CR>', { silent = true })
  vim.api.nvim_set_keymap('n', '<c-l>', ':FocusSplitRight<CR>', { silent = true })

  vim.api.nvim_set_keymap('n', '<leader>wp', ':FocusSplitNicely<CR>', { silent = true })
  vim.api.nvim_set_keymap('n', '<leader>wo', ':FocusMaxOrEqual<CR>', { silent = true })
end
