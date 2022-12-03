return {
    'nvim-treesitter/nvim-treesitter',
    requires = {
        'p00f/nvim-ts-rainbow',
    },
    run = ':TSUpdate',
    config = function()
        local TS_CONFIG = {
            ensure_installed = { "c", "lua", "rust", "typescript" },
            sync_install = false,
            auto_install = true,
            highlight = {
                enable = true,
            },
            rainbow = {
                enable = true,
                extended_mode = true,
                max_file_lines = nil,
            }
        }
        require 'nvim-treesitter.configs'.setup(TS_CONFIG)
    end
}
