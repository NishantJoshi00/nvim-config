return {
  {
    "tiagovla/tokyodark.nvim",
    config = require("plugins.config.themes"),
    dependencies = {
      "catppuccin/nvim",
      'rebelot/kanagawa.nvim',
      'kvrohit/mellow.nvim',
      'savq/melange-nvim'
    }
  },
  { 'rebelot/kanagawa.nvim' },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end
  },
  { "cohama/lexima.vim" },
  { "preservim/vim-markdown" },
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim", config = function() require("mason").setup() end, },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
      "simrat39/rust-tools.nvim",
      "williamboman/mason.nvim"
    },
    config = require("plugins.config.mason-lspconfig"),
  },
  { "nvim-lua/plenary.nvim" },
  { "nvim-telescope/telescope.nvim" },
  {
    "nvim-tree/nvim-tree.lua",
    config = require("plugins.config.nvim-tree")
  },
  { "nvim-tree/nvim-web-devicons", dependencies = { "nvim-tree/nvim-tree.lua" } },
  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {
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
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip"
    },
    config = require("plugins.config.nvim-cmp")
  },
  { "simrat39/rust-tools.nvim" },
  {
    "tpope/vim-commentary",
    config = function()
      vim.api.nvim_set_keymap('n', '<c-/>', 'gcc', {})
      vim.api.nvim_set_keymap('v', '<c-/>', 'gcc', {})
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    config = require("plugins.config.nvim-treesitter"),
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-treesitter/playground",
    }
  },


  {
    'glepnir/dashboard-nvim',
    event = 'VimEnter',
    dependencies = {
      "MaximilianLloyd/ascii.nvim"
    },
    config = require("plugins.config.dashboard-nvim"),
  },
  { "ggandor/lightspeed.nvim" },
  { "akinsho/bufferline.nvim", config = function() require("bufferline").setup() end, },
  { "akinsho/toggleterm.nvim", config = require("plugins.config.toggleterm") },
  {
    "ellisonleao/glow.nvim",
    config = function()
      require("glow").setup({
      })
    end,
    enabled = function()
      return not require("functions").disabled_on({ "win32" })
    end,
  },
  { "gelguy/wilder.nvim",    config = function() require("wilder").setup({ modes = { ":", "/", "?" } }) end, },
  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup({
        render = "compact"
      })

      vim.notify = require("notify")

      require("functions").quoter()
    end,
  },
  {
    "rmagatti/goto-preview",
    config = require("plugins.config.goto-preview")
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
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
  {
    "beauwilliams/focus.nvim",
    config = require("plugins.config.focus")
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    config = require("functions").lualine_config
  },
  {
    "j-hui/fidget.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("fidget").setup({
        text = {
          spinner = "dots"
        }
      })
    end
  },
  {
    -- Notion Integration for NeoVim
    "chrsm/impulse.nvim",
    enabled = false,
    config = function()
      require("impulse").setup()
    end
  },
  {
    "MunifTanjim/nui.nvim",
    config = function()
    end
  },
  {
    "MaximilianLloyd/ascii.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim"
    }
  },
  {
    enabled = false,
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = require("plugins.config.noice")
  },
  {
    enabled = false,
    "folke/twilight.nvim",
    config = function()
      require("twilight").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  },
  {
    'saecki/crates.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('crates').setup()
    end,
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    module = "persistence",
    config = function()
      require("persistence").setup()
    end,
  },
  {
    "samueljoli/hurl.nvim",
    config = function()
      require("hurl").setup()
    end
  },
  {
    -- enabled = false,
    'poljar/typos.nvim',
    config = function()
      require("typos").setup()
    end,
  },
  {
    "sindrets/diffview.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim"
    }
  },
  {
    'edluffy/hologram.nvim',
    enabled = function()
      return not require("functions").disabled_on({ "win32" })
    end,
    config = function()
      require("hologram").setup({
      })
    end
  },
  {
    'giusgad/pets.nvim',
    enabled = function()
      return not require("functions").disabled_on({ "win32" })
    end,
    dependencies = {
      'edluffy/hologram.nvim',
      'MunifTanjim/nui.nvim'
    },
    config = function()
      require('pets').setup({})
    end
  },
  {
    'ray-x/lsp_signature.nvim',
    config = function()
      require("lsp_signature").setup()
    end,
    dependencies = {
      "neovim/nvim-lspconfig",
    }
  },
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("lsp_lines").setup({
      })
      require("lsp_lines").toggle()
    end
  }
}
