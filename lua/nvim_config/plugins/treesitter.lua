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
                colors = {
                    "#f89984",
                    "#f16286",
                    "#f79921",
                    "#f89d6a",
                    "#f65d0e",
                    "#f58588",
                },
                termcolors = {
                    "Red",
                    "Green",
                    "Yellow",
                    "Blue",
                    "Magenta",
                    "Cyan",
                    "White",
                },
            }
        }
        require 'nvim-treesitter.configs'.setup(TS_CONFIG)
    end
}
