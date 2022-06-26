return require('packer').startup(function()
  use {
    'wbthomason/packer.nvim',
    'ellisonleao/gruvbox.nvim',
    'neovim/nvim-lspconfig',
    'williamboman/nvim-lsp-installer',
    'nvim-treesitter/nvim-treesitter',
    'ms-jpq/coq_nvim',
    'ms-jpq/coq.artifacts',
    'ms-jpq/coq.thirdparty',
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  }
end)
