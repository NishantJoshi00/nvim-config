return function()
    vim.g.theme_choices = {
        [[colorscheme kanagawa-dragon]],
        [[colorscheme tokyodark]],
    };

    local current_hour = tonumber(os.date("%H"));

    -- if current_hour >= 6 and current_hour < 19 then
    --   vim.cmd [[ colorscheme tokyodark ]]
    -- else
    vim.cmd [[ colorscheme kanagawa-dragon ]]
    -- end
end
