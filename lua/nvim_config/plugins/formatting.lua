return {
    {
        'stevearc/conform.nvim',
        event = { 'BufWritePre' },
        cmd = { 'ConformInfo' },
        keys = {
            {
                '<A-F>',
                function() require('conform').format({ async = true, lsp_format = 'fallback' }) end,
                mode = { 'n', 'v' },
                desc = 'Format buffer',
            },
        },
        opts = {
            formatters_by_ft = {
                lua = { 'stylua' },
                javascript = { 'prettierd', 'prettier', stop_after_first = true },
                typescript = { 'prettierd', 'prettier', stop_after_first = true },
                javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
                typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
                json = { 'prettierd', 'prettier', stop_after_first = true },
                yaml = { 'prettierd', 'prettier', stop_after_first = true },
                markdown = { 'prettierd', 'prettier', stop_after_first = true },
                sh = { 'shfmt' },
                python = { 'autopep8' },
            },
            default_format_opts = { lsp_format = 'fallback' },
        },
    },

    {
        'mfussenegger/nvim-lint',
        event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
        config = function()
            local lint = require('lint')
            lint.linters_by_ft = {
                -- configure as needed, e.g.:
                -- javascript = { 'eslint_d' },
                -- typescript = { 'eslint_d' },
                -- python     = { 'ruff' },
                -- sh         = { 'shellcheck' },
            }
            vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost', 'InsertLeave' }, {
                callback = function() lint.try_lint() end,
            })
        end,
    },
}
