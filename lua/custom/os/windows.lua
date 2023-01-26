if vim.fn.has('win32') then
  -- set shell=powershell
  -- set shellcmdflag=-c
  -- set shellquote=\"
  -- set shellxquote=
  vim.o.shell = "powershell"
  vim.o.shellcmdflag = "-c"
  vim.o.shellquote = "\""
  vim.o.shellxquote = ""
  require('toggleterm').setup {
    shell = vim.o.shell
  }
end
