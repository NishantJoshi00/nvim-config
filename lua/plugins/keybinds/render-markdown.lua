return function()
    vim.cmd([[RenderMarkdown disable]])
    vim.keymap.set("n", "<leader>rm", "<cmd>RenderMarkdown toggle<cr>", { desc = "Toggle Markdown Rendering" })
end
