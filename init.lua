require("bootstrap")

vim.g.mapleader = " "
require("config")
require("pre-mappings")
-- if not require("lazy.core.loader").init_done then
require("lazy").setup("plugins")
-- end
require("theme")
require("post-mappings")

require('custom')
