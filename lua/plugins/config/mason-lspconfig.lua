return function()
	require("mason-lspconfig").setup()
	local capabilities = require("cmp_nvim_lsp").default_capabilities()
	require("mason-lspconfig").setup_handlers({
		-- default handler
		function(server_name)
			vim.api.nvim_set_keymap(
				"n",
				"<c-.>",
				"<cmd>lua vim.lsp.buf.code_action()<cr>",
				{ desc = "Lsp Code Action" }
			)
			vim.api.nvim_set_keymap(
				"v",
				"<c-.>",
				"<cmd>lua vim.lsp.buf.code_action()<cr>",
				{ desc = "Lsp Code Action" }
			)
			vim.keymap.set("n", "<Leader>a", vim.lsp.buf.code_action, { desc = "Lsp Code Action" })
			vim.keymap.set("n", "<Leader>q", vim.lsp.buf.hover, { desc = "Hover Code Action" })
			vim.keymap.set("n", "<Leader><c-r>", vim.lsp.buf.rename, { desc = "Lsp Rename" })
			vim.keymap.set("n", "<Leader>R", vim.lsp.buf.references, { desc = "Lsp References" })

			require("lspconfig")[server_name].setup({
				capabilities = capabilities,
			})
		end,

		-- dedicated handlers
		["rust_analyzer"] = require("functions").rust_analyzer_config,
	})
end
