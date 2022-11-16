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
  ["<leader>n"] = {"<cmd>NERDTreeFocus<cr>", "Focus Nerd Tree"},
  ["<leader>e"] = {"<cmd>NERDTreeToggle<cr>", "Toggle Nerd Tree"},

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

  -- Lsp
  ["<leader>I"] = {"<cmd>lua vim.lsp.buf.hover()<cr>", "View function signature"},
  ["<leader>K"] = {"<cmd>lua vim.lsp.buf.implementation()<cr>", "View implementations"},
  ["<leader>D"] = {"<cmd>lua vim.lsp.buf.definition()<cr>", "View Definition"}


})

EOF

inoremap <silent><c-t> <cmd>ToggleTerm<cr>
tnoremap <silent><c-t> <cmd>ToggleTerm<cr>
nnoremap <c-t> <cmd>ToggleTerm<cr>
inoremap <c-/> <esc><n>gcc<cr>i<cr>

nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>
nnoremap gpt <cmd>lua require('goto-preview').goto_preview_type_definition()<CR>
nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>
nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>
nnoremap gpr <cmd>lua require('goto-preview').goto_preview_references()<CR>
