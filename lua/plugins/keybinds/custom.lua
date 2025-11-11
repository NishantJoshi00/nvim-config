return function()
    local functions = require("functions")
    local markdown_tree = require("markdown-tree")

    -- Fun
    vim.keymap.set("n", "<leader>\\", functions.quoter, { desc = "Quote Stuff" })

    vim.keymap.set("n", "<leader>zz", "<cmd>spellr<cr>", {})


    vim.keymap.set("n", "<leader><c-p>",
        function() functions.get_current_location(function(content) vim.fn.setreg("+", content) end) end,
        { desc = "Get current location" })

    vim.keymap.set("n", "<c-p>", function() functions.point_search() end, { desc = "Point Search" })

    vim.keymap.set("n", "<leader>fl", function()
        functions.glob_search()
    end, { desc = "Find in specific files" })


    vim.keymap.set("n", "<leader><c-n>", function()
        functions.copy_pad("copy_pad", function(content)
            vim.fn.setreg("+", content)
        end, nil)
    end, { desc = "open copy pad" })

    vim.keymap.set("n", "<c-n>", function()
        functions.copy_pad("scratch_pad", function(content)
            -- use the content to do anything
        end, nil)
    end, { desc = "open scratch pad" })


    vim.keymap.set("n", "<leader>hf", "<cmd>noh<cr>", { desc = "Hide Finds" })

    vim.keymap.set("i", "<c-r>'", "<c-r>=eval(getline(prevnonblank(\".\")))<cr>", { desc = "Evaluate Copy" })


    vim.keymap.set('n', "<leader>nd", function() vim.notify.dismiss({}) end,
        { desc = "Dismiss Notifications" })


    -- Markdown specific
    vim.keymap.set("x", "<leader>MV", markdown_tree.checklist_visualize,
        { desc = "Visualize Checklist Markdown" })
    vim.keymap.set("n", "<leader>MT", markdown_tree.checklist_toggle,
        { desc = "Tick Current Checklist Markdown" })
    vim.keymap.set("n", "<leader>MC", markdown_tree.checklist_create,
        { desc = "Tick Current Checklist Markdown" })
    vim.keymap.set("x", "<leader>mhd", "<cmd>HeaderDecrease<cr>", { desc = "Decrease Header" })
    vim.keymap.set("x", "<leader>mhi", "<cmd>HeaderIncrease<cr>", { desc = "Increase Header" })

    vim.keymap.set(
        "n",
        "<leader>mro",
        function()
            local bufnr = vim.api.nvim_get_current_buf()
            vim.api.nvim_set_option_value("modifiable", false, { buf = bufnr })
            vim.api.nvim_set_option_value("readonly", true, { buf = bufnr })
        end,
        { desc = "Mark current buffer as read-only" }
    )

    vim.keymap.set("n", "<leader>eer", function()
        local Input = require("nui.input")
        local event = require("nui.utils.autocmd").event

        local input = Input({
            position = { row = "90%", col = "50%" },
            size = {
                width = 60,
            },
            border = {
                style = "rounded",
                text = {
                    top = "[treesitter query]",
                    top_align = "center",
                },
            },
            win_options = {
                winhighlight = "Normal:Normal,FloatBorder:Normal",
            },
        }, {
            prompt = "% ",
            default_value = "(function_call name: (variable) @function.name)",
            on_close = function() end,
            on_submit = function(query_input)
                local query = require('vim.treesitter.query')
                local parser = vim.treesitter.get_parser(0, nil)
                local tree = parser:parse()[1]
                local root = tree:root()
                local lang = parser:lang()
                local q = query.parse(lang, query_input)
                local names = {}
                for id, node in q:iter_captures(root, 0, 0, -1) do
                    table.insert(names, vim.treesitter.get_node_text(node, 0))
                end
                vim.api.nvim_buf_set_lines(0, 0, -1, false, names)
            end,
        })

        input:mount()

        local exit_action = function()
            input:unmount()
        end

        input:on(event.BufLeave, exit_action)
        input:map("n", "<esc>", exit_action)
    end, { desc = "extract" })

    vim.keymap.set(
        "n",
        "<leader>mrw",
        function()
            local bufnr = vim.api.nvim_get_current_buf()
            vim.api.nvim_set_option_value("modifiable", true, { buf = bufnr })
            vim.api.nvim_set_option_value("readonly", false, { buf = bufnr })
        end,
        { desc = "Mark current buffer as read-write" }
    )

    vim.keymap.set("n", "<leader>T", "<cmd>TSCaptureUnderCursor<CR>", { desc = "Capture TS context" })
end
