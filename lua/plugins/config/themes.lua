return function()
	require("custom.theme.catppuccin").config()

	if require("utils").is_day() then
		vim.cmd([[colorscheme tokyodark]])
	else
		vim.cmd([[colorscheme tokyodark]])
	end
end
