
lua << EOF
  require("startup").setup({theme = "dashboard"})
  require("which-key").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
  require("mason").setup()
  require("mason-lspconfig").setup() 
  vim.notify = require("notify")

EOF


lua << EOF
  -- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  require("mason-lspconfig").setup_handlers {
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
    function (server_name) -- default handler (optional)
      require("lspconfig")[server_name].setup {
          capabilities = capabilities
        }
    end,
  -- Next, you can provide a dedicated handler for specific servers.
  -- For example, a handler override for the `rust_analyzer`:
  ["rust_analyzer"] = function ()
    require("rust-tools").setup {}
  end
  }

EOF

lua << EOF

  vim.lsp.handlers["textDocument/publishDiagnostics"] = 
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {update_in_insert = true})

  require("toggleterm").setup()

  require("bufferline").setup()
  require("toggleterm").setup()

  require('aerial').setup({
  -- optionally use on_attach to set keymaps when aerial has attached to a buffer
    -- Jump forwards/backwards with '{' and '}'
    on_attach = function(bufnr)
      vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', {buffer = bufnr})
      vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', {buffer = bufnr})
    end
  })
  require('goto-preview').setup {
    width = 120; -- Width of the floating window
    height = 15; -- Height of the floating window
    border = {"↖", "─" ,"┐", "│", "┘", "─", "└", "│"}; -- Border characters of the floating window
    default_mappings = false; -- Bind default mappings
    debug = false; -- Print debug information
    opacity = nil; -- 0-100 opacity level of the floating window where 100 is fully transparent.
    resizing_mappings = false; -- Binds arrow keys to resizing the floating window.
    post_open_hook = nil; -- A function taking two arguments, a buffer and a window to be ran as a hook.

    -- These two configs can also be passed down to the goto-preview definition and implementation calls for one off "peak" functionality.
    focus_on_open = true; -- Focus the floating window when opening it.
    dismiss_on_move = false; -- Dismiss the floating window when moving the cursor.
    force_close = true; -- passed into vim.api.nvim_win_close's second argument. See :h nvim_win_close
    bufhidden = "wipe"; -- the bufhidden option to set on the floating window. See :h bufhidden
  }

  -- You probably also want to set a keymap to toggle aerial
EOF

call wilder#setup({'modes': [':', '/', '?']})

lua << EOF
  require('glow').setup({
    width = 120,
    -- your override config
  })


  vim.notify("config loaded.", "success", {
    title = "vim-plug"
  })
EOF

