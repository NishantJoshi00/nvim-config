require("bootstrap")
require("theme")

vim.g.mapleader = " "
require("lazy").setup(require("plugins"))
require("config")

require("post-mappings")
require("masking")

require("custom")

require("functions.up-to-date").check()

vim.opt.rtp:prepend("~/.config/nvim/ffi")

require("telemetry.keybinds")
