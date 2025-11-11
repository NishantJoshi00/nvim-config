return function()
  -- Treesitter Plugin Setup
  require("nvim-treesitter.configs").setup({
    ensure_installed = { "rust", "toml", "lua" },
    auto_install = true,
    indent = { enable = true },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = true,
    },
    playground = {
      persist_queries = true
    }
  })
end
