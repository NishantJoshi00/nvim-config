return function()
  local ensure_installed = { "rust", "toml", "lua" }
  local already_installed = require("nvim-treesitter.config").get_installed()
  local to_install = vim.iter(ensure_installed)
    :filter(function(parser)
      return not vim.tbl_contains(already_installed, parser)
    end)
    :totable()

  if #to_install > 0 then
    require("nvim-treesitter").install(to_install)
  end
end
