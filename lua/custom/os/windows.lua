require("utils").gate("win32", function()
  vim.o.shell = "powershell"
  vim.o.shellcmdflag = "-c"
  vim.o.shellquote = '"'
  vim.o.shellxquote = ""
  -- Note: toggleterm.setup() is called in plugins/config/toggleterm.lua
  -- and it already uses vim.o.shell, so no need to call setup() again here
  if vim.g.neovide then
    vim.g.neovide_scale_factor = 0.65
    vim.g.neovide_fullscreen = true
  end
end)
