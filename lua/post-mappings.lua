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
  ["<leader>n"] = { "<cmd>NvimTreeFocus<cr>", "Focus Nerd Tree" },
  ["<leader>e"] = { "<cmd>NvimTreeToggle<cr>", "Toggle Nerd Tree" },
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
  -- Markdown specific
  ["<leader>p"] = { "<cmd>Glow<cr>", "Markdown Preview Open" },
  ["<leader>P"] = { "<cmd>Glow!<cr>", "Markdown Preview Close" },
  -- Buffer specific
  ["<leader>bh"] = { "<cmd>bprev<cr>", "Previous Buffer" },
  ["<leader>bl"] = { "<cmd>bnext<cr>", "Next Buffer" },
  -- Fun
  ["<leader>\\"] = { "<cmd>lua vim.g.quote_me()<cr>", "Quote Stuff" },
  -- Session specific
  ["<leader>sc"] = { "<cmd>lua require(\"persistence\").load()<cr>", "Load Session from Current Directory" },
  ["<leader>sl"] = { "<cmd>lua require(\"persistence\").load({ last = true })<cr>", "Load last session" },
  ["<leader>sq"] = { "<cmd>lua require(\"persistence\").stop()<cr>", "Stop Session Recording" },
})



vim.api.nvim_set_keymap('n', '<c-.>', [[<cmd>lua vim.lsp.buf.code_action()<cr>]], {})

vim.keymap.set("n", "<c-n>",
  function()
    require("functions")
        .scratch_pad(
          function(content)
            vim.fn.setreg("+", content)
          end)
  end)

vim.keymap.set("n", "<leader>l", function()
  require("lsp_lines").toggle()
end, { desc = "Toggle lsp_lines" })
