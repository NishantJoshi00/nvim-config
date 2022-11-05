call plug#begin()

Plug 'tpope/vim-fugitive'
Plug 'cohama/lexima.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'preservim/vim-markdown'

if has("nvim")
	Plug 'williamboman/mason.nvim'
  Plug 'Mofiqul/vscode.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
  Plug 'nvim-lualine/lualine.nvim'
  Plug 'preservim/nerdtree'
  Plug 'morhetz/gruvbox'
  Plug 'folke/which-key.nvim'
  Plug 'neovim/nvim-lspconfig'
  Plug 'williamboman/mason-lspconfig.nvim'
  Plug 'ryanoasis/vim-devicons'

  " nvim-cmp
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-vsnip'
  Plug 'hrsh7th/vim-vsnip'
  Plug 'simrat39/rust-tools.nvim'

  Plug 'tiagovla/tokyodark.nvim'
  Plug 'startup-nvim/startup.nvim'
  Plug 'ggandor/lightspeed.nvim'
  Plug 'sindrets/diffview.nvim'
  Plug 'akinsho/bufferline.nvim'
  Plug 'stevearc/aerial.nvim'
  Plug 'akinsho/toggleterm.nvim'
endif

call plug#end()
