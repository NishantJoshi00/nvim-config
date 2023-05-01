local rust_analyzer_config = function()
	local rt = require("rust-tools")
	rt.setup({
		server = {
			on_attach = function(_, bufnr)
				vim.keymap.set(
					"n",
					"<c-space>",
					rt.hover_actions.hover_actions,
					{ buffer = bufnr, desc = "Rust Hover Action" }
				)
				vim.keymap.set(
					"n",
					"<Leader>a",
					rt.code_action_group.code_action_group,
					{ buffer = bufnr, desc = "Rust Code Action" }
				)
				vim.keymap.set(
					"v",
					"<c-space>",
					rt.code_action_group.code_action_group,
					{ buffer = bufnr, desc = "Rust Code Action" }
				)

				vim.api.nvim_set_keymap(
					"n",
					"<c-.>",
					"<cmd>lua vim.lsp.buf.code_action()<cr>",
					{ desc = "Rust Code Action" }
				)
				vim.api.nvim_set_keymap(
					"v",
					"<c-.>",
					"<cmd>lua vim.lsp.buf.code_action()<cr>",
					{ desc = "Rust Code Action" }
				)
			end,
			settings = {
				["rust_analyzer"] = {
					inlayHints = {
						lifetimeElisionHints = {
							useParameterNames = true,
							enable = "always",
						},
						expressionAdjustmentHints = {
							enable = "reborrow",
						},
						closureReturnTypeHints = {
							enable = "with_block",
						},
					},
					cargo = {
						buildScripts = {
							overrideCommand = nil,
						},
					},
					imports = {
						prefix = "crate",
					},
					diagnostics = {
						disabled = {
							"unresolved-macro-call",
						},
					},
					completion = {
						autoimport = {
							enable = true,
						},
					},
					procMacro = {
						enable = true,
						attributes = {
							enable = true,
						},
					},
				},
			},
		},
	})
end

local disabled_on = function(systems)
	for _, val in ipairs(systems) do
		if vim.fn.has(val) == 1 then
			return true
		end
	end
	return false
end

local quoter = function()
	vim.fn.jobstart("curl -s https://zenquotes.io/api/random | jq '.[0][\"q\"]'", {
		stdout_buffered = true,
		on_stdout = function(a, b, c)
			-- print(vim.inspect(b))
			vim.notify(b[1], "info", { hide_from_history = true })
		end,
	})
end
vim.g.quote_me = quoter

local random_footer = function()
	local footers = {
		"🚀 Sharp tools make good work.",
		"🥛 Boost is the secret of my energy.",
		"🥛 I am a complan boy",
		"⛰  Washing powder nirma",
		"📜 Luck is the planning, that you don't see.",
		"💣 Every problem is a business opportunity.",
	}
	math.randomseed(os.time())
	return footers[math.random(1, #footers)]
end

local get_newline = function()
	if vim.fn.has("win32") == 1 then
		return "\r\n"
	else
		return "\n"
	end
end

local nui_scratch = function(callback) -- callback gets the content from the scratch_pad
	if vim.g.scratch_open == 1 then
		return
	end

	local Popup = require("nui.popup")
	local event = require("nui.utils.autocmd").event

	local popup = Popup({
		enter = true,
		focusable = true,
		border = {
			style = "rounded",
			text = {
				bottom = "scratch pad",
				bottom_align = "center",
			},
			padding = { 1, 1 },
		},
		position = {
			row = "50%",
			col = "100%",
		},
		size = "40%",
		-- size = {
		--   width = "40%",
		--   height = "70%",
		-- },
	})

	-- mount/open the component
	popup:mount()
	vim.cmd([[set syntax=markdown]])
	vim.g.scratch_open = 1

	local exit_action = function()
		local popup_buffer = popup.bufnr
		local lines = vim.api.nvim_buf_get_lines(popup_buffer, 0, -1, false)
		local content = table.concat(lines, get_newline())

		callback(content)
		-- vim.fn.setreg("+", content)

		popup:unmount()
		vim.g.scratch_open = 0
	end

	-- unmount component when cursor leaves buffer
	popup:on(event.BufLeave, exit_action)

	popup:map("n", "<esc>", exit_action)
end

return {
	rust_analyzer_config = rust_analyzer_config,
	disabled_on = disabled_on,
	quoter = quoter,
	dashboard_footer = random_footer,
	scratch_pad = nui_scratch,
}
