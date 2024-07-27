require("bootstrap")
require("theme")

vim.g.mapleader = " "
require("lazy").setup(require("plugins"))
require("config")

require("post-mappings")
require("masking")

require("custom")

require("functions.up-to-date").check()

vim.cmd([[set rtp+=~/.config/nvim/custom_ffi]])
