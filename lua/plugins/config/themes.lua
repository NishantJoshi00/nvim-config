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

  if require("utils").is_day() then
    vim.cmd([[colorscheme nightly]])
  else
    vim.cmd([[colorscheme tokyodark]])
    vim.cmd([[colorscheme nightly]])
  end
end
