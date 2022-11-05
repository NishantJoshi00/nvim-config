let mapleader=" "
lua << EOF

local wk = require("which-key")

wk.register({
-- Telescope mappings
  ["<leader>ff"] = {"<cmd>lua require('telescope.builtin').find_files()<cr>", "Find Files"},
  ["<leader>fg"] = {"<cmd>lua require('telescope.builtin').live_grep()<cr>", "Live Grep"},
  ["<leader>fb"] = {"<cmd>lua require('telescope.builtin').buffers()<cr>", "Buffers"},
  ["<leader>fh"] = {"<cmd>lua require('telescope.builtin').help_tags()<cr>", "Help Tags"},


-- NERDTree mappings
  ["<leader>n"] = {":NERDTreeFocus<cr>"},
  ["<leader>e"] = {":NERDTreeToggle<cr>"},

-- toggleterm
  ["<leader>t"] = {
      name = "+terminal",
      m = {"<cmd>ToggleTerm<cr>", "Toggle Main Terminal"},
      a = {"<cmd>ToggleTermToggleAll<cr>", "Toggle All Terminals"},
    },

-- aerial
  ["<leader>a"] = {
      name = "Aerial Binds",
      t = {"<cmd>AerialToggle Left<cr>", "Aerial Toggle"},
      T = {"<cmd>AerialToggleAll Left<cr>", "Aerial Toggle All"},
      C = {"<cmd>AerialCloseAll", "Aerial CloseAll"},
  },

-- Personal
  ["<leader>m"] = {"@", "Start Macro"},


})

EOF

inoremap <silent><c-t> <cmd>ToggleTerm<cr>
tnoremap <silent><c-t> <cmd>ToggleTerm<cr>
nnoremap <slient><c-t> <cmd>ToggleTerm<cr>
