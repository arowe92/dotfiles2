-- Plugin List
return function(use)

    use {
        'wbthomason/packer.nvim',

        -- Configured Plugins
        require 'nvim_config.plugins.completion',
        require 'nvim_config.plugins.colorschemes',
        require 'nvim_config.plugins.lsp',
        require 'nvim_config.plugins.multi_cursor',
        require 'nvim_config.plugins.statusline',
        require 'nvim_config.plugins.telescope',
        require 'nvim_config.plugins.tree',
        require 'nvim_config.plugins.treesitter',

        -- Simple Plugins
        'lukas-reineke/indent-blankline.nvim',
        'christoomey/vim-tmux-navigator',
        'roxma/vim-tmux-clipboard',
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',

        -- Commenting
        {
            'numToStr/Comment.nvim',
            config = function()
                require('Comment').setup({
                    toggler = {
                        line = '<m-/>',
                        block = '<m-?>',
                    },
                })

                -- Commenting
                vim.keymap.set('x', '<m-?>', '<Plug>(comment_toggle_blockwise_visual)')
                vim.keymap.set('x', '<m-/>', '<Plug>(comment_toggle_linewise_visual)')
            end

        },

        -- BufferLine
        {
            'akinsho/bufferline.nvim',
            requires = 'nvim-tree/nvim-web-devicons',
            config = function()
                local utils = require 'nvim_config.utils'
                require('bufferline').setup({
                    options = {
                    }
                })

                utils.nmapc('<A-Left>', 'BufferLineCyclePrev')
                utils.nmapc('<A-Right>', 'BufferLineCycleNext')
            end
        },

        -- Startify
        {
            'goolord/alpha-nvim',
            requires = { 'nvim-tree/nvim-web-devicons' },
            config = function()
                require 'alpha'.setup(require 'alpha.themes.startify'.config)
            end
        },

        -- Surround / Sandwich
        {
            'ur4ltz/surround.nvim',
            config = function()
                require 'surround'.setup { mappings_style = 'sandwich' }
            end
        },


        -- FZF
        {
            'junegunn/fzf',
            run = ':call fzf#install()',
            config = function()
                -- vim.g.fzf_layout = { tmux = '-p80%,60%' }
            end
        },
        'junegunn/fzf.vim',

        -- Git Signs
        {
            'lewis6991/gitsigns.nvim',
            config = function()
                require('gitsigns').setup()

                local utils = require 'nvim_config.utils'
                utils.nmapc('<leader>gu', 'Gitsigns reset_hunk')
                utils.nmapc('<leader>ga', 'Gitsigns stage_hunk')
                utils.nmapc('<leader>gA', 'Gitsigns undo_stage_hunk')
                utils.nmapc('<leader>gb', 'Gitsigns blame_line')
                utils.nmapc('<leader>gr', 'Gitsigns refresh')
                utils.nmapc('<leader>gq', 'Gitsigns setqflist')
                utils.nmapc('<leader>gp', 'Gitsigns preview_hunk_inline')
                utils.nmapc('<leader>gP', 'Gitsigns preview_hunk')
                utils.nmapc(']g', 'Gitsigns next_hunk')
                utils.nmapc('[g', 'Gitsigns prev_hunk')
            end
        },

        -- Hop
        {
            'phaazon/hop.nvim',
            commit = "caaccee",
            config = function()
                local utils = require 'nvim_config.utils'
                local hop = require 'hop'
                hop.setup()

                utils.nmapc('<leader>j', 'HopLineAC')
                utils.nmapc('<leader>k', 'HopLineBC')
            end
        },

        {
            'rhysd/clever-f.vim',
            config = function()
                vim.g.clever_f_across_no_line = true
            end
        },

        {
            "L3MON4D3/LuaSnip",
            config = function()
                local DOT = require("nvim_config.env").DOTFILE_PATH;

                require("luasnip.loaders.from_vscode").lazy_load({
                    paths = { DOT .. '/.config/snippets/' }
                })
            end
        }
    }
end
