return function()
  require("toggleterm").setup({
    size = 30,
    open_mapping = [[<c-t>]],
    hide_numbers = true,
    shade_terminals = true,
    shading_factor = "1",
    start_in_insert = true,
    persist_size = true,
    direction = "horizontal",
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
      border = "single",
      width = 150,
      height = 50,
      winblend = 3,
      highlights = {
        border = "Normal",
        background = "Normal",
      },
    },
  })
end
