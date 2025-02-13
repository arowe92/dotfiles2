-- Plugin List
return {
    -- Configured Plugins
    require 'nvim_config.plugins.completion',
    require 'nvim_config.plugins.colorschemes',
    require 'nvim_config.plugins.lsp',
    require 'nvim_config.plugins.statusline',
    require 'nvim_config.plugins.telescope',
    require 'nvim_config.plugins.tree',
    require 'nvim_config.plugins.treesitter',


    -- Display Marks
    { 'kshenoy/vim-signature' },
    { 
        'lukas-reineke/indent-blankline.nvim', 
        config = function () 
            require 'ibl'.setup()
        end
    },

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
    -- {
    --     'numToStr/Comment.nvim',
    --     keys = {
    --         { "<m-/>", mode={'n', 'x'} },
    --         { "<m-?>", mode={'n', 'x'} }
    --     },
    --     config = function()
    --         require('Comment').setup({
    --             toggler = {
    --                 line = '<m-/>',
    --                 block = '<m-?>',
    --             },
    --         })
    --         -- Commenting
    --         vim.keymap.set('x', '<m-?>', '<Plug>(comment_toggle_blockwise_visual)')
    --         vim.keymap.set('x', '<m-/>', '<Plug>(comment_toggle_linewise_visual)')
    --     end
    --
    -- },

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

    -- Multi Cursor
    {
        'mg979/vim-visual-multi',
        init = function()
            vim.g.VM_default_mappings = 1
            vim.g.VM_maps = {
                ['Find Under']         = "<M-d>",
                ['Find Subword Under'] = '<M-d>',
                ['Select All']         = '<M-D>',
                ['Visual All']         = '<M-D>',
                ["Add Cursor Down"]    = '<S-Down>',
                ["Add Cursor Up"]      = '<S-Up>',
                ['Visual Cursors']     = '<Tab>',
                ['Visual Add']         = 'v',
                ['Increase']           = '+',
                ['Decrease']           = '-',
                ['Toggle Mappings']    = '<space><space>',
                ['Reselect Last']      = '\\gv',
            }
            vim.g.VM_case_setting = 'sensitive'
            vim.g.VM_theme = 'purplegray'
        end
    },

    -- Hop
    {
        'smoka7/hop.nvim',
        keys = {
            " j",
            " k"
        },
        cmd = { "HopVerticalAC", "HopVerticalBC" },
        config = function()
            local utils = require 'nvim_config.utils'
            local hop = require 'hop'
            hop.setup({})

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

    -- {
    --     "petertriho/nvim-scrollbar",
    --     event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    --     config = function()
    --         require("scrollbar").setup({
    --             handlers = {
    --                 gitsigns = true,
    --                 search = false,
    --             }
    --         })
    --     end
    -- },

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
    -- {
    --     'akinsho/git-conflict.nvim',
    --     tag = "*",
    --     config = function()
    --         require('git-conflict').setup({ default_mappings = false })
    --         vim.keymap.set('n', 'co', '<Plug>(git-conflict-ours)')
    --         vim.keymap.set('n', 'ct', '<Plug>(git-conflict-theirs)')
    --         vim.keymap.set('n', 'cb', '<Plug>(git-conflict-both)')
    --         vim.keymap.set('n', 'c0', '<Plug>(git-conflict-none)')
    --         vim.keymap.set('n', ']x', '<Plug>(git-conflict-prev-conflict)')
    --         vim.keymap.set('n', '[x', '<Plug>(git-conflict-next-conflict)')
    --     end
    -- },

    -- Formatting through LSP
    -- {
    --     'jose-elias-alvarez/null-ls.nvim',
    --     keys = {
    --         { "<A-F>" },
    --         { "<S-A-f>" },
    --     },
    --     config = function()
    --         local null_ls = require("null-ls")
    --         null_ls.setup({
    --             sources = {
    --                 null_ls.builtins.formatting.autopep8,
    --                 null_ls.builtins.formatting.prettier,
    --                 null_ls.builtins.formatting.buf,
    --             },
    --         })
    --     end
    -- },

    -- Code Actions
    -- {
    --     'weilbith/nvim-code-action-menu',
    --     cmd = { "CodeActionMenu" },
    --     init = function()
    --         local nmapc = require 'nvim_config.utils'.nmapc
    --         nmapc('<space>ca', 'CodeActionMenu')
    --     end
    -- },

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

        keys = {
            -- Normal mode mappings
            {
                "<leader>ir",
                "<cmd>GpRewrite<cr>",
                desc = "Rewrite with GPT",
                mode = "n"
            },
            {
                "<leader>ia",
                "<cmd>GpAppend<cr>",
                desc = "Append with GPT",
                mode = "n"
            },
            {
                "<leader>ip",
                "<cmd>GpPrepend<cr>",
                desc = "Prepend with GPT",
                mode = "n"
            },
            {
                "<leader>ii",
                "<cmd>GpImplement<cr>",
                desc = "Implement with GPT",
                mode = "n"
            },
            {
                "<leader>ic",
                "<cmd>GpContext<cr>",
                desc = "Context with GPT",
                mode = "n"
            },
            {
                "<leader>in",
                "<cmd>GpChatNew<cr>",
                desc = "Start new chat with GPT",
                mode = "n"
            },
            {
                "<leader>it",
                "<cmd>GpChatToggle<cr>",
                desc = "Toggle chat with GPT",
                mode = "n"
            },
            {
                "<leader>ix",
                "<cmd>GpNextAgent<cr>",
                desc = "Switch to next GPT agent",
                mode = "n"
            },
            
            -- Visual mode mappings
            {
                "<leader>ir",
                "<cmd>'<,'>GpRewrite<cr>",
                desc = "Rewrite with GPT",
                mode = "v"
            },
            {
                "<leader>ia",
                "<cmd>'<,'>GpAppend<cr>",
                desc = "Append with GPT",
                mode = "v"
            },
            {
                "<leader>ip",
                "<cmd>'<,'>GpPrepend<cr>",
                desc = "Prepend with GPT",
                mode = "v"
            },
            {
                "<leader>ii",
                "<cmd>'<,'>GpImplement<cr>",
                desc = "Implement with GPT",
                mode = "v"
            },
            {
                "<leader>ic",
                "<cmd>'<,'>GpContext<cr>",
                desc = "Context with GPT",
                mode = "v"
            },
            {
                "<leader>in",
                "<cmd>'<,'>GpChatNew<cr>",
                desc = "Start new chat with GPT",
                mode = "v"
            },
            {
                "<leader>it",
                "<cmd>'<,'>GpChatToggle<cr>",
                desc = "Toggle chat with GPT",
                mode = "v"
            },
        },

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
    },
    {
        "folke/trouble.nvim",
        cmd = "Trouble",
        keys = {
            {
                "<leader>tt",
                "<cmd>Trouble diagnostics toggle filter.buf=0 filter.severity=vim.diagnostic.severity.ERROR<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>tT",
                "<cmd>Trouble diagnostics toggle filter.severity=vim.diagnostic.severity.ERROR<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>td",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>tD",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>ts",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>tl",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "<leader>tL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>tq",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
        },
        opts = {},
        config = function ()
            require('trouble').setup({
                open_no_results = true,
            })
        end
    },

    {
        'ThePrimeagen/harpoon',
        keys = {{
            '<leader><leader>h',
            function ()
                require("harpoon.mark").add_file()
            end 
        }, {
            '<leader><leader>a',
            function ()
                require("harpoon.mark").add_file()
            end 
        }, {
            '<leader><leader>m',
            function ()
                require("harpoon.ui").toggle_quick_menu()
            end
        }, {
            '<leader><leader>o',
            function ()
                require("harpoon.ui").nav_next()
            end
        }, {
            '<leader><leader>n',
            function ()
                require("harpoon.ui").nav_prev()
            end
        }, {
            '<leader><leader>c',
            function ()
                vim.ui.input({prompt = 'Add Command: '}, function (input)
                    require("harpoon.tmux").add_cmd(input)
                end
                )
            end
        }, {
            '<leader><leader>r',
            function ()
                require("harpoon.cmd-ui").toggle_quick_menu()
            end
        }, {
            '<leader><leader>C',
            function ()
                vim.ui.input({prompt = 'Remove Command: '}, function (input)
                    require("harpoon.tmux").rm_cmd(tonumber(input))
                end
                )
            end
        }},
        config = function () 
            require("harpoon").setup({
                projects = {
                    -- Yes $HOME works
                    ["$HOME/personal/vim-with-me/server"] = {
                        term = {
                            cmds = {
                                "./env && npx ts-node src/index.ts"
                            }
                        }
                    }
                }
            })

            require("telescope").load_extension('harpoon')
        end

    }, 

    {
        'MeanderingProgrammer/markdown.nvim',
        name = 'render-markdown', 
        ft = "markdown",
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-tree/nvim-web-devicons' 
        },
        config = function()
            require('render-markdown').setup({})
        end,
    },

    {
        'nmac427/guess-indent.nvim',
        config = function() 
            require('guess-indent').setup {} 
        end,
    },

    {
        'HiPhish/rainbow-delimiters.nvim',
        dependencies = {
            'nvim-treesitter'
        }
    },

    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy", 
        priority = 1000, 
        config = function()
            require('tiny-inline-diagnostic').setup()
        end
    },
    {
        "ibhagwan/fzf-lua",
        event = "VeryLazy", 
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("fzf-lua").setup({})
            local config = require("fzf-lua.config")
            local actions = require("trouble.sources.fzf").actions
            config.defaults.actions.files["ctrl-t"] = actions.open
        end
    },

    -- {
    -- 'norcalli/nvim-colorizer.lua',
    -- config = function() 
    --     require('colorizer').setup()
    -- end
    -- }
}
