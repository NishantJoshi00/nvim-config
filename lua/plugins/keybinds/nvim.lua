return function()
    -- Buffer specific
    vim.keymap.set("n", "<leader>bh", "<cmd>bprev<cr>", { desc = "Previous Buffer" })
    vim.keymap.set("n", "<leader>bl", "<cmd>bnext<cr>", { desc = "Next Buffer" })
    vim.keymap.set("n", "<leader>bd", "<cmd>bdel<cr>", { desc = "Delete Buffer" })
    vim.keymap.set("n", "<leader>bdf", "<cmd>bdel!<cr>", { desc = "Force Delete Buffer" })
    vim.keymap.set("n", "<leader>bn", "<cmd>tab new<cr>", { desc = "New Buffer" })

    -- Buffer
    vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Go to next Buffer" })
    vim.keymap.set("n", "<S-h>", "<cmd>bprev<cr>", { desc = "Go to prev Buffer" })

    -- Tab
    vim.keymap.set("n", "<leader><S-l>", "<cmd>tabnext<cr>", { desc = "Go to next Tab" })

    -- Quickfix
    vim.keymap.set("n", "<leader>co", "<cmd>copen<cr>", { desc = "Open Quickfix List" })
    vim.keymap.set("n", "<leader>cc", "<cmd>ccl<cr>", { desc = "Close Quickfix List" })
    vim.keymap.set("n", "<leader>cn", "<cmd>cn<cr>", { desc = "Next Location" })
    vim.keymap.set("n", "<leader>cp", "<cmd>cp<cr>", { desc = "Previous Location" })

    -- Concealing (using capital C to avoid conflicts)
    vim.keymap.set("n", "<leader>Con", "<cmd>set conceallevel=2<cr>", { desc = "Enable Concealing" })
    vim.keymap.set("n", "<leader>Coff", "<cmd>set conceallevel=0<cr>", { desc = "Disable Concealing" })

    -- Terminal
    vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = "Exit Terminal Mode" })
end
