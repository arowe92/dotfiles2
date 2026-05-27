-- Plugin List
local env = require('nvim_config.env')
local lite_mode = env.LITE_MODE

-- Helper to conditionally load configured plugins
local function load_plugin(module_name)
    if lite_mode then
        return {}
    end
    return require(module_name)
end

return {
    -- Configured Plugins (disabled in lite mode)
    load_plugin('nvim_config.plugins.completion'),
    require 'nvim_config.plugins.colorschemes',
    load_plugin('nvim_config.plugins.lsp'),
    load_plugin('nvim_config.plugins.formatting'),
    load_plugin('nvim_config.plugins.statusline'),
    load_plugin('nvim_config.plugins.telescope'),
    load_plugin('nvim_config.plugins.tree'),
    load_plugin('nvim_config.plugins.treesitter'),

    -- Claude Code
    {
        "greggh/claude-code.nvim",
        enabled = not lite_mode,
        dependencies = {
            "nvim-lua/plenary.nvim", -- Required for git operations
        },
        config = function()
            require("claude-code").setup({
                keymaps = {
                    -- toggle = {
                        -- normal = "<C-h>",
                        -- terminal = "<C-h>",
                    -- },
                    window_navigation = false
                },
            })
            vim.keymap.set('n', '<leader>cc', '<cmd>ClaudeCode<cr>', { desc = "Claude Code" })
        end
    },

    -- Display Marks
    {
        'chentoast/marks.nvim',
        event = 'VeryLazy',
        opts = {},
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        event = "BufReadPost",
        config = function ()
            require 'ibl'.setup()
        end
    },

    -- Tmux
    'roxma/vim-tmux-clipboard',

    -- Smart edge-aware split navigation across nvim + WezTerm/tmux panes
    {
        'mrjones2014/smart-splits.nvim',
        lazy = false,
        config = function()
            require('smart-splits').setup({
                -- auto-detect WezTerm/tmux/Kitty; explicit for safety
                multiplexer_integration = nil, -- nil = auto
                at_edge = 'wrap',
            })
            vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left,  { silent = true })
            vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down,  { silent = true })
            vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up,    { silent = true })
            vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right, { silent = true })
        end
    },

    -- Commenting handled by builtin gc/gcc (nvim 0.10+); <m-/> mapped here.
    -- BufferLine
    {
        'akinsho/bufferline.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        enabled = not vim.g.vscode and not lite_mode,
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
        enabled = not vim.g.vscode and not lite_mode,
        config = function()
            require 'alpha'.setup(require 'alpha.themes.startify'.config)
        end
    },

    -- Surround
    {
        'kylechui/nvim-surround',
        version = '*',
        event = 'VeryLazy',
        opts = {},
    },

    {
        "tpope/vim-repeat",
    },

    -- Git Signs
    {
        'lewis6991/gitsigns.nvim',
        enabled = not vim.g.vscode and not lite_mode,
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
        enabled = not vim.g.vscode,
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

            -- Fix blink.cmp arrow keys after VM exits
            vim.api.nvim_create_autocmd('User', {
                pattern = 'visual_multi_exit',
                callback = function()
                    -- Force blink.cmp to reapply its keymaps
                    vim.defer_fn(function()
                        local blink = require('blink.cmp')
                        if blink and blink.setup_keymaps then
                            blink.setup_keymaps()
                        end
                    end, 10)
                end,
            })
        end
    },

    -- Flash: replaces hop + clever-f. Handles leader-jumps and f/F/t/T.
    {
        'folke/flash.nvim',
        event = 'VeryLazy',
        opts = {
            modes = {
                char = {
                    enabled = true,
                    multi_line = false,
                    keys = { 'f', 'F', 't', 'T', ';', ',' },
                },
            },
        },
        keys = {
            { 's',         mode = { 'n', 'x', 'o' }, function() require('flash').jump() end,              desc = 'Flash' },
            { 'S',         mode = { 'n', 'x', 'o' }, function() require('flash').treesitter() end,        desc = 'Flash Treesitter' },
            { 'r',         mode = 'o',                function() require('flash').remote() end,            desc = 'Remote Flash' },
            { 'R',         mode = { 'o', 'x' },       function() require('flash').treesitter_search() end, desc = 'Treesitter Search' },
            { '<leader>j', mode = 'n',                function() require('flash').jump({ search = { mode = 'search', max_length = 0 }, label = { after = { 0, 0 } }, pattern = '^' }) end, desc = 'Flash vertical (down)' },
            { '<leader>k', mode = 'n',                function() require('flash').jump({ search = { mode = 'search', max_length = 0 }, label = { after = { 0, 0 } }, pattern = '^' }) end, desc = 'Flash vertical (up)' },
        },
    },

    {
        "nvim-zh/colorful-winsep.nvim",
        enabled = not vim.g.vscode and not lite_mode,
        event = "WinNew",
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
        cmd = { "Git", "Gedit", "Gblame" },
        keys = {
            {'<C-g>', ':Git '}
        },
        config = function()
            vim.keymap.set('n', '<C-g>', ':Git ')
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
            {
                "<leader>tf",
                desc = "Send Trouble results to fzf-lua",
            },
        },
        opts = {},
        config = function ()
            require('trouble').setup({
                open_no_results = true,
            })

            -- Add hotkey to send trouble results to fzf-lua via quickfix
            vim.keymap.set('n', '<leader>tf', function()
                -- Get current trouble items
                local trouble = require('trouble')
                local items = trouble.get_items()

                if not items or #items == 0 then
                    vim.notify("No Trouble items to send to fzf-lua", vim.log.levels.WARN)
                    return
                end

                -- Convert trouble items to quickfix format
                local qf_items = {}
                for _, item in ipairs(items) do
                    table.insert(qf_items, {
                        filename = item.filename or item.source,
                        lnum = item.lnum or item.pos and item.pos[1] or 1,
                        col = item.col or item.pos and item.pos[2] or 1,
                        text = item.text or item.message or "",
                    })
                end

                -- Set quickfix list and open in fzf-lua
                vim.fn.setqflist(qf_items)
                require('fzf-lua').quickfix()
            end, { desc = 'Send Trouble results to fzf-lua' })
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
                    -- ["$HOME/work/haxor/windows_sb2/"] = {
                    --     term = {
                    --         cmds = {
                    --             "npm run build",
                    --             "./build.ps1",
                    --             "npm run start"
                    --         }
                    --     }
                    -- }
                }
            })

            --require("telescope").load_extension('harpoon')
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
        enabled = not lite_mode,
        event = "BufReadPost",
        dependencies = {
            'nvim-treesitter'
        }
    },

    {
        "rachartier/tiny-inline-diagnostic.nvim",
        enabled = not lite_mode,
        event = "VeryLazy",
        priority = 1000,
        config = function()
            require('tiny-inline-diagnostic').setup()
        end
    },
    {
        "ibhagwan/fzf-lua",
        enabled = not lite_mode,
        event = "VeryLazy",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("fzf-lua").setup({
                  grep = {
                    rg_opts = "--hidden --column --line-number --no-heading --color=always --smart-case"
                  },
                  awesome_colorschemes = {
                      packpath = vim.env.TEMP .. "/nvim-colors"
                  }
            })

            local config = require("fzf-lua.config")
            local actions = require("trouble.sources.fzf").actions
            config.defaults.actions.files["ctrl-t"] = actions.open

            -- Add hotkey to send all fzf-lua results to trouble
            vim.keymap.set('n', '<leader>ft', function()
                require('trouble').open('fzf')
            end, { desc = 'Send fzf-lua results to Trouble' })
        end
    },

    { "tiagovla/scope.nvim", config = true },

    {
        "zbirenbaum/copilot.lua",
        enabled = not lite_mode,
        cmd = "Copilot",
        event = "InsertEnter",
        opts = {
            -- blink-copilot drives completion; disable the native panel/suggestion UI
            suggestion = { enabled = false },
            panel = { enabled = false },
        },
    },

    -- {
    -- 'norcalli/nvim-colorizer.lua',
    -- config = function()
    --     require('colorizer').setup()
    -- end
    -- }
}
