return function()
  require("nvim-treesitter.configs").setup({
    ensure_installed = { "rust", "toml", "lua" },
    auto_install = true,
    indent = { enable = true },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = true,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        node_decremental = "<C-backspace>",
      },
    },
    playground = { persist_queries = true },
  })
end
