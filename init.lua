-- Enable bytecode caching for faster startup (Neovim 0.10+)
if vim.loader then
  vim.loader.enable()
end

-- Set leader key FIRST (before any plugins load)
vim.g.mapleader = " "

-- Load core options BEFORE plugins
require("theme")

-- Bootstrap lazy.nvim plugin manager
require("bootstrap")

-- Load all plugins
require("lazy").setup(require("plugins"))

-- Load configuration after plugins
require("config")
require("mappings")
require("masking")
require("custom")

-- Check for config updates
require("functions.up-to-date").check()
