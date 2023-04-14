vim.api.nvim_set_keymap('i', '<c-t>', '<cmd>ToggleTerm<cr>', { silent = true })
vim.api.nvim_set_keymap('t', '<c-t>', '<cmd>ToggleTerm<cr>', { silent = true })
vim.api.nvim_set_keymap('n', '<c-t>', '<cmd>ToggleTerm<cr>', {})
vim.api.nvim_set_keymap('n', '<c-/>', '<cmd>gcc<cr>', {})


vim.api.nvim_set_keymap('n', 'gpd', [[<cmd>lua require('goto-preview').goto_preview_definition()<cr>]], {})
vim.api.nvim_set_keymap('n', 'gpt', [[<cmd>lua require('goto-preview').goto_preview_type_definition()<cr>]], {})
vim.api.nvim_set_keymap('n', 'gpi', [[<cmd>lua require('goto-preview').goto_preview_implementation()<cr>]], {})
vim.api.nvim_set_keymap('n', 'gP', [[<cmd>lua require('goto-preview').close_all_win()<cr>]], {})
vim.api.nvim_set_keymap('n', 'gpr', [[<cmd>lua require('goto-preview').goto_preview_references()<cr>]], {})

vim.api.nvim_set_keymap('n', '<c-s>', [[<cmd>lua vim.lsp.buf.format { async = true }<cr>]], {})


vim.api.nvim_set_keymap('n', '<c-e>', '<cmd>NvimTreeToggle<cr>', { silent = true })


-- local rename_lsp = function()
--   vim.ui.input({ prompt = "rename with: " }, function(input)
--     if not input then
--     vim.lsp.buf.rename(input)
--     end
--   end
--   )
-- end
