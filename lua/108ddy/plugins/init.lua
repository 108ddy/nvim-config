vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use { 'wbthomason/packer.nvim' }

    use { 'nvim-lua/plenary.nvim' }

    -- Diff file
    use {
        'sindrets/diffview.nvim',
        requires = 'nvim-lua/plenary.nvim',
    }

    -- Telescope and Fzf
    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make',
    }
    use { 'nvim-telescope/telescope.nvim' }

    -- Syntax highlighting
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
    }

    -- LSP
    use { 'neovim/nvim-lspconfig' }

    -- Colorschemes
    use { 'folke/tokyonight.nvim' }
    use { 'doums/darcula' }
end)

