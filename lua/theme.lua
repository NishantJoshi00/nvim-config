-- Core Vim Options
-- IMPORTANT: This file should load BEFORE plugins for proper initialization

-- === UI & Display ===
vim.o.background = "dark"
vim.o.termguicolors = true
vim.o.cursorline = true
vim.o.number = true
-- vim.o.relativenumber = true  -- Uncomment if you want relative line numbers
vim.o.showmode = false  -- Mode shown in lualine instead
vim.o.title = true
vim.o.scrolloff = 4  -- Keep 4 lines visible above/below cursor

-- === Editing Behavior ===
vim.o.clipboard = "unnamedplus"
vim.o.completeopt = "menuone,noselect"  -- Better completion experience
vim.o.inccommand = "split"  -- Live preview of substitutions
vim.o.mouse = "a"

-- === Indentation ===
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.smartindent = true

-- === Splits ===
vim.o.splitbelow = true
vim.o.splitright = true

-- === Timing ===
vim.o.ttimeoutlen = 0
vim.o.updatetime = 300  -- Faster completion and git updates

-- === Search ===
vim.o.ignorecase = true
vim.o.smartcase = true  -- Case-sensitive if uppercase is used

-- === File Handling ===
vim.o.undofile = true
vim.o.undodir = vim.fn.stdpath("cache") .. "/undodir"
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false  -- Prefer undofile over swapfile

-- === Performance ===
vim.o.lazyredraw = true  -- Don't redraw during macros
vim.o.synmaxcol = 300  -- Don't syntax highlight very long lines

-- === Grep Integration (use ripgrep if available) ===
if vim.fn.executable("rg") == 1 then
  vim.o.grepprg = "rg --vimgrep --no-heading --smart-case"
  vim.o.grepformat = "%f:%l:%c:%m"
end

-- === UI Characters ===
vim.o.list = true
vim.o.listchars = require("utils").join({ trail = "·", tab = "▸ " })
vim.o.fillchars = "eob: ,fold: ,foldopen:▾,foldsep: ,foldclose:▸"

-- === Wildmenu ===
vim.o.wildmenu = true
vim.o.wildmode = "longest:full,full"

-- === Folding (disabled by default) ===
vim.o.foldenable = false

-- === Enable filetype detection ===
vim.cmd([[filetype plugin indent on]])

-- === Highlight Customization ===
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#181616", fg = "#c5c9c5" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#181616" })
