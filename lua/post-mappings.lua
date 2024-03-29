local wk = require("which-key")

-- NERDTree mappings
vim.api.nvim_set_keymap("n", "<leader>e", [[<cmd>NvimTreeToggle<cr>]], { desc = "Toggle Nerd Tree" })
vim.keymap.set("n", "<c-e>", function()
  local api = require("nvim-tree.api")
  api.tree.toggle({ focus = false })
end, { desc = "Toggle Nerd Tree" })

-- Lsp
vim.api.nvim_set_keymap("n", "<leader>I", [[<cmd>lua vim.lsp.buf.hover()<cr>]], { desc = "View function signature" })
vim.api.nvim_set_keymap(
  "n",
  "<leader>K",
  [[<cmd>lua vim.lsp.buf.implementation()<cr>]],
  { desc = "View implementations" }
)
vim.api.nvim_set_keymap("n", "<leader>D", [[<cmd>lua vim.lsp.buf.definition()<cr>]], { desc = "View Definition" })

-- Markdown specific
vim.api.nvim_set_keymap("n", "<leader>p", [[<cmd>Glow<cr>]], { desc = "Markdown Preview Open" })
vim.api.nvim_set_keymap("n", "<leader>P", [[<cmd>Glow!<cr>]], { desc = "Markdown Preview Close" })

-- Buffer specific
vim.api.nvim_set_keymap("n", "<leader>bh", [[<cmd>bprev<cr>]], { desc = "Previous Buffer" })
vim.api.nvim_set_keymap("n", "<leader>bl", [[<cmd>bnext<cr>]], { desc = "Next Buffer" })

-- Fun
vim.api.nvim_set_keymap("n", "<leader>\\", [[<cmd>lua vim.g.quote_me()<cr>]], { desc = "Quote Stuff" })

-- Session specific
vim.api.nvim_set_keymap(
  "n",
  "<leader>sc",
  [[<cmd>lua require('persistence').load()<cr>]],
  { desc = "Load Session from Current Directory" }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>sl",
  [[<cmd>lua require('persistence').load({ last = true })<cr>]],
  { desc = "Load last session" }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>sq",
  [[<cmd>lua require('persistence').stop()<cr>]],
  { desc = "Stop Session Recording" }
)

-- Telescope
local telescope_theme = require("functions").telescope_theme;

vim.keymap.set("n", "<leader>ff", function() require("telescope.builtin").find_files(telescope_theme({})) end,
  { desc = "Find Files" })

vim.keymap.set(
  "n",
  "<leader>fg",
  function() require('telescope.builtin').live_grep(telescope_theme({})) end,
  { desc = "Live Grep" }
)

vim.keymap.set(
  "n",
  "<leader>fb",
  function() require('telescope.builtin').buffers(telescope_theme({})) end,
  { desc = "Buffers" }
)
vim.keymap.set(
  "n",
  "<leader>fh",
  function() require('telescope.builtin').help_tags(telescope_theme({})) end,
  { desc = "Help Tags" }
)
vim.keymap.set(
  "n",
  "<leader>fa",
  function() require('telescope.builtin').lsp_dynamic_workspace_symbols(telescope_theme({})) end,
  { desc = "LSP Search" }
)

vim.keymap.set(
  "n",
  "<leader>fb",
  function() require('telescope.builtin').builtin(telescope_theme({})) end,
  { desc = "Search Builtin" }
)


vim.keymap.set(
  "n",
  "<leader>fs",
  function() require('telescope.builtin').spell_suggest(telescope_theme({})) end,
  { desc = "Suggest Spellings" }
)


-- Toggle Term
vim.api.nvim_set_keymap("n", "<leader>tm", [[<cmd>ToggleTerm<cr>]], { desc = "Toggle Main Terminal" })
vim.api.nvim_set_keymap("n", "<leader>ta", [[<cmd>ToggleTermToggleAll<cr>]], { desc = "Toggle All Terminals" })

vim.api.nvim_set_keymap("i", "<c-t>", "<cmd>ToggleTerm<cr>", { silent = true, desc = "toggle terminal" })
vim.api.nvim_set_keymap("t", "<c-t>", "<cmd>ToggleTerm<cr>", { silent = true, desc = "toggle terminal" })
vim.api.nvim_set_keymap("n", "<c-t>", "<cmd>ToggleTerm<cr>", { desc = "toggle terminal" })

-- Commenting
vim.api.nvim_set_keymap("n", "<c-/>", "<cmd>gcc<cr>", { desc = "code commenting" })
vim.api.nvim_set_keymap("n", "<c-/>", "gcc", { desc = "Comment Code" })
vim.api.nvim_set_keymap("v", "<c-/>", "gcc", { desc = "Comment Code" })

-- Goto Preview
vim.api.nvim_set_keymap(
  "n",
  "gpd",
  [[<cmd>lua require('goto-preview').goto_preview_definition()<cr>]],
  { desc = "preview definition" }
)
vim.api.nvim_set_keymap(
  "n",
  "gpt",
  [[<cmd>lua require('goto-preview').goto_preview_type_definition()<cr>]],
  { desc = "preview type definition" }
)
vim.api.nvim_set_keymap(
  "n",
  "gpi",
  [[<cmd>lua require('goto-preview').goto_preview_implementation()<cr>]],
  { desc = "preview implementation" }
)
vim.api.nvim_set_keymap(
  "n",
  "gP",
  [[<cmd>lua require('goto-preview').close_all_win()<cr>]],
  { desc = "close all previews" }
)
vim.api.nvim_set_keymap(
  "n",
  "gpr",
  [[<cmd>lua require('goto-preview').goto_preview_references()<cr>]],
  { desc = "preview references" }
)

