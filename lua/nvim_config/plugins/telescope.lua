return {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} },
    config = function ()
        local ivy = require('telescope.themes').get_ivy({})

        local opts = vim.tbl_deep_extend("force", ivy, {
            path_display={ truncate = 5 },
            vimgrep_arguments={
                'rg',
                '--color=never',
                '--no-heading',
                '--with-filename',
                '--line-number',
                '--column',
                '--smart-case',
                '-u'
            }
        })

        require('telescope').setup({
            defaults=opts
        })

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<C-p>', builtin.find_files, {})
        vim.keymap.set('n', '<M-p>', builtin.buffers, {})

        vim.keymap.set('n', '<leader>ph', builtin.help_tags, {})
        vim.keymap.set('n', '<a-f>', builtin.live_grep, {})
    end
}
