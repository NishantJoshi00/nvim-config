return {
  {
    "tiagovla/tokyodark.nvim",
    config = require("plugins.config.themes"),
    dependencies = {
      "catppuccin/nvim",
      "rebelot/kanagawa.nvim",
      "kvrohit/mellow.nvim",
      -- "savq/melange-nvim",
      "Alexis12119/nightly.nvim",
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    config = require("plugins.config.gitsigns"),
  },
  { "cohama/lexima.vim" },
  { "preservim/vim-markdown" },
  { "neovim/nvim-lspconfig" },
  { "nvimtools/none-ls.nvim" },
  { "mfussenegger/nvim-dap" },
  {
    "rcarriga/nvim-dap-ui",
    config = function()
      vim.cmd([[vnoremap <c-;> <Cmd>lua require("dapui").eval()<CR>]])
    end,
    dependencies = {
      "jay-babu/mason-nvim-dap.nvim",
    },
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
      'mrcjkb/rustaceanvim',
      "williamboman/mason.nvim",
      "folke/neodev.nvim",
      "VidocqH/lsp-lens.nvim",
      "mrcjkb/haskell-tools.nvim",
    },
    config = require("plugins.config.mason-lspconfig"),
  },
  {
    "VidocqH/lsp-lens.nvim",
    config = function()
      require("lsp-lens").setup({})
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = require("plugins.config.mason-null-ls"),
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    config = function()
      require("plugins.config.nvim-dap")()
      require("mason-nvim-dap").setup()
    end,
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
  },
  { "nvim-lua/plenary.nvim" },
  { "nvim-telescope/telescope.nvim", config = require("plugins.config.telescope") },
  {
    "nvim-tree/nvim-tree.lua",
    config = require("plugins.config.nvim-tree"),
  },
  { "nvim-tree/nvim-web-devicons", dependencies = { "nvim-tree/nvim-tree.lua" } },
  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup()
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
      "hrsh7th/vim-vsnip",
    },
    config = require("plugins.config.nvim-cmp"),
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^4',
    ft = { 'rust' },
  },
  { "tpope/vim-commentary" },
  {
    "nvim-treesitter/nvim-treesitter",
    config = require("plugins.config.nvim-treesitter"),
    build = ":TSUpdate",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-treesitter/playground",
    },
  },

  {
    "glepnir/dashboard-nvim",
    event = "VimEnter",
    dependencies = {
      "MaximilianLloyd/ascii.nvim",
    },
    config = require("plugins.config.dashboard-nvim"),
  },
  -- { "ggandor/lightspeed.nvim" },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = require("plugins.config.flash").key,
  },
  {
    "akinsho/bufferline.nvim",
    config = function()
      require("bufferline").setup()
    end,
  },
  { "akinsho/toggleterm.nvim", config = require("plugins.config.toggleterm") },
  {
    "ellisonleao/glow.nvim",
    config = function()
      require("glow").setup({})
    end,
    enabled = function()
      return not require("functions").disabled_on({ "win32" })
    end,
  },
  {
    "gelguy/wilder.nvim",
    config = function()
      require("wilder").setup({ modes = { ":", "/", "?" } })
    end,
  },
  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup({
        render = "compact",
      })

      vim.notify = require("notify")

      require("functions").quoter()
    end,
  },
  {
    "rmagatti/goto-preview",
    config = require("plugins.config.goto-preview"),
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      -- require("indent_blankline").setup({
      --   show_current_context = true,
      --   show_current_context_start = true,
      -- })
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
  { "airblade/vim-gitgutter" },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = require("plugins.config.lualine"),
  },
  {
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = "LspAttach",
    config = function()
      require("fidget").setup({
        text = {
          spinner = "dots",
        },
      })
    end,
  },
  {
    -- Notion Integration for NeoVim
    "chrsm/impulse.nvim",
    enabled = false,
    config = function()
      require("impulse").setup()
    end,
  },
  {
    "MunifTanjim/nui.nvim",
    config = function() end,
  },
  {
    "MaximilianLloyd/ascii.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
  },
  {
    enabled = false,
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = require("plugins.config.noice"),
  },
  {
    enabled = false,
    "folke/twilight.nvim",
    config = function()
      require("twilight").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      })
    end,
  },
  {
    "saecki/crates.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crates").setup({})
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
    end,
  },
  -- {
  --   -- enabled = false,
  --   "poljar/typos.nvim",
  --   config = function()
  --     require("typos").setup()
  --   end,
  -- },
  {
    "sindrets/diffview.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "edluffy/hologram.nvim",
    enabled = function()
      return not require("functions").disabled_on({ "win32" })
    end,
    config = function()
      require("hologram").setup({})
    end,
  },
  {
    "giusgad/pets.nvim",
    enabled = function()
      return not require("functions").disabled_on({ "win32" })
    end,
    dependencies = {
      "edluffy/hologram.nvim",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("pets").setup({})
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("lsp_signature").setup()
    end,
    dependencies = {
      "neovim/nvim-lspconfig",
    },
  },
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("lsp_lines").setup()
      vim.diagnostic.config({ virtual_lines = false })
    end,
  },
  {
    enabled = false,
    "jbyuki/instant.nvim", -- This doesn't work as expected
    config = function()
      vim.cmd([[let g:instant_username = "nishant"]])
    end,
  },
  {
    "gyim/vim-boxdraw",
  },
  { "ckipp01/nvim-jenkinsfile-linter", dependencies = { "nvim-lua/plenary.nvim" } },
  { "folke/neodev.nvim",               opts = {} },
  {
    "stevearc/dressing.nvim",
    opts = {},
    config = require("plugins.config.dressing"),
  },
  {
    "stevearc/overseer.nvim",
    opts = {},
    config = require("plugins.config.overseer"),
  },
  {
    "stevearc/oil.nvim",
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = require("plugins.config.oil"),
  },
  {
    "willothy/flatten.nvim",
    config = true,
    -- or pass configuration with
    -- opts = {  }
    -- Ensure that it runs first to minimize delay when opening file from terminal
    lazy = false,
    priority = 1001,
  },
  {
    "mrcjkb/haskell-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    branch = "2.x.x", -- Recommended
    ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup {
        enable = true,
        separator = "─"
      }
    end
  },
  { "github/copilot.vim",    config = require("plugins.config.copilot") },
  { "tpope/vim-speeddating" },
  { "LunarVim/bigfile.nvim", config = function() require("bigfile").config({}) end },
  { "florentc/vim-tla" },
  {
    'nvim-focus/focus.nvim',
    version = '*',
    config = require("plugins.config.focus")
  },
  {
    "LunarVim/breadcrumbs.nvim",
    dependencies = {
      "SmiteshP/nvim-navic",
    },
    config = require("plugins.config.breadcrumbs"),
  },
  {
    "nvimdev/nerdicons.nvim",
    cmd = "NerdIcons",
    config = function()
      require("nerdicons").setup({
        down = '<Down>',
        up = '<Up>',
        copy = '<Right>'
      })
    end,
  },
  {
    'kosayoda/nvim-lightbulb',
    config = function()
      require("nvim-lightbulb").setup({ autocmd = { enabled = true }, sign = { text = "" } })
    end
  }
}
