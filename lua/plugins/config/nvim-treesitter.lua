return function()
  -- Treesitter Plugin Setup
  require("nvim-treesitter.configs").setup({
    ensure_installed = { "rust", "toml", "lua" },
    auto_install = true,
    ident = { enable = true },
    rainbow = {
      enable = true,
      extended_mode = true,
      max_file_lines = nil,
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = true,
    },
    playground = {
      persist_queries = true
    }
  })
end
