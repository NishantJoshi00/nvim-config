return function()
  vim.g.theme_choices = {
    [[colorscheme oldworld]],
    [[colorscheme kanagawa-dragon]],
    [[colorscheme rose-pine]],
    [[colorscheme tokyodark]],
  };

  local current_hour = tonumber(os.date("%H"));

  if current_hour >= 6 and current_hour < 19 then
    vim.cmd [[ colorscheme rose-pine ]]
  else
    vim.cmd [[ colorscheme kanagawa-dragon ]]
  end
end
