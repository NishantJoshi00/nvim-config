return function()
    require("render-markdown").setup({})

    -- Load keybinds when plugin loads (only for markdown files)
    require("plugins.keybinds.render-markdown")()
end
