-- Options

vim.o.background = "dark"
vim.o.clipboard = "unnamedplus"
vim.o.completeopt = "noinsert,menuone,noselect"
vim.o.cursorline = true
vim.o.hidden = true
vim.o.inccommand = "split"
vim.o.mouse = "a"
vim.o.number = true
vim.o.rnu = true
vim.o.splitbelow = "splitright"
vim.o.title = true
vim.o.ttimeoutlen = 0
vim.o.wildmenu = true

-- Tabs size
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2

vim.cmd [[filetype plugin indent on]]
vim.cmd [[syntax on]]
vim.cmd [[highlight IndentBlanklineChar guifg=#202020 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineContextChar guifg=#505050 gui=nocombine]]
