return {
  { "tiagovla/tokyodark.nvim", config = function()
    vim.cmd [[colorscheme tokyodark]]
  end,
  },
  { 'rebelot/kanagawa.nvim' },
  { "tpope/vim-fugitive" },
  { "cohama/lexima.vim" },
  { "preservim/vim-markdown" },
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim", config = function() require("mason").setup() end, },
  { "williamboman/mason-lspconfig.nvim", dependencies = {
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    "simrat39/rust-tools.nvim",
    "williamboman/mason.nvim"
  },
    config = function()
      require("mason-lspconfig").setup()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      require("mason-lspconfig").setup_handlers {
        -- defualt handler
        function(server_name)
          vim.api.nvim_set_keymap('n', '<c-.>', '<cmd>lua vim.lsp.buf.code_action()<cr>', {})
          vim.api.nvim_set_keymap('v', '<c-.>', '<cmd>lua vim.lsp.buf.code_action()<cr>', {})
          vim.keymap.set("n", "<Leader>a", vim.lsp.buf.code_action, {})
          require("lspconfig")[server_name].setup {
            capabilities = capabilities
          }
        end,

        -- dedicated handlers
        ["rust_analyzer"] = function()
          local rt = require("rust-tools")
          rt.setup {
            server = {
              on_attach = function(_, bufnr)
                vim.keymap.set("n", "<c-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
                vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
                vim.keymap.set("v", "<c-space>", rt.code_action_group.code_action_group, { buffer = bufnr })

                vim.api.nvim_set_keymap('n', '<c-.>', '<cmd>lua vim.lsp.buf.code_action()<cr>', {})
                vim.api.nvim_set_keymap('v', '<c-.>', '<cmd>lua vim.lsp.buf.code_action()<cr>', {})
              end,
              settings = {
                ["rust_analyzer"] = {
                  inlayHints = {
                    lifetimeElisionHints = {
                      useParameterNames = true,
                      enable = "always",
                    },
                    expressionAdjustmentHints = {
                      enable = "reborrow",
                    },
                    closureReturnTypeHints = {
                      enable = "with_block",
                    }
                  },
                  diagnostics = {
                    disabled = {
                      "unresolved-macro-call"
                    }
                  },
                  completion = {
                    autoimport = {
                      enable = true,
                    }
                  },
                  procMacro = {
                    enable = true,
                    attributes = {
                      enable = true
                    }
                  },

                }
              }
            }
          }
        end
      }
    end,
  },
  { "nvim-lua/plenary.nvim" },
  { "nvim-telescope/telescope.nvim" },
  { "nvim-lualine/lualine.nvim" },
  { "nvim-tree/nvim-tree.lua", config = function()
    require("nvim-tree").setup({
      open_on_setup = false,
    })
  end
  },
  { "nvim-tree/nvim-web-devicons", dependencies = { "nvim-tree/nvim-tree.lua" } },
  { "folke/which-key.nvim", config = function() require("which-key").setup {
      -- your configuration comes here
      -- or leave it empty to use the default settings
    }
  end,
  },
  { "ryanoasis/vim-devicons" },

  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-cmdline" },
  { "hrsh7th/cmp-vsnip" },
  { "hrsh7th/vim-vsnip" },
  { "hrsh7th/nvim-cmp", dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-vsnip",
    "hrsh7th/vim-vsnip"
  },
    config = function()
      local cmp = require("cmp")

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
    end
  },

  { "simrat39/rust-tools.nvim" },
  { "tpope/vim-commentary", config = function()
    vim.api.nvim_set_keymap('n', '<c-/>', 'gcc', {})
    vim.api.nvim_set_keymap('v', '<c-/>', 'gcc', {})
  end,
  },
  { "nvim-treesitter/nvim-treesitter", config = function()
    -- Treesitter Plugin Setup
    require('nvim-treesitter.configs').setup {
      ensure_installed = { "lua", "rust", "toml" },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
      },
      ident = { enable = true },
      rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
      }
    }
  end,
    dependencies = {
      "neovim/nvim-lspconfig"
    }
  },


  {
    'glepnir/dashboard-nvim',
    event = 'VimEnter',
    opts = {
      -- config
    },
  },
  { "ggandor/lightspeed.nvim" },
  { "akinsho/bufferline.nvim", config = function() require("bufferline").setup() end, },

  { "akinsho/toggleterm.nvim", config = function() require("toggleterm").setup({ shell = vim.o.shell }) end, },
  { "ellisonleao/glow.nvim", config = function() require("glow").setup({ width = 120, }) end, },
  { "gelguy/wilder.nvim", config = function() require("wilder").setup({ modes = { ":", "/", "?" } }) end, },
  { "rcarriga/nvim-notify", config = function()
    vim.notify = require("notify")
  end,
  },
  { "rmagatti/goto-preview", config = function()
    require("goto-preview").setup {
      width = 120; -- Width of the floating window
      height = 15; -- Height of the floating window
      border = { "↖", "─", "┐", "│", "┘", "─", "└", "│" }; -- Border characters of the floating window
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
  end
  },


  { "lukas-reineke/indent-blankline.nvim", config = function()
    require("indent_blankline").setup {
      show_current_context = true,
      show_current_context_start = true,
    }
  end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter"
    }
  },
  { "airblade/vim-gitgutter" },
  { "catppuccin/nvim", name = "catppuccin", config = function()
    -- vim.cmd [[colorscheme catppuccin]]
  end
  },
  { "beauwilliams/focus.nvim", config = function()
    local focus = require("focus")
    focus.setup()

    vim.api.nvim_set_keymap('n', '<c-h>', ':FocusSplitLeft<CR>', { silent = true })
    vim.api.nvim_set_keymap('n', '<c-j>', ':FocusSplitDown<CR>', { silent = true })
    vim.api.nvim_set_keymap('n', '<c-k>', ':FocusSplitUp<CR>', { silent = true })
    vim.api.nvim_set_keymap('n', '<c-l>', ':FocusSplitRight<CR>', { silent = true })

    vim.api.nvim_set_keymap('n', '<leader>wp', ':FocusSplitNicely<CR>', { silent = true })
    vim.api.nvim_set_keymap('n', '<leader>wo', ':FocusMaxOrEqual<CR>', { silent = true })

  end
  },
}
