return function()

  local trouble = require("trouble.providers.telescope")

  require("telescope").setup({
    defaults = {
      layout_strategy = "bottom_pane",
      mappings = {
        i = { ["<c-t>"] = trouble.open_with_trouble },
        n = { ["<c-t>"] = trouble.open_with_trouble },
      },
    }
  })
end
