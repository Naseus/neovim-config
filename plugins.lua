return require('packer').startup(function()
    -- Packer can manage itself
  use {
      'wbthomason/packer.nvim',
      'ellisonleao/gruvbox.nvim'
  }
end)
