vim.api.nvim_set_keymap('i', '<c-t>', '<cmd>ToggleTerm<cr>', { silent = true })
vim.api.nvim_set_keymap('t', '<c-t>', '<cmd>ToggleTerm<cr>', { silent = true })
vim.api.nvim_set_keymap('n', '<c-t>', '<cmd>ToggleTerm<cr>', {})
vim.api.nvim_set_keymap('n', '<c-/>', '<cmd>gcc<cr>', {})


vim.api.nvim_set_keymap('n', 'gpd', [[<cmd>lua require('goto-preview').goto_preview_definition()]], {})
vim.api.nvim_set_keymap('n', 'gpt', [[<cmd>lua require('goto-preview').goto_preview_type_definition()]], {})
vim.api.nvim_set_keymap('n', 'gpi', [[<cmd>lua require('goto-preview').goto_preview_implementation()]], {})
vim.api.nvim_set_keymap('n', 'gP', [[<cmd>lua require('goto-preview').close_all_win()]], {})
vim.api.nvim_set_keymap('n', 'gpr', [[<cmd>lua require('goto-preview').goto_preview_references()]], {})

vim.api.nvim_set_keymap('n', '<c-s>', [[<cmd>lua vim.lsp.buf.format { async = true }<cr>]], {})
vim.api.nvim_set_keymap('n', '<c-.>', [[]], {})



vim.api.nvim_set_keymap('n', '<c-e>', '<cmd>NvimTreeToggle<cr>', { silent = true })