-- Lsp
vim.api.nvim_set_keymap("n", "<c-s>", [[<cmd>lua vim.lsp.buf.format { async = true }<cr>]], { desc = "format file" })

vim.api.nvim_set_keymap("n", "<leader>zz", [[<cmd>spellr<cr>]], {})

vim.api.nvim_set_keymap("n", "<c-.>", [[<cmd>lua vim.lsp.buf.code_action()<cr>]], { desc = "code action" })

vim.keymap.set("n", "<leader>l", function() require("lsp_lines").toggle() end, { desc = "Toggle lsp_lines" })

-- Lsp (Custom)
vim.keymap.set("n", "<leader><c-p>", function()
  require("functions").get_current_location(function(content)
    vim.fn.setreg("+", content)
  end)
end)

vim.keymap.set("n", "<c-p>", function()
  require("functions").point_search()
end)


vim.keymap.set("n", "<leader>fl", function()
  require("functions").glob_search()
end)

-- Scratch Pad
vim.keymap.set("n", "<leader><c-n>", function()
  require("functions").copy_pad("copy_pad", function(content)
    vim.fn.setreg("+", content)
  end)
end, { desc = "open copy pad" })

vim.keymap.set("n", "<c-n>", function()
  require("functions").copy_pad("scratch_pad", function(content)
    -- Decide what to do with the content
  end)
end, { desc = "open scratch pad" })


-- Git
vim.keymap.set("n", "<leader>gb", function()
  vim.cmd([[Gitsigns blame_line]])
end, { desc = "Git blame" })

vim.g.lsp_hidden = false
vim.keymap.set("n", "<leader>hl", function()
  if vim.g.lsp_hidden then
    vim.diagnostic.config({ virtual_text = true })
    vim.g.lsp_hidden = false
  else
    vim.diagnostic.config({ virtual_text = false })
    vim.g.lsp_hidden = true
  end
end, { desc = "Toggle Hiding Lsp Hints" })

vim.api.nvim_set_keymap("n", "<leader>hf", [[<cmd>noh<cr>]], { desc = "Hide Finds" })

vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })

vim.keymap.set("n", "<leader>oo", require("overseer").toggle, { desc = "Toggle Overseer" })
vim.keymap.set("n", "<leader>oa", require("overseer").run_template, { desc = "Run task from templates" })

-- vim.keymap.set("n", "<leader>tc", vim.g.theme_cycle, { desc = "Cycle themes" })
vim.keymap.set("n", "<leader>tc", require("functions").theme_choicer, { desc = "Cycle themes" })


-- Buffer
vim.api.nvim_set_keymap("n", "<S-l>", [[<cmd>bnext<cr>]], { desc = "Go to next Buffer" })
vim.api.nvim_set_keymap("n", "<S-h>", [[<cmd>bprev<cr>]], { desc = "Go to prev Buffer" })


vim.api.nvim_set_keymap("n", "<leader>co", [[<cmd>copen<cr>]], { desc = "Open Quickfix List" })
vim.api.nvim_set_keymap("n", "<leader>cc", [[<cmd>ccl<cr>]], { desc = "Close Quickfix List" })
vim.api.nvim_set_keymap("n", "<leader>ct", [[<cmd>cw<cr>]], { desc = "Toggle List" })
vim.api.nvim_set_keymap("n", "<leader>cn", [[<cmd>cn<cr>]], { desc = "Next Location" })
vim.api.nvim_set_keymap("n", "<leader>cp", [[<cmd>cp<cr>]], { desc = "Previous Location" })

-- Evaluation
vim.api.nvim_set_keymap("i", "<c-r>'", [[<c-r>=eval(getline(prevnonblank(".")))<cr>]], { desc = "Evaluate Copy" })

-- Clear notifications

vim.keymap.set('n', "<leader>nd",
  function()
    vim.notify.dismiss({})
  end,
  { desc = "Dismiss Notifications" })

-- Copilot mappings

vim.api.nvim_set_keymap("n", "<leader>nce", [[<cmd>Copilot enable<cr>]], { desc = "Enable Copilot" })
vim.api.nvim_set_keymap("n", "<leader>ncd", [[<cmd>Copilot disable<cr>]], { desc = "Disable Copilot" })
vim.api.nvim_set_keymap("n", "<leader>ncs", [[<cmd>Copilot status<cr>]], { desc = "Copilot Status" })
vim.api.nvim_set_keymap("n", "<leader>ncp", [[<cmd>Copilot panel<cr>]], { desc = "Copilot Panel" })
vim.api.nvim_set_keymap("n", "<leader>ncr", [[<cmd>Copilot restart<cr>]], { desc = "Copilot Restart" })


-- Concealing
vim.api.nvim_set_keymap("n", "<leader>ce", [[<cmd>set conceallevel=2<cr>]], { desc = "Enable Concealing" })
vim.api.nvim_set_keymap("n", "<leader>cd", [[<cmd>set conceallevel=0<cr>]], { desc = "Disable Concealing" })


-- Trouble
vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end)
vim.keymap.set("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end)
vim.keymap.set("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end)
vim.keymap.set("n", "<leader>xq", function() require("trouble").toggle("quickfix") end)
vim.keymap.set("n", "<leader>xl", function() require("trouble").toggle("loclist") end)
vim.keymap.set("n", "<leader>r", function() require("trouble").toggle("lsp_references") end)
