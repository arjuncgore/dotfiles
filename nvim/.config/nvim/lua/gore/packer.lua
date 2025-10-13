-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.6', -- or latest
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('telescope').setup {
                defaults = {
                    file_ignore_patterns = {
                        "node_modules",
                        "%.git/",
                        "dist/",
                        "build/",
                    },
                },
            }
        end,
    }

    -- Colorscheme
    use { "catppuccin/nvim", as = "catppuccin" }

    -- Treesitter
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'nvim-treesitter/playground'

    -- Neo-tree
    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons", -- optional, but recommended
        }
    }

    -- Undo history
    use 'mbbill/undotree'

    -- Git integration
    use 'tpope/vim-fugitive'

    -- Noice visuals
    use 'folke/noice.nvim'

    -- Which-key help message
    use "folke/which-key.nvim"

    -- Harpoon file switching
    use "theprimeagen/harpoon"

    -- Mini Icons
    use {
        'echasnovski/mini.icons',
        config = function()
            require('mini.icons').setup()
        end
    }

    -- === LSP + Completion ===
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-cmdline' },

            -- Snippets (optional but recommended)
            { 'L3MON4D3/LuaSnip' },
            { 'saadparwaiz1/cmp_luasnip' },
        }
    }
end)
