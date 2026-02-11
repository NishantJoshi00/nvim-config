return function()
    local functions = require("functions")
    local markdown_tree = require("markdown-tree")
    local keymap = vim.keymap.set

    keymap("n", "<leader>\\", functions.quoter, { desc = "Quote Stuff" })
    keymap("n", "<leader>zz", "<cmd>spellr<cr>", {})

    keymap("n", "<leader><c-p>",
        function() functions.get_current_location(function(content) vim.fn.setreg("+", content) end) end,
        { desc = "Get current location" })

    keymap("n", "<c-p>", functions.point_search, { desc = "Point Search" })

    keymap("n", "<leader>fl", functions.glob_search, { desc = "Find in specific files" })

    keymap("n", "<leader><c-n>", function()
        functions.copy_pad("copy_pad", function(content)
            vim.fn.setreg("+", content)
        end)
    end, { desc = "open copy pad" })

    keymap("n", "<c-n>", function()
        functions.copy_pad("scratch_pad", function() end)
    end, { desc = "open scratch pad" })

    keymap("n", "<leader>hf", "<cmd>noh<cr>", { desc = "Hide Finds" })
    keymap("i", "<c-r>'", "<c-r>=eval(getline(prevnonblank(\".\")))<cr>", { desc = "Evaluate Copy" })
    keymap("n", "<leader>nd", function() vim.notify.dismiss({}) end, { desc = "Dismiss Notifications" })

    -- Markdown
    keymap("x", "<leader>MV", markdown_tree.checklist_visualize, { desc = "Visualize Checklist Markdown" })
    keymap("n", "<leader>MT", markdown_tree.checklist_toggle, { desc = "Tick Current Checklist Markdown" })
    keymap("n", "<leader>MC", markdown_tree.checklist_create, { desc = "Create Checklist Item" })
    keymap("x", "<leader>mhd", "<cmd>HeaderDecrease<cr>", { desc = "Decrease Header" })
    keymap("x", "<leader>mhi", "<cmd>HeaderIncrease<cr>", { desc = "Increase Header" })

    keymap("n", "<leader>mro", function()
        local bufnr = vim.api.nvim_get_current_buf()
        vim.api.nvim_set_option_value("modifiable", false, { buf = bufnr })
        vim.api.nvim_set_option_value("readonly", true, { buf = bufnr })
    end, { desc = "Mark current buffer as read-only" })

    keymap("n", "<leader>eer", function()
        local event = require("nui.utils.autocmd").event
        local Input = require("nui.input")

        local input = Input({
            position = { row = "90%", col = "50%" },
            size = { width = 60 },
            border = {
                style = "rounded",
                text = { top = "[treesitter query]", top_align = "center" },
            },
            win_options = {
                winhighlight = "Normal:Normal,FloatBorder:Normal",
            },
        }, {
            prompt = "% ",
            default_value = "(function_call name: (variable) @function.name)",
            on_submit = function(query_input)
                local ok, err = pcall(function()
                    local parser = vim.treesitter.get_parser(0)
                    local tree = parser:parse()[1]
                    local root = tree:root()
                    local lang = parser:lang()
                    local q = vim.treesitter.query.parse(lang, query_input)
                    local names = {}
                    for _, node in q:iter_captures(root, 0, 0, -1) do
                        names[#names + 1] = vim.treesitter.get_node_text(node, 0)
                    end
                    vim.api.nvim_buf_set_lines(0, 0, -1, false, names)
                end)
                if not ok then
                    vim.notify("Query error: " .. tostring(err), vim.log.levels.ERROR)
                end
            end,
        })

        input:mount()

        local function exit() input:unmount() end
        input:on(event.BufLeave, exit)
        input:map("n", "<esc>", exit)
    end, { desc = "extract" })

    keymap("n", "<leader>mrw", function()
        local bufnr = vim.api.nvim_get_current_buf()
        vim.api.nvim_set_option_value("modifiable", true, { buf = bufnr })
        vim.api.nvim_set_option_value("readonly", false, { buf = bufnr })
    end, { desc = "Mark current buffer as read-write" })

    keymap("n", "<leader>T", "<cmd>TSCaptureUnderCursor<CR>", { desc = "Capture TS context" })
end
