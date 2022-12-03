return {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} },
    config = function ()
        local builtin = require('telescope.builtin')

        vim.keymap.set('n', '<C-p>', builtin.find_files, {})
        vim.keymap.set('n', '<M-p>', builtin.buffers, {})

        vim.keymap.set('n', '<leader>ph', builtin.help_tags, {})
    end
}
