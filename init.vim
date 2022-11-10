set encoding=UTF-8


" windows specific
if has("win32")
  set shell=powershell
  set shellcmdflag=-c
  set shellquote=\"
  set shellxquote=
endif

runtime plug.vim
runtime theme.vim
runtime config.vim
runtime maps.vim
