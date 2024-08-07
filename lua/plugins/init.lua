return {
  {
    "tiagovla/tokyodark.nvim",
    config = require("plugins.config.themes"),
    dependencies = {
      "catppuccin/nvim",
      "rebelot/kanagawa.nvim",
      "kvrohit/mellow.nvim",
      "dgox16/oldworld.nvim",
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
  {
    "mfussenegger/nvim-dap",
  },
  {
    "rcarriga/nvim-dap-ui",
    config = require("plugins.config.nvim-dap-ui"),
    dependencies = {
      "jay-babu/mason-nvim-dap.nvim",
    },
  },
  {
    "williamboman/mason.nvim",
    config = require("plugins.config.mason"),
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
      "NTBBloodbath/zig-tools.nvim"
    },
    config = require("plugins.config.mason-lspconfig"),
  },
  {
    "VidocqH/lsp-lens.nvim",
    config = require("plugins.config.lsp-lens"),
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
    config = require("plugins.config.mason-nvim-dap"),
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
  },
  { "nvim-lua/plenary.nvim" },
  { "nvim-telescope/telescope.nvim", config = require("plugins.config.telescope"), dependencies = { "folke/trouble.nvim" } },
  {
    "nvim-tree/nvim-tree.lua",
    config = require("plugins.config.nvim-tree"),
  },
  { "nvim-tree/nvim-web-devicons", dependencies = { "nvim-tree/nvim-tree.lua" } },
  {
    "folke/which-key.nvim",
    config = require("plugins.config.which-key"),
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
    "mrcjkb/rustaceanvim",
    version = '^4',
    ft = { 'rust' },
  },
  { "tpope/vim-commentary" },
  { "tpope/vim-surround" },
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
    keys = require("plugins.config.flash"),
  },
  {
    "akinsho/bufferline.nvim",
    config = require("plugins.config.bufferline"),
  },
  { "akinsho/toggleterm.nvim", config = require("plugins.config.toggleterm") },
  {
    "gelguy/wilder.nvim",
    config = require("plugins.config.wilder"),
  },
  {
    "rcarriga/nvim-notify",
    config = require("plugins.config.nvim-notify"),
  },
  {
    "rmagatti/goto-preview",
    config = require("plugins.config.goto-preview"),
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = require("plugins.config.indent-blankline"),
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
    config = require("plugins.config.fidget"),
  },
  {
    "MunifTanjim/nui.nvim",
  },
  {
    "MaximilianLloyd/ascii.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
  },
  {
    "saecki/crates.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = require("plugins.config.crates"),
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    module = "persistence",
    config = require("plugins.config.persistence"),
  },
  {
    "samueljoli/hurl.nvim",
    config = require("plugins.config.hurl"),
  },
  {
    "sindrets/diffview.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "ray-x/lsp_signature.nvim",
    config = require("plugins.config.lsp_signature"),
    dependencies = {
      "neovim/nvim-lspconfig",
    },
  },
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    config = require("plugins.config.lsp_lines"),
  },
  {
    "gyim/vim-boxdraw",
    enabled = false -- Sun Aug  4 12:33:59 PM IST 2024
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
    config = require("plugins.config.nvim-treesitter-context"),
  },
  { "github/copilot.vim",    config = require("plugins.config.copilot") },
  { "tpope/vim-speeddating" },
  { "LunarVim/bigfile.nvim", config = require("plugins.config.bigfile") },
  {
    "florentc/vim-tla",
    enabled = false -- Sun Aug  4 12:34:49 PM IST 2024
  },
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
    config = require("plugins.config.nerdicons"),
  },
  {
    'kosayoda/nvim-lightbulb',
    config = require("plugins.config.lightbulb")
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
  },
  {
    "lukas-reineke/headlines.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = require("plugins.config.headlines"),
  },
  {
    "tpope/vim-abolish"
  },
  {
    "tpope/vim-fugitive"
  },
  {
    "mattn/emmet-vim",
    enabled = false, -- Sun Aug  4 12:30:06 PM IST 2024
  },
  {
    "andweeb/presence.nvim",
    config = require("plugins.config.presence"),
  }
}
