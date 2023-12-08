require("bootstrap")

vim.g.mapleader = " "
require("pre-mappings")
-- if not require("lazy.core.loader").init_done then
require("lazy").setup("plugins")
-- end
require("config")

require("theme")
require("post-mappings")
require("masking")

require("custom")

vim.cmd([[set rtp+=~/.config/nvim/custom_ffi]])
