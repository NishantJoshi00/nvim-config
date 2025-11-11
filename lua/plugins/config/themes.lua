return function()
    require("kanagawa").setup({
        -- Optional: Add any kanagawa-specific config here
    })
    vim.cmd([[colorscheme kanagawa-dragon]])
end
