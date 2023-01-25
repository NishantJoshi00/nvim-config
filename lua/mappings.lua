vim.o.mapleader = " "

local wk = require("which-key")

wk.register({
  -- Telescope mappings
  ["<leader>ff"] = { "<cmd>lua require('telescope.builtin').find_files()<cr>", "Find Files" },
  ["<leader>fg"] = { "<cmd>lua require('telescope.builtin').live_grep()<cr>", "Live Grep" },
  ["<leader>fb"] = { "<cmd>lua require('telescope.builtin').buffers()<cr>", "Buffers" },
  ["<leader>fh"] = { "<cmd>lua require('telescope.builtin').help_tags()<cr>", "Help Tags" },


  -- NERDTree mappings
  ["<leader>n"] = { "<cmd>NERDTreeFocus<cr>", "Focus Nerd Tree" },
  ["<leader>e"] = { "<cmd>NERDTreeToggle<cr>", "Toggle Nerd Tree" },

  -- toggleterm
  ["<leader>t"] = {
    name = "+terminal",
    m = { "<cmd>ToggleTerm<cr>", "Toggle Main Terminal" },
    a = { "<cmd>ToggleTermToggleAll<cr>", "Toggle All Terminals" },
  },

  -- aerial
  ["<leader>a"] = {
    name = "Aerial Binds",
    t = { "<cmd>AerialToggle Left<cr>", "Aerial Toggle" },
    T = { "<cmd>AerialToggleAll Left<cr>", "Aerial Toggle All" },
    C = { "<cmd>AerialCloseAll", "Aerial CloseAll" },
  },

  -- Personal
  ["<leader>m"] = { "@", "Start Macro" },

  -- Lsp
  ["<leader>I"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", "View function signature" },
  ["<leader>K"] = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "View implementations" },
  ["<leader>D"] = { "<cmd>lua vim.lsp.buf.definition()<cr>", "View Definition" }


})


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
