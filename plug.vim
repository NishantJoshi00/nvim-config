call plug#begin()

Plug 'tpope/vim-fugitive' " A Git wrapper
" Plug 'cohama/lexima.vim' " Auto-close parenthesis
Plug 'preservim/vim-markdown' " markdown support for vim

if has("nvim")
	Plug 'williamboman/mason.nvim' " LSP|DAP|Linter Installer|Manager 

  Plug 'nvim-lua/plenary.nvim' " Extending lua with async
  Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' } " Fuzzy Finder
  Plug 'nvim-lualine/lualine.nvim' " configurable statusline (change!)
  Plug 'preservim/nerdtree' " Explorer tree from the opened dir
  Plug 'folke/which-key.nvim' " popup for identifying what keys do
  Plug 'neovim/nvim-lspconfig' " native-lsp server for running language specific lsps
  Plug 'williamboman/mason-lspconfig.nvim' " Integration between mason and nvim-lspconfig
  Plug 'ryanoasis/vim-devicons' " Icons library from vim requires nerd font

  " nvim-cmp
  Plug 'hrsh7th/cmp-nvim-lsp' " completion result provider
  Plug 'hrsh7th/cmp-buffer' " `nvim-cmp` dependency (providing buffer)
  Plug 'hrsh7th/cmp-path' " `nvim-cmp` dependency (providing filesystem info)
  Plug 'hrsh7th/cmp-cmdline' " `nvim-cmp` dependency (providing vim command line info)
  Plug 'hrsh7th/nvim-cmp' " completion engine plugin written in lua
  Plug 'hrsh7th/cmp-vsnip' " providing completion with snips
  Plug 'hrsh7th/vim-vsnip' " Providing different snips
  Plug 'simrat39/rust-tools.nvim' " Added rust functionality to rust-analyzer

  Plug 'tiagovla/tokyodark.nvim' " Theme
  Plug 'startup-nvim/startup.nvim' " dashboard
  Plug 'ggandor/lightspeed.nvim' " faster search through text
  " Plug 'sindrets/diffview.nvim'
  Plug 'akinsho/bufferline.nvim' " Bufferline on the top for files
  Plug 'stevearc/aerial.nvim' " A code outline window for skimming and quick navigation
  Plug 'akinsho/toggleterm.nvim', {'tag' : '*'} " To toggle terminal in vim session
  Plug 'ellisonleao/glow.nvim' " Rendering for markdown
  Plug 'gelguy/wilder.nvim' " better experience in commandline
  Plug 'rcarriga/nvim-notify' " Notification popup in vim using simple functions
endif

call plug#end()
