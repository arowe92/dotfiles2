return {
    'nvim-treesitter/nvim-treesitter',
    version = false,
    dependencies = {
        'p00f/nvim-ts-rainbow',
    },
    build = ':TSUpdate',
    event = { "VeryLazy" }, 
    init = function(plugin)
        -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
        -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
        -- no longer trigger the **nvim-treeitter** module to be loaded in time.
        -- Luckily, the only thins that those plugins need are the custom queries, which we make available
        -- during startup.
        require("lazy.core.loader").add_to_rtp(plugin)
        require("nvim-treesitter.query_predicates")
    end,
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    config = function()
        local TS_CONFIG = {
            -- ensure_installed = { "c", "lua", "rust", "typescript" },
            sync_install = false,
            auto_install = false,
            highlight = {
                enable = true,
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "gnn", -- set to `false` to disable one of the mappings
                    node_incremental = "gne",
                    scope_incremental = "gni",
                    node_decremental = "gnu",
                },
            },
            rainbow = {
                enable = true,
                extended_mode = true,
                max_file_lines = 1000,
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
