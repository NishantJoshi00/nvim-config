require("bootstrap")

vim.g.mapleader = " "
require("pre-mappings")
require("lazy").setup("plugins")
require("theme")
require("post-mappings")

require('custom')
