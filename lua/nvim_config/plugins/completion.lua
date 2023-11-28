return {
    'hrsh7th/nvim-cmp',

    event = {
        "CmdlineEnter",
        "InsertEnter",
    },

    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',

        {
            "L3MON4D3/LuaSnip",
            config = function()
                local DOT = require("nvim_config.env").DOTFILE_PATH;

                require("luasnip.loaders.from_vscode").lazy_load({
                    paths = { DOT .. '/.config/snippets/' }
                })
            end
        },
        'saadparwaiz1/cmp_luasnip',
    },

    config = function()
        local cmp = require 'cmp'

        vim.o.completeopt = "menu,menuone,noselect"

        cmp.setup({
            snippet = {
                expand = function(args)
                    require'luasnip'.lsp_expand(args.body)
                end,
            },
            window = {
                -- completion = cmp.config.window.bordered(),
                -- documentation = cmp.config.window.bordered(),
            },

            mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
                ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'c', 'i' }),
                ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'c', 'i' }),
                ['<M-Enter>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
                ['<C-y>'] = cmp.config.disable,
                ['<C-e>'] = cmp.mapping({
                    i = cmp.mapping.abort(),
                    c = cmp.mapping.close(),
                }),
                ['<Tab>'] = cmp.mapping({
                    i = cmp.mapping.confirm({ select = true }),
                    c = cmp.mapping.select_next_item(),
                }),
                ['<Enter>'] = cmp.mapping(cmp.mapping.confirm({ select = false })),
                ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item()),
            }),
            sources = cmp.config.sources({
                { name = 'luasnip' },
                { name = 'nvim_lsp' },
                { name = 'buffer' },
                { name = 'path' },
            })
        })

        -- Set configuration for specific filetype.
        cmp.setup.filetype('gitcommit', {
            sources = cmp.config.sources({
                { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
            }, {
                { name = 'buffer' },
            })
        })

        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' }
            }
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' }
            }, {
                { name = 'cmdline' }
            })
        })

        -- Set up lspconfig.
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
    end
}
