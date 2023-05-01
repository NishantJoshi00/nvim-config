return function()
	local ascii = require("ascii")

	require("dashboard").setup({
		theme = "hyper",
		config = {
			header = ascii.art.text.neovim.sharp,
			shortcut = {
				{ desc = "[  Github]", group = "DashboardShortCut" },
				{
					desc = "[  NishantJoshi00]",
					group = "DashboardShortCut",
					action = "lua vim.g.quote_me()",
					key = "i",
				},
			},
			footer = {
				"",
				require("functions").dashboard_footer(),
			},
		},
	})
end
