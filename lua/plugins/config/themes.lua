return function()
  require("nightly").setup({
    transparent = false,
    styles = {
      comments = { italic = true },
      functions = { italic = false },
      variables = { italic = false },
      keywords = { italic = false },
    },
    highlights = {},
  })


  require("custom.theme.catppuccin").config()

  vim.g.theme_choices = {
    [[colorscheme kanagawa-dragon]],
    [[colorscheme kanagawa]],
    [[colorscheme nightly]],
    [[colorscheme tokyodark]],
    [[colorscheme mellow]],
    [[colorscheme lunaperche]],
    [[colorscheme slate]],
  };


  vim.cmd("colorscheme kanagawa-dragon")
end
