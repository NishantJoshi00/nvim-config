vim.o.mapleader = " "

local wk = require("which-key")

wk.register({
  -- Telescope mappings
  ["<leader>ff"] = { "<cmd>lua require('telescope.builtin').find_files()<cr>", "Find Files" },
  ["<leader>fg"] = { "<cmd>lua require('telescope.builtin').live_grep()<cr>", "Live Grep" },
  ["<leader>fb"] = { "<cmd>lua require('telescope.builtin').buffers()<cr>", "Buffers" },
  ["<leader>fh"] = { "<cmd>lua require('telescope.builtin').help_tags()<cr>", "Help Tags" },
  ["<leader>fa"] = { "<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<cr>", "Help Tags" },


  -- NERDTree mappings
  ["<leader>n"] = { "<cmd>NERDTreeFocus<cr>", "Focus Nerd Tree" },
  ["<leader>e"] = { "<cmd>NERDTreeToggle<cr>", "Toggle Nerd Tree" },

  -- toggleterm
  ["<leader>t"] = {
    name = "+terminal",
    m = { "<cmd>ToggleTerm<cr>", "Toggle Main Terminal" },
    a = { "<cmd>ToggleTermToggleAll<cr>", "Toggle All Terminals" },
  },

  -- Personal
  ["<leader>m"] = { "@", "Start Macro" },

  -- Lsp
  ["<leader>I"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", "View function signature" },
  ["<leader>K"] = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "View implementations" },
  ["<leader>D"] = { "<cmd>lua vim.lsp.buf.definition()<cr>", "View Definition" },
})
