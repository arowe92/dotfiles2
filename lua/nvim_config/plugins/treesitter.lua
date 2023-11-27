return {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
        'p00f/nvim-ts-rainbow',
    },
    build = ":TSUpdate",
    event = { "VeryLazy" },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    keys = {
        { "<A-w>", desc = "Increment selection" },
        { "<A-W>", desc = "Decrement selection", mode = "x" }
    },init = function(plugin)
    -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
    -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
    -- no longer trigger the **nvim-treeitter** module to be loaded in time.
    -- Luckily, the only thins that those plugins need are the custom queries, which we make available
    -- during startup.
        require("lazy.core.loader").add_to_rtp(plugin)
        require("nvim-treesitter.query_predicates")
    end,
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
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<A-w>",
                    node_incremental = "<A-w>",
                    scope_incremental = false,
                    node_decremental = "<A-W>",
                },
            },
        }
        require 'nvim-treesitter.configs'.setup(TS_CONFIG)
    end
}
