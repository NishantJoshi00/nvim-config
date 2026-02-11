return function()
  local cmp = require("cmp")

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "vsnip" },
    }, {
      { name = "buffer" },
      { name = "path" },
    }),
    formatting = {
      format = function(entry, vim_item)
        vim_item.menu = ({
          nvim_lsp = "[LSP]",
          buffer = "[Buffer]",
          path = "[Path]",
          vsnip = "[VSnip]",
        })[entry.source.name]
        return vim_item
      end,
      expandable_indicator = true,
      fields = { "menu", "abbr", "kind" },
    },
  })

  cmp.setup.filetype("gitcommit", {
    sources = cmp.config.sources({
      { name = "cmp_git" },
    }, {
      { name = "buffer" },
    }),
  })

  cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    window = { completion = cmp.config.window.bordered() },
    sources = { { name = "buffer" } },
  })

  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    window = cmp.config.window.bordered(),
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      { name = "cmdline" },
    }),
  })
end
