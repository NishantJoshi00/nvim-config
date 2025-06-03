vim.g.mapleader = " "

require("bootstrap")

require("lazy").setup(require("plugins"))

require("config")
require("mappings")
require("masking")
require("custom")



require("theme")
require("functions.up-to-date").check()
