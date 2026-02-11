return function()
    local keymap = vim.keymap.set

    -- Buffers
    keymap("n", "<leader>bh", "<cmd>bprev<cr>", { desc = "Previous Buffer" })
    keymap("n", "<leader>bl", "<cmd>bnext<cr>", { desc = "Next Buffer" })
    keymap("n", "<leader>bd", "<cmd>bdel<cr>", { desc = "Delete Buffer" })
    keymap("n", "<leader>bdf", "<cmd>bdel!<cr>", { desc = "Force Delete Buffer" })
    keymap("n", "<leader>bn", "<cmd>tab new<cr>", { desc = "New Buffer" })
    keymap("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Go to next Buffer" })
    keymap("n", "<S-h>", "<cmd>bprev<cr>", { desc = "Go to prev Buffer" })

    -- Tabs
    keymap("n", "<leader><S-l>", "<cmd>tabnext<cr>", { desc = "Go to next Tab" })

    -- Quickfix
    keymap("n", "<leader>co", "<cmd>copen<cr>", { desc = "Open Quickfix List" })
    keymap("n", "<leader>cc", "<cmd>ccl<cr>", { desc = "Close Quickfix List" })
    keymap("n", "<leader>cn", "<cmd>cn<cr>", { desc = "Next Location" })
    keymap("n", "<leader>cp", "<cmd>cp<cr>", { desc = "Previous Location" })

    -- Concealing
    keymap("n", "<leader>Con", "<cmd>set conceallevel=2<cr>", { desc = "Enable Concealing" })
    keymap("n", "<leader>Coff", "<cmd>set conceallevel=0<cr>", { desc = "Disable Concealing" })

    -- Terminal
    keymap("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit Terminal Mode" })
end
