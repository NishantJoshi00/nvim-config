return function()
  require("notify").setup({
    render = "compact",
  })

  vim.notify = require("notify")

  require("functions").quoter()
end
