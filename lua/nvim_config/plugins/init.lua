
-- Plugin List
return function(use)

    use {
        'wbthomason/packer.nvim',

        -- Telescope
        require 'nvim_config.plugins.completion',
        require 'nvim_config.plugins.colorschemes',
        require 'nvim_config.plugins.lsp',
        require 'nvim_config.plugins.multi_cursor',
        require 'nvim_config.plugins.statusline',
        require 'nvim_config.plugins.telescope',
        require 'nvim_config.plugins.tree',
        require 'nvim_config.plugins.treesitter',

        {
            'numToStr/Comment.nvim',
            config = function()
                require('Comment').setup()
            end
        },

        {
            'akinsho/bufferline.nvim', 
            requires = 'nvim-tree/nvim-web-devicons',
            config = function () 
                local utils = require 'nvim_config.utils'
                require("bufferline").setup()

                utils.nmapc('<A-Left>', 'BufferLineCyclePrev')
                utils.nmapc('<A-Right>', 'BufferLineCycleNext')
            end
        }, 

        {
            'goolord/alpha-nvim',
            requires = { 'nvim-tree/nvim-web-devicons' },
            config = function ()
                require'alpha'.setup(require'alpha.themes.startify'.config)
            end
        },

        'lukas-reineke/indent-blankline.nvim',
        'christoomey/vim-tmux-navigator',
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
    }
end
