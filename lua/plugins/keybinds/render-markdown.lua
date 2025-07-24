return function()
    vim.cmd([[RenderMarkdown disable]])
    vim.api.nvim_set_keymap("n", "<leader>rm", [[<cmd>RenderMarkdown toggle<cr>]], { desc = "Toggle Markdown Rendering" })
end
