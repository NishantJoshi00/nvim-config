local rust_analyzer_config = function()
	local rt = require("rust-tools")
	rt.setup({
		server = {
			on_attach = function(_, bufnr)
				vim.keymap.set(
					"n",
					"<leader>q",
					"<cmd>RustHoverActions<cr>",
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
			cmd = { "ra-multiplex" },
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

local point_search = function()
	local Input = require("nui.input")
	local event = require("nui.utils.autocmd").event

	local string_parser = function(data)
		local regex = "^(.-):?(%d*):?(%d*)$"

		local file_path, line_no, col_no = string.match(data, regex)

		local file_exists = vim.fn.filereadable(file_path) > 0

		if file_exists == false then
			return
		end

		vim.cmd("edit " .. file_path)

		if line_no == nil then
			line_no = "0"
		end

		if col_no == nil then
			col_no = "0"
		end
		vim.cmd("cal cursor(" .. line_no .. ", " .. col_no .. ")")
	end

	local input = Input({
		position = "50%",
		size = {
			width = 40,
		},
		border = {
			style = "rounded",
			text = {
				top = "[point search]",
				top_align = "center",
			},
		},
		win_options = {
			winhighlight = "Normal:Normal,FloatBorder:Normal",
		},
	}, {
		prompt = "% ",
		on_close = function() end,
		on_submit = function(value)
			string_parser(value)
		end,
	})

	input:mount()

	input:on(event.BufLeave, function()
		input:unmount()
	end)

	input:map("n", "<esc>", function()
		input:unmount()
	end)
end

vim.g.copy_pad_open = {}
vim.g.scratch_pad_content = {}
local nui_copy_pad = function(name, callback) -- callback gets the content from the copy_pad
	if vim.g.copy_pad_open[name] == 1 then
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
				bottom = name,
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

	local global_insert = function(old, key, value)
		old[key] = value
		return old
	end

	if vim.g.scratch_pad_content[name] then
		vim.api.nvim_buf_set_lines(popup.bufnr, 0, -1, false, vim.g.scratch_pad_content[name])
	end

	vim.cmd([[set syntax=markdown]])
	vim.g.copy_pad_open = global_insert(vim.g.copy_pad_open, name, 1)

	print(vim.inspect(vim.g.copy_pad_open))

	local exit_action = function()
		local popup_buffer = popup.bufnr
		local lines = vim.api.nvim_buf_get_lines(popup_buffer, 0, -1, false)
		vim.g.scratch_pad_content = global_insert(vim.g.scratch_pad_content, name, lines)
		local content = table.concat(lines, get_newline())

		callback(content)
		-- vim.fn.setreg("+", content)

		popup:unmount()
		vim.g.copy_pad_open = global_insert(vim.g.copy_pad_open, name, 0)
	end

	-- unmount component when cursor leaves buffer
	popup:on(event.BufLeave, exit_action)

	popup:map("n", "<esc>", exit_action)
	popup:map("n", ":", exit_action)
end

local get_current_location = function(callback)
	local filename = vim.fn.expand("%")
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))

	callback(filename .. ":" .. row .. ":" .. col)
end

return {
	rust_analyzer_config = rust_analyzer_config,
	disabled_on = disabled_on,
	quoter = quoter,
	dashboard_footer = random_footer,
	copy_pad = nui_copy_pad,
	point_search = point_search,
	get_current_location = get_current_location,
}
