return {
    'nvim-telescope/telescope.nvim',
    dependencies = { { 'nvim-lua/plenary.nvim' } },
    cmd = {
        "Telescope"
    },
    config = function()
        local ivy = require('telescope.themes').get_ivy({})

        local opts = vim.tbl_deep_extend("force", ivy, {
            path_display = { truncate = 5 },
            -- vimgrep_arguments = {
            --     'rg',
            --     '--color=never',
            --     '--no-heading',
            --     '--with-filename',
            --     '--line-number',
            --     '--column',
            --     '--smart-case',
            --     '-u'
            -- },
            mappings = {
                n = {
                    ['<c-d>'] = require('telescope.actions').delete_buffer
                }
            },
            file_ignore_patterns = { "^./.git/", "^node_modules/", "^vendor/", "^dist/", "^build/" },
        })

        require('telescope').setup({
            defaults = opts,
            pickers = {
                buffers = {
                    preview = {
                        hide_on_startup = true
                    },
                    mappings = {
                        n = {
                            ['<c-w>'] = require('telescope.actions').delete_buffer
                        },
                        i = {
                            ['<c-w>'] = require('telescope.actions').delete_buffer
                        }
                    }
                },
                lsp_document_symbols = {
                    opts = {
                        symbol_width = 100
                    }
                },
                find_files = {
                    hidden = true
                }
            },
        })

        require('nvim_config.env').MODULES.telescope = true
    end
}
