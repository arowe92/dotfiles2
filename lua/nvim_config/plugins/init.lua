-- Plugin List
return {
    -- Configured Plugins
    require 'nvim_config.plugins.completion',
    require 'nvim_config.plugins.colorschemes',
    require 'nvim_config.plugins.lsp',
    require 'nvim_config.plugins.multi_cursor',
    require 'nvim_config.plugins.statusline',
    require 'nvim_config.plugins.telescope',
    require 'nvim_config.plugins.tree',
    require 'nvim_config.plugins.treesitter',


    -- Display Marks
    { 'kshenoy/vim-signature' },
    { 'lukas-reineke/indent-blankline.nvim', },

    -- Tmux
    'roxma/vim-tmux-clipboard',
    {
        'christoomey/vim-tmux-navigator',
        keys = {
            { "<C-h>" },
            { "<C-j>" },
            { "<C-k>" },
            { "<C-l>" },
        },
        config = function()
            vim.cmd("noremap <silent> <C-h> :<C-U>TmuxNavigateLeft<cr>")
            vim.cmd("noremap <silent> <C-j> :<C-U>TmuxNavigateDown<cr>")
            vim.cmd("noremap <silent> <C-k> :<C-U>TmuxNavigateUp<cr>")
            vim.cmd("noremap <silent> <C-l> :<C-U>TmuxNavigateRight<cr>")
        end
    },

    -- Commenting
    {
        'numToStr/Comment.nvim',
        keys = {
            { "<m-/>", mode={'n', 'x'} },
            { "<m-?>", mode={'n', 'x'} }
        },
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
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            local utils = require 'nvim_config.utils'
            require('bufferline').setup({
                options = {
                    truncate_names = false
                },
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
        dependencies = { 'nvim-tree/nvim-web-devicons' },
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

    {
        "tpope/vim-repeat",
    },


    -- FZF
    {
        'junegunn/fzf',
        build = ':call fzf#install()',
        cmd = {
            "Files",
            "Rg",
            "Include"
        },
        commit = "9cb7a364a31bdb882d873807774bdcf6fad0c9e4",
        dependencies = {
            {
                'junegunn/fzf.vim',
                commit = "d6aa21476b2854694e6aa7b0941b8992a906c5ec",
            }
        },
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

    -- Git Signs
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup({
                signcolumn = false,
                numhl      = true,
            })

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
        keys = {
            " j",
            " k"
        },
        cmd = { "HopVerticalAC", "HopVerticalBC" },
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
        keys = { "f", "F", "t", "T" },
        config = function()
            vim.g.clever_f_across_no_line = true
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
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },
        config = function()
            require("scrollbar").setup({
                handlers = {
                    gitsigns = true,
                    search = true,
                }
            })
        end
    },

    {
        'tpope/vim-fugitive',
        cmd = { "Git", "Gedit" },
        keys = {
            { '<A-g>', desc="Git" }
        },
        config = function()
            vim.keymap.set('n', '<A-g>', ':Git ')
        end
    },

    {
        'AndrewRadev/sideways.vim',
        keys = {
            "<M-<>",
            "<M->>",
        },
        config = function()
            local nmapc = require 'nvim_config.utils'.nmapc

            nmapc('<M-<>', 'SidewaysLeft')
            nmapc('<M->>', 'SidewaysRight')
        end
    },

    -- Highlight Git Conflicts
    {
        'akinsho/git-conflict.nvim',
        tag = "*",
        config = function()
            require('git-conflict').setup({ default_mappings = false })
            vim.keymap.set('n', 'co', '<Plug>(git-conflict-ours)')
            vim.keymap.set('n', 'ct', '<Plug>(git-conflict-theirs)')
            vim.keymap.set('n', 'cb', '<Plug>(git-conflict-both)')
            vim.keymap.set('n', 'c0', '<Plug>(git-conflict-none)')
            vim.keymap.set('n', ']x', '<Plug>(git-conflict-prev-conflict)')
            vim.keymap.set('n', '[x', '<Plug>(git-conflict-next-conflict)')
        end
    },

    -- Formatting through LSP
    {
        'jose-elias-alvarez/null-ls.nvim',
        keys = {
            { "<A-F>" },
            { "<S-A-f>" },
        },
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.autopep8,
                    null_ls.builtins.formatting.prettier,
                    null_ls.builtins.formatting.buf,
                },
            })
        end
    },

    -- Code Actions
    {
        'weilbith/nvim-code-action-menu',
        cmd = { "CodeActionMenu" },
        init = function()
            local nmapc = require 'nvim_config.utils'.nmapc
            nmapc('<space>ca', 'CodeActionMenu')
        end
    },

    -- "MiniMap on Right"
    {
        'gorbit99/codewindow.nvim',
        keys = {
            { "<space>mm" },
        },
        config = function()
            local codewindow = require('codewindow')
            codewindow.setup({
                auto_enable = false,
                window_border = 'none',
                minimap_width = 16,
                width_multiplier = 4
            })
            vim.keymap.set('n', '<leader>mm', function()
                codewindow.toggle_minimap()
            end)
        end,
    },

    -- Chat GPT
    {
        "robitx/gp.nvim",

        cmd = {
            "GpRewrite",
            "GpAppend",
            "GpPrepend",
            "GpImplement",
            "GpContext",
            "GpChatNew",
            "GpNextAgent",
        },

        config = function()
            require("gp").setup()
        end,

        init = function()
            local utils = require 'nvim_config.utils'
            utils.mapc('<leader>tt', 'GpRewrite')
            utils.mapc('<leader>ta', 'GpAppend')
            utils.mapc('<leader>tp', 'GpPrepend')
            utils.mapc('<leader>ti', 'GpImplement')
            utils.mapc('<leader>tx', 'GpContext')
            utils.mapc('<leader>tc', 'GpChatNew')
            utils.mapc('<leader>tn', 'GpNextAgent')
        end,
    },
    }
