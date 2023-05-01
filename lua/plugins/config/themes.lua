return function()
	require("custom.theme.catppuccin").config()

	if require("utils").is_day() then
		vim.cmd([[colorscheme melange]])
	else
		vim.cmd([[colorscheme catppuccin]])
	end
end
