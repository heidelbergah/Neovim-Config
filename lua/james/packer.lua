-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
   -- Packer can manage itself
   use 'wbthomason/packer.nvim'

   use {
	   'nvim-telescope/telescope.nvim', tag = '0.1.4',
	   -- or                            , branch = '0.1.x',
	   requires = { {'nvim-lua/plenary.nvim'} }
   }

   use { "ellisonleao/gruvbox.nvim" }
   use('EdenEast/nightfox.nvim')
   use({
      "neanias/everforest-nvim",
      -- Optional; default configuration will be used if setup isn't called.
      config = function()
         require("everforest").setup()
      end,
   })

   -- Vim Wiki
   use ('vimwiki/vimwiki')

   use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
   use('theprimeagen/harpoon')
   use('preservim/nerdtree')
   use('cohama/lexima.vim')

   -- Pywal integration
   use{ 'AlphaTechnolog/pywal.nvim', as = 'pywal' }
   -- use('cdelledonne/vim-cmake')
   use('antoinemadec/FixCursorHold.nvim')

   use {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v2.x',
      requires = {
         -- LSP Support
         {'neovim/nvim-lspconfig'},             -- Required
         {                                      -- Optional
         'williamboman/mason.nvim',
         run = function()
            pcall(vim.cmd, 'MasonUpdate')
         end,
      },
      {'williamboman/mason-lspconfig.nvim'}, -- Optional

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},     -- Required
      {'hrsh7th/cmp-nvim-lsp'}, -- Required
      {'L3MON4D3/LuaSnip'},     -- Required
   }
}
end)
