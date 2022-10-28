return require('packer').startup(function()
    use {
        'romgrk/barbar.nvim',
        requires = { 'kyazdani42/nvim-web-devicons' }
    }
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
        'folke/todo-comments.nvim',
    }
end)
