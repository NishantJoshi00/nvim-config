vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { update_in_insert = true })

vim.cmd([[set nofoldenable]])
vim.cmd([[set termguicolors]])
vim.o.updatetime = 300

vim.o.undodir = vim.fn.stdpath("cache") .. "/undodir"
vim.o.undofile = true
-- vim.cmd([[set cursorline]])

vim.o.cursorline = true


-- vim.o.highlight
