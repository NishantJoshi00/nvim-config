vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { update_in_insert = true })

vim.cmd([[set nofoldenable]])
vim.o.updatetime = 300

vim.o.undodir = vim.fn.stdpath("cache") .. "/undodir"
vim.o.undofile = true
-- vim.cmd([[set cursorline]])

vim.o.cursorline = true

vim.o.scrolloff = 4

vim.cmd([[highlight IndentBlanklineChar guifg=#202020 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineContextChar guifg=#505050 gui=nocombine]])
vim.cmd([[highlight Cursorline gui=underline cterm=underline guisp=gray guibg=NONE]])

-- vim.o.list = true

vim.o.list = true
vim.o.listchars = require("utils").join({ trail = "·", tab = "▸ " })
