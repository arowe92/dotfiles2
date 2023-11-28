return {
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
}
