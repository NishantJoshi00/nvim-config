return function()
  require("mason-lspconfig").setup()
  local capabilities = require("cmp_nvim_lsp").default_capabilities()
  require("mason-lspconfig").setup_handlers({
    -- default handler
    function(server_name)
      require("lspconfig")[server_name].setup({
        capabilities = capabilities,
      })
    end,

    -- dedicated handlers
    ["rust_analyzer"] = function()
      vim.g.rustaceanvim = require("opts")["rust-analyzer"]

      require("quickfix").rust_quickfix()
    end,
    ["zls"] = function()
      require("zig-tools").setup()
      require("lspconfig").zls.setup({})
    end,

    ["hls"] = function()
      -- this requires haskell-tools.nvim, hls, hlint
    end,
    ["lua_ls"] = function()
      require("lspconfig").lua_ls.setup({
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
          },
        },
      })
    end,
  })
end
