

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
                    local file = vim.fn.system("find_test.sh --raw")
                    file = file:gsub("%s+", "")
                    file = file:gsub(".cc", "")
                    return './bazel-bin/' .. file
                end,
                cwd = '${workspaceFolder}',
                stopAtEntry = true,
            },
        }

        require("dapui").setup()
    end
}, {

    'kevinhwang91/nvim-hlslens',
    config = function()
        require('hlslens').setup()

        local kopts = { noremap = true, silent = true }

        vim.api.nvim_set_keymap('n', 'n',
        [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
        kopts)
        vim.api.nvim_set_keymap('n', 'N',
        [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
        kopts)
        vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
        vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
        vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
        vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)
    end
}, {
    "tiagovla/scope.nvim",
    config = function()
        require("scope").setup()
    end
}, {
    'liuchengxu/vim-clap'
}, {
    'Eandrju/cellular-automaton.nvim',
    config = function()
        vim.keymap.set("n", "<leader>CA", "<cmd>CellularAutomaton make_it_rain<CR>")
    end
},
{
    'glepnir/template.nvim',
    cmd = { 'Template', 'TemProject' },
    config = function()
        require('template').setup({
            temp_dir = '~/.local/share/templates'
        })
    end
},

{
    'nvimdev/lspsaga.nvim',
    after = 'nvim-lspconfig',
    config = function()
        require('lspsaga').setup({})
    end,
},

{
    "folke/which-key.nvim",
    config = function()
        local wk = require("which-key")
        wk.setup {
            triggers_nowait = { "<m-u>" }
        }

        wk.register({
            ['<m-u>'] = {
                name = "Insert",
                s = { "std::string", "std::string" },
            },
        }, {
            mode = "i",
            prefix = "",
            nowait = true,
        })

    end
}
