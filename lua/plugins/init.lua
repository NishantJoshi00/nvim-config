return {
    {
        "rebelot/kanagawa.nvim",
        priority = 1000, -- Load theme early
        config = require("plugins.config.themes"),
    },
    {
        "lewis6991/gitsigns.nvim",
        event = "BufReadPre",
        config = require("plugins.config.gitsigns"),
    },
    { "cohama/lexima.vim" },
    { "preservim/vim-markdown", ft = "markdown" },
    {
        "neovim/nvim-lspconfig",
        event = "BufReadPre",
    },
    {
        "williamboman/mason.nvim",
        config = require("plugins.config.mason"),
    },
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            "saghen/blink.cmp",
            "mason-org/mason.nvim",
            "folke/lazydev.nvim",
        },
        config = require("plugins.config.mason-lspconfig"),
    },
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope.nvim", cmd = "Telescope", config = require("plugins.config.telescope"), dependencies = { "nvim-telescope/telescope-fzf-native.nvim" } },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = "make",
        lazy = true,
        config = require("plugins.config.telescope-fzf-native"),
    },
    { "nvim-tree/nvim-web-devicons" },
    {
        "folke/which-key.nvim",
        config = require("plugins.config.which-key"),
    },

    {
        "saghen/blink.cmp",
        version = "1.*",
        event = { "InsertEnter", "CmdlineEnter" },
        config = require("plugins.config.blink-cmp"),
    },
    {
        "mrcjkb/rustaceanvim",
        version = '^4',
        ft = { 'rust' },
    },
    { "tpope/vim-surround" },
    {
        "nvim-treesitter/nvim-treesitter",
        config = require("plugins.config.nvim-treesitter"),
        build = ":TSUpdate",
        dependencies = {
            "neovim/nvim-lspconfig",
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
    { "akinsho/toggleterm.nvim",         cmd = { "ToggleTerm", "ToggleTermToggleAll" }, keys = { { "<c-t>", mode = { "n", "i", "t" } } }, config = require("plugins.config.toggleterm") },
    {
        "rcarriga/nvim-notify",
        event = "VeryLazy",
        config = require("plugins.config.nvim-notify"),
    },
    {
        "rmagatti/goto-preview",
        event = "LspAttach",
        config = require("plugins.config.goto-preview"),
    },

    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        config = require("plugins.config.lualine"),
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
        config = require("plugins.config.persistence"),
    },
    {
        "sindrets/diffview.nvim",
        config = require("plugins.config.diffview"),
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    },
    { "ckipp01/nvim-jenkinsfile-linter", dependencies = { "nvim-lua/plenary.nvim" } },
    { "folke/lazydev.nvim",              opts = {},                                    event = "VeryLazy", ft = "lua" },
    {
        "stevearc/dressing.nvim",
        event = "VeryLazy",
        opts = {},
        config = require("plugins.config.dressing"),
    },
    {
        "stevearc/overseer.nvim",
        enabled = false,
        opts = {},
        config = require("plugins.config.overseer"),
    },
    {
        "stevearc/oil.nvim",
        opts = {},
        -- Optional dependencies
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = require("plugins.config.oil"),
        cmd = "Oil",
        keys = {
            { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
        },
    },
    {
        'stevearc/quicker.nvim',
        ft = "qf",
        ---@module "quicker"
        ---@type quicker.SetupOptions
        opts = {},
        config = require("plugins.config.quicker"),
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
    { "github/copilot.vim", enabled = false,    config = require("plugins.config.copilot") },
    { "tpope/vim-speeddating" },
    { "LunarVim/bigfile.nvim", config = require("plugins.config.bigfile") },
    {
        "florentc/vim-tla",
        enabled = true -- Sun Aug  4 12:34:49 PM IST 2024
    },
    {
        'nvim-focus/focus.nvim',
        version = '*',
        event = "VeryLazy",
        config = require("plugins.config.focus")
    },
    {
        "LunarVim/breadcrumbs.nvim",
        event = "LspAttach",
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
        event = "LspAttach",
        config = require("plugins.config.lightbulb")
    },
    { "tpope/vim-abolish" },
    { "tpope/vim-fugitive" },
    {
        "andweeb/presence.nvim",
        event = "VeryLazy",
        config = require("plugins.config.presence"),
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
        ft = "markdown",
        config = require("plugins.config.render-markdown"),
    },
    {
        "chrisgrieser/nvim-lsp-endhints",
        event = "LspAttach",
        config = require("plugins.config.nvim-lsp-endhints"),
    },
    {
        'MagicDuck/grug-far.nvim',
        cmd = "GrugFar",
        config = require("plugins.config.grug-far"),
    }
}
