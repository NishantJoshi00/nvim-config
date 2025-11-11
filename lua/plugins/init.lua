return {
    {
        "tiagovla/tokyodark.nvim",
        config = require("plugins.config.themes"),
        dependencies = {
            "rebelot/kanagawa.nvim",
        },
    },
    {
        "lewis6991/gitsigns.nvim",
        event = "BufReadPre",
        config = require("plugins.config.gitsigns"),
    },
    { "cohama/lexima.vim" },
    { "preservim/vim-markdown" },
    {
        "neovim/nvim-lspconfig",
        event = "BufReadPre",
    },
    { "nvimtools/none-ls.nvim" },
    {
        "williamboman/mason.nvim",
        config = require("plugins.config.mason"),
    },
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp",
            "mason-org/mason.nvim",
            "folke/lazydev.nvim",
            "VidocqH/lsp-lens.nvim",
        },
        config = require("plugins.config.mason-lspconfig"),
    },
    {
        "VidocqH/lsp-lens.nvim",
        config = require("plugins.config.lsp-lens"),
    },
    {
        event = "VeryLazy",
        "jay-babu/mason-null-ls.nvim",
        dependencies = {
            "mason-org/mason.nvim",
            "nvimtools/none-ls.nvim",
            "mason-org/mason-lspconfig.nvim",
        },
        config = require("plugins.config.mason-null-ls"),
    },
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope.nvim", config = require("plugins.config.telescope"), dependencies = { "nvim-telescope/telescope-fzf-native.nvim" } },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = "make",
        config = require("plugins.config.telescope-fzf-native"),
    },
    { "nvim-tree/nvim-web-devicons" },
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
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-vsnip",
            "hrsh7th/vim-vsnip",
            "petertriho/cmp-git",
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
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = require("plugins.config.flash").opts,
        keys = require("plugins.config.flash").keys,
    },
    {
        "akinsho/bufferline.nvim",
        event = "VeryLazy",
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
        event = "VeryLazy",
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
        dependencies = { "nvim-lua/plenary.nvim" },
        config = require("plugins.config.crates"),
        event = "VeryLazy",
    },
    {
        "folke/persistence.nvim",
        event = "BufReadPre", -- this will only start session saving when an actual file was opened
        module = "persistence",
        config = require("plugins.config.persistence"),
    },
    {
        "sindrets/diffview.nvim",
        config = require("plugins.config.diffview"),
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        event = "VeryLazy",
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
    { "ckipp01/nvim-jenkinsfile-linter", dependencies = { "nvim-lua/plenary.nvim" } },
    { "folke/lazydev.nvim", opts = {}, event = "VeryLazy", ft = "lua" },
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
        event = "VeryLazy",
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
        enabled = true -- Sun Aug  4 12:34:49 PM IST 2024
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
    { "tpope/vim-abolish" },
    { "tpope/vim-fugitive" },
    {
        "andweeb/presence.nvim",
        config = require("plugins.config.presence"),
    },
    {
        "mbbill/undotree",
        config = require("plugins.config.undotree")
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
        opts = {},
    },
    {
        "chrisgrieser/nvim-lsp-endhints",
        event = "LspAttach",
        config = require("plugins.config.nvim-lsp-endhints"),
    },
    {
        'MagicDuck/grug-far.nvim',
        config = require("plugins.config.grug-far"),
    }
}
