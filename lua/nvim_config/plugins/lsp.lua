return {
    {
        'mason-org/mason.nvim',
        opts = {},
    },
    {
        'mason-org/mason-lspconfig.nvim',
        dependencies = {
            'mason-org/mason.nvim',
            'neovim/nvim-lspconfig',
        },
        opts = {},
    },
    {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        dependencies = { 'mason-org/mason.nvim' },
        opts = {
            ensure_installed = {
                -- formatters / linters; LSPs are managed via mason-lspconfig
                'prettierd',
                'stylua',
                'shfmt',
            },
        },
    },

    {
        'neovim/nvim-lspconfig',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = { 'saghen/blink.cmp' },
        config = function()
            local opts = { noremap = true, silent = true }
            vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1, float = true }) end, opts)
            vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1, float = true }) end, opts)
            vim.keymap.set('n', '<space>de', vim.diagnostic.open_float, opts)
            vim.keymap.set('n', '<space>dq', vim.diagnostic.setloclist, opts)

            vim.keymap.set('n', 'gd', vim.lsp.buf.declaration, opts)
            vim.keymap.set('n', 'gk', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', 'gh', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
            vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)
            vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
            vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
            vim.keymap.set('n', '<space>wl', function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, opts)
            vim.keymap.set('n', 'gD', vim.lsp.buf.type_definition, opts)
            vim.keymap.set('n', '<space>cr', vim.lsp.buf.rename, opts)
            vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
            vim.keymap.set('n', '<m-.>', vim.lsp.buf.code_action, opts)
            vim.keymap.set('n', 'gr', function()
                local function on_list(options)
                    vim.fn.setqflist({}, ' ', options)
                    vim.cmd 'Trouble qflist'
                end
                vim.lsp.buf.references(nil, { on_list = on_list })
            end, opts)
            vim.keymap.set('n', '<S-A-f>', function()
                vim.lsp.buf.format({ async = true })
            end, opts)
            vim.keymap.set('n', '<m-o>', function()
                vim.cmd 'LspClangdSwitchSourceHeader'
            end)
            vim.keymap.set('n', '<S-A-s>', function()
                vim.lsp.buf.format({ async = false })
                vim.defer_fn(function() vim.cmd('w') end, 500)
            end, opts)

            -- Apply blink.cmp capabilities to every server configured via vim.lsp.config
            vim.lsp.config('*', {
                capabilities = require('blink.cmp').get_lsp_capabilities(),
            })

            -- Per-server overrides
            vim.lsp.config('clangd', {
                -- cmd = { 'clangd', '--compile-commands-dir=./' },
            })
        end,
    },

    -- LSP Status
    {
        'j-hui/fidget.nvim',
        event = { 'LspAttach' },
        opts = {},
    },
}
