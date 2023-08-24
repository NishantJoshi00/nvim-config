vim.o.mapleader = " "

local wk = require("which-key")

-- NERDTree mappings
vim.api.nvim_set_keymap("n", "<leader>n", [[<cmd>NvimTreeFocus<cr>]], { desc = "Focus Nerd Tree" })
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

-- Telescope mappings
vim.api.nvim_set_keymap(
	"n",
	"<leader>ff",
	[[<cmd>lua require('telescope.builtin').find_files()<cr>]],
	{ desc = "Find Files" }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>fg",
	[[<cmd>lua require('telescope.builtin').live_grep()<cr>]],
	{ desc = "Live Grep" }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>fb",
	[[<cmd>lua require('telescope.builtin').buffers()<cr>]],
	{ desc = "Buffers" }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>fh",
	[[<cmd>lua require('telescope.builtin').help_tags()<cr>]],
	{ desc = "Help Tags" }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>fa",
	[[<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<cr>]],
	{ desc = "LSP Search" }
)

vim.api.nvim_set_keymap(
	"n",
	"<leader>fb",
	[[<cmd>lua require('telescope.builtin').builtin()<cr>]],
	{ desc = "Search Builtin" }
)

vim.api.nvim_set_keymap(
	"n",
	"<leader>fs",
	[[<cmd>lua require('telescope.builtin').spell_suggest()<cr>]],
	{ desc = "Suggest Spellings" }
)

-- toggle term
vim.api.nvim_set_keymap("n", "<leader>tm", [[<cmd>ToggleTerm<cr>]], { desc = "Toggle Main Terminal" })
vim.api.nvim_set_keymap("n", "<leader>ta", [[<cmd>ToggleTermToggleAll<cr>]], { desc = "Toggle All Terminals" })

vim.api.nvim_set_keymap("i", "<c-t>", "<cmd>ToggleTerm<cr>", { silent = true, desc = "toggle terminal" })
vim.api.nvim_set_keymap("t", "<c-t>", "<cmd>ToggleTerm<cr>", { silent = true, desc = "toggle terminal" })
vim.api.nvim_set_keymap("n", "<c-t>", "<cmd>ToggleTerm<cr>", { desc = "toggle terminal" })
vim.api.nvim_set_keymap("n", "<c-/>", "<cmd>gcc<cr>", { desc = "code commenting" })

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

vim.api.nvim_set_keymap("n", "<c-s>", [[<cmd>lua vim.lsp.buf.format { async = true }<cr>]], { desc = "format file" })

vim.api.nvim_set_keymap("n", "zz", [[<cmd>spellr<cr>]], {})

vim.api.nvim_set_keymap("n", "<c-.>", [[<cmd>lua vim.lsp.buf.code_action()<cr>]], { desc = "code action" })

vim.keymap.set("n", "<leader><c-p>", function()
	require("functions").get_current_location(function(content)
		vim.fn.setreg("+", content)
	end)
end)

vim.keymap.set("n", "<c-N>", function()
	require("functions").copy_pad(function(content)
		vim.fn.setreg("+", content)
	end)
end, { desc = "open copy pad" })

vim.keymap.set("n", "<c-n>", function()
	require("functions").copy_pad(function(content)
		-- Decide what to do with the content
	end)
end, { desc = "open scratch pad" })

vim.keymap.set("n", "<c-p>", function()
	require("functions").point_search()
end)

vim.keymap.set("n", "<leader>l", function()
	require("lsp_lines").toggle()
end, { desc = "Toggle lsp_lines" })

vim.keymap.set("n", "'", function()
	require("macro-recorder").repetable_macro()
end, { desc = "Repeat Macro" })

vim.keymap.set("n", "<leader>sm", function()
	require("macro-recorder").select_macro()
end, { desc = "Select Macro" })

vim.keymap.set("n", "<leader>gb", function()
	vim.cmd([[Gitsigns blame_line]])
end, { desc = "Git blame" })

vim.g.lsp_hidden = false
vim.keymap.set("n", "<leader>hl", function()
	if vim.g.lsp_hidden then
		vim.diagnostic.config({ virtual_text = true })
		vim.g.lsp_hidden = true
	else
		vim.diagnostic.config({ virtual_text = false })
		vim.g.lsp_hidden = false
	end
end, { desc = "Toggle Hiding Lsp Hints" })

vim.api.nvim_set_keymap("n", "<leader>hf", [[<cmd>noh]], { desc = "Hide Finds" })

vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })

vim.keymap.set("n", "<leader>oo", require("overseer").toggle, { desc = "Toggle Overseer" })
vim.keymap.set("n", "<leader>oa", require("overseer").run_template, { desc = "Run task from templates" })

-- vim.keymap.set("n", "<leader>test", function()
-- end, { desc = "Testing Lua" })

vim.api.nvim_set_keymap("n", "<S-l>", [[<cmd>bnext<cr>]], { desc = "Go to next Buffer" })
vim.api.nvim_set_keymap("n", "<S-h>", [[<cmd>bprev<cr>]], { desc = "Go to prev Buffer" })
