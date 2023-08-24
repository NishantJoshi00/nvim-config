return function()
	-- Treesitter Plugin Setup
	require("nvim-treesitter.configs").setup({
		-- ensure_installed = { "lua", "rust", "toml" },
		ensure_installed = { "rust", "toml", "lua" },
		auto_install = true,
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = true,
		},
		ident = { enable = true },
		rainbow = {
			enable = true,
			extended_mode = true,
			max_file_lines = nil,
		},
	})
end
