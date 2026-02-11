-- Core Vim Options
-- IMPORTANT: This file should load BEFORE plugins for proper initialization

-- UI & Display
vim.o.background = "dark"
vim.o.termguicolors = true
vim.o.winborder = "rounded"
vim.o.cursorline = true
vim.o.number = true
vim.o.showmode = false
vim.o.title = true
vim.o.scrolloff = 4

-- Editing Behavior
vim.o.clipboard = "unnamedplus"
vim.o.completeopt = "menuone,noselect"
vim.o.inccommand = "split"
vim.o.mouse = "a"

-- Indentation
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.smartindent = true

-- Splits
vim.o.splitbelow = true
vim.o.splitright = true

-- Timing
vim.o.ttimeoutlen = 0
vim.o.updatetime = 300

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true

-- File Handling
vim.o.undofile = true
vim.o.undodir = vim.fn.stdpath("cache") .. "/undodir"
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false

-- Performance
vim.o.synmaxcol = 300

-- Grep (use ripgrep if available)
if vim.fn.executable("rg") == 1 then
  vim.o.grepprg = "rg --vimgrep --no-heading --smart-case"
  vim.o.grepformat = "%f:%l:%c:%m"
end

-- UI Characters
vim.o.list = true
vim.opt.listchars = { trail = "·", tab = "▸ " }
vim.o.fillchars = "eob: ,fold: ,foldopen:▾,foldsep: ,foldclose:▸"

-- Wildmenu
vim.o.wildmode = "longest:full,full"

-- Folding (disabled by default)
vim.o.foldenable = false
