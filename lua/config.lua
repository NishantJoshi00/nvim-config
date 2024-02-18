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

---join
---@param list table<string, string>
---@return string
local function join(list)
  local output = nil
  for key, value in pairs(list) do
    if output == nil then
      output = key .. ":" .. value
    else
      output = output .. "," .. key .. ":" .. value
    end
  end
  return output
end

vim.o.list = true
vim.o.listchars = join({ trail = "·" })
