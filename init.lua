require("bootstrap")
require("theme")

vim.g.mapleader = " "
require("pre-mappings")
-- if not require("lazy.core.loader").init_done then
require("lazy").setup(require("plugins"))
-- end
require("config")

require("post-mappings")
require("masking")

require("custom")

vim.cmd([[set rtp+=~/.config/nvim/custom_ffi]])
