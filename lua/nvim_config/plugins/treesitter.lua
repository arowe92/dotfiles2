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
                    "#5f93bf",
                    "#9f6da7",
                    "#9baa58",
                    "#efaf79",
                    "#a7796c",
                    "#8da5c6",
                    "#c5b666",
                    "#a5c3a1",
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
