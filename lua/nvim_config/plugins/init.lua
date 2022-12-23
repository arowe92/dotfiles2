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
        {
            'rcarriga/nvim-dap-ui',
            requires = { 'mfussenegger/nvim-dap' },
            config = function()
                local dap = require('dap')
                dap.adapters.cppdbg = {
                    id = 'cppdbg',
                    type = 'executable',
                    command = '/home/arowe/cpptools/extension/debugAdapters/bin/OpenDebugAD7',
                }

                dap.configurations.cpp = {
                    {
                        name = "Launch file",
                        type = "cppdbg",
                        request = "launch",
                        program = function()
                            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                        end,
                        cwd = '${workspaceFolder}',
                        stopAtEntry = true,
                    },
                }

                require("dapui").setup()
            end
        },

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
                        truncate_names = false
                    }
                })

                utils.nmapc('<A-Left>', 'BufferLineCyclePrev')
                utils.nmapc('<A-Right>', 'BufferLineCycleNext')
                utils.nmapc('<leader><A-Left>', 'BufferLineMovePrev')
                utils.nmapc('<leader><A-Right>', 'BufferLineMoveNext')
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
                vim.g.fzf_layout = { tmux = '-p80%,60%' }

                vim.g.fzf_colors = {
                    fg = { 'fg', 'Normal' },
                    bg = { 'bg', 'Normal' },
                    hl = { 'fg', 'Comment' },
                    ["fg+"] = { 'fg', 'CursorLine', 'CursorColumn', 'Normal' },
                    ["bg+"] = { 'bg', 'CursorLine', 'CursorColumn' },
                    ["hl+"] = { 'fg', 'Statement' },
                    info = { 'fg', 'PreProc' },
                    border = { 'fg', 'Ignore' },
                    prompt = { 'fg', 'Conditional' },
                    pointer = { 'fg', 'Exception' },
                    marker = { 'fg', 'Keyword' },
                    spinner = { 'fg', 'Label' },
                    header = { 'fg', 'Comment' }
                }

                require('nvim_config.env').MODULES.fzf = true
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

                utils.mapc('<leader>j', 'HopVerticalAC')
                utils.mapc('<leader>k', 'HopVerticalBC')
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
        },

        {
            "nvim-zh/colorful-winsep.nvim",
            config = function()
                require('colorful-winsep').setup({
                    symbols = { "━", "┃", "┏", "┓", "┗", "┛" },
                })
            end
        },

        {
            "petertriho/nvim-scrollbar",
            config = function()
                require("scrollbar").setup()
            end
        },

        {
            'tpope/vim-fugitive',
            config = function()
                vim.cmd [[nnoremap <A-g> :Git ]]
            end
        },
        {
            'takac/vim-hardtime',
            config = function()
                -- vim.g.hardtime_default_on = true
            end
        }
    }
end
