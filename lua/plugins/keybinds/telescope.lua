return function()
  local telescope_theme = require("functions").telescope_theme
  local builtin = require("telescope.builtin")
  local keymap = vim.keymap.set

  keymap("n", "<leader>ff", function() builtin.find_files(telescope_theme({})) end, { desc = "Find Files" })
  keymap("n", "<leader>fg", function() builtin.live_grep(telescope_theme({})) end, { desc = "Live Grep" })
  keymap("n", "<leader>fb", function() builtin.buffers(telescope_theme({})) end, { desc = "Buffers" })
  keymap("n", "<leader>fh", function() builtin.help_tags(telescope_theme({})) end, { desc = "Help Tags" })
  keymap("n", "<leader>fa", function() builtin.lsp_dynamic_workspace_symbols(telescope_theme({})) end, { desc = "LSP Search" })
  keymap("n", "<leader>fB", function() builtin.builtin(telescope_theme({})) end, { desc = "Search Builtin" })
  keymap("n", "<leader>fs", function() builtin.spell_suggest(telescope_theme({})) end, { desc = "Suggest Spellings" })
end
