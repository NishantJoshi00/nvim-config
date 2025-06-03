return function()
    -- Fun
    vim.api.nvim_set_keymap("n", "<leader>\\", [[<cmd>lua vim.g.quote_me()<cr>]], { desc = "Quote Stuff" })

    vim.api.nvim_set_keymap("n", "<leader>zz", [[<cmd>spellr<cr>]], {})


    vim.keymap.set("n", "<leader><c-p>",
        function() require("functions").get_current_location(function(content) vim.fn.setreg("+", content) end) end,
        { desc = "Get current location" })

    vim.keymap.set("n", "<c-p>", function() require("functions").point_search() end, { desc = "Point Search" })

    vim.keymap.set("n", "<leader>fl", function()
        require("functions").glob_search()
    end, { desc = "Find in specific files" })


    vim.keymap.set("n", "<leader><c-n>", function()
        require("functions").copy_pad("copy_pad", function(content)
            vim.fn.setreg("+", content)
        end, nil)
    end, { desc = "open copy pad" })

    vim.keymap.set("n", "<c-n>", function()
        require("functions").copy_pad("scratch_pad", function(content)
            -- use the content to do anything
        end, nil)
    end, { desc = "open scratch pad" })


    vim.api.nvim_set_keymap("n", "<leader>hf", [[<cmd>noh<cr>]], { desc = "Hide Finds" })

    vim.keymap.set("n", "<leader>tc", require("functions").theme_choicer, { desc = "Cycle themes" })


    vim.api.nvim_set_keymap("i", "<c-r>'", [[<c-r>=eval(getline(prevnonblank(".")))<cr>]], { desc = "Evaluate Copy" })


    vim.keymap.set('n', "<leader>nd", function() vim.notify.dismiss({}) end,
        { desc = "Dismiss Notifications" })


    -- Markdown specific
    vim.keymap.set("x", "<leader>MV", require("markdown-tree").checklist_visualize,
        { desc = "Visualize Checklist Markdown" })
    vim.keymap.set("n", "<leader>MT", require("markdown-tree").checklist_toggle,
        { desc = "Tick Current Checklist Markdown" })
    vim.keymap.set("n", "<leader>MC", require("markdown-tree").checklist_create,
        { desc = "Tick Current Checklist Markdown" })
    vim.api.nvim_set_keymap("x", "<leader>mhd", [[<cmd>HeaderDecrease<cr>]], { desc = "Decrease Header" })
    vim.api.nvim_set_keymap("x", "<leader>mhi", [[<cmd>HeaderIncrease<cr>]], { desc = "Increase Header" })

    vim.keymap.set(
        "n",
        "<leader>mro",
        function()
            local bufnr = vim.api.nvim_get_current_buf()
            vim.api.nvim_buf_set_option(bufnr, "modifiable", false)
            vim.api.nvim_buf_set_option(bufnr, "readonly", true)
        end,
        { desc = "Mark current buffer as read-only" }
    )

    vim.keymap.set("n", "<leader>eer", function()
        local query = require('vim.treesitter.query')
        local parser = vim.treesitter.get_parser(0, nil)
        local tree = parser:parse()[1]
        local root = tree:root()
        local lang = parser:lang()
        -- local query_input = [[
        --     (import
        --         names: (import_list
        --         (import_name
        --             (variable) @import.name)))
        -- ]]
        local query_input = "(function name: (variable) @function.name)"
        local q = query.parse(lang, query_input)
        local names = {}
        for id, node in q:iter_captures(root, 0, 0, -1) do
            table.insert(names, vim.treesitter.get_node_text(node, 0))
        end
        vim.api.nvim_buf_set_lines(0, 0, -1, false, names)
    end, { desc = "extract" })

    vim.keymap.set(
        "n",
        "<leader>mrw",
        function()
            local bufnr = vim.api.nvim_get_current_buf()
            vim.api.nvim_buf_set_option(bufnr, "modifiable", true)
            vim.api.nvim_buf_set_option(bufnr, "readonly", false)
        end,
        { desc = "Mark current buffer as read-write" }
    )

    vim.api.nvim_set_keymap("n", "<leader>T", [[<cmd>TSCaptureUnderCursor<CR>]], { desc = "Capture TS context" })
end
