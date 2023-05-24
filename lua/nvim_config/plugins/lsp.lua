return {
    'neovim/nvim-lspconfig',

    config = function()
        local opts = { noremap = true, silent = true }
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
        -- vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
        -- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

        -- Mappings.
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
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<S-A-f>', function()
            vim.lsp.buf.format { async = true }
        end, opts)
        vim.keymap.set('n', '<m-o>', '<cmd>ClangdSwitchSourceHeader<cr>')

        vim.keymap.set('n', '<S-A-s>', function()
            vim.lsp.buf.formatting({ async = false })
            vim.defer_fn(function()
                vim.cmd("w")
            end, 500)
        end, opts)
    end,

    -- Custom Hook to run after wards
    _post_config = function()
        require("mason").setup()
        require("mason-lspconfig").setup {
            ensure_installed = { "rust_analyzer", "tsserver", "clangd", "pyright", "remark_ls" }
        }
        require("mason-lspconfig").setup_handlers {
            function(server_name)
                if server_name == "clangd" then
                    require("lspconfig")[server_name].setup {
                        cmd = { "clangd", "-header-insertion=never" }
                    }
                else
                    require("lspconfig")[server_name].setup {}
                end
            end,
        }
    end
}
