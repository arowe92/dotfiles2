local CONFIG = {
    'nvim-tree/nvim-tree.lua',
    requires = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
        vim.opt.termguicolors = true

        require('nvim-tree').setup {
            view = {
                width = 50,
                mappings = {
                    custom_only = false,
                    list = {
                        { key = { "<C-]>" }, action = "cd" },
                        { key = "C-[", action = "dir_up" },
                        { key = "l", action = "edit", action_cb = edit_or_open },
                        { key = "L", action = "vsplit_preview", action_cb = vsplit_preview },
                        { key = "h", action = "close_node" },
                        { key = "H", action = "collapse_all", action_cb = collapse_all }
                    }
                },
            },
            renderer = {
                icons = {
                    glyphs = {
                        git = {
                            unstaged = "",
                            staged = "",
                            unmerged = "",
                            renamed = "➜",
                            untracked = "",
                            deleted = "",
                            ignored = "◌",
                        }
                    }
                }
            },
            actions = {
                open_file = {
                    quit_on_open = false
                }
            }
        }

        local utils = require('nvim_config.utils')
        utils.nmapc('<leader>\\', "NvimTreeToggle")
        utils.nmapc('<leader>|', "NvimTreeFindFile")
        utils.nmapc('<M-=>', "NvimTreeResize +20")
        utils.nmapc('<M-->', "NvimTreeResize -20")
    end
}

-- Copied From https://github.com/nvim-tree/nvim-tree.lua/wiki/Recipes

local function collapse_all()
    require("nvim-tree.actions.tree-modifiers.collapse-all").fn()
end

local function edit_or_open()
    local lib = require("nvim-tree.lib")
    local view = require("nvim-tree.view")

    -- open as vsplit on current node
    local action = "edit"
    local node = lib.get_node_at_cursor()

    -- Just copy what's done normally with vsplit
    if node.link_to and not node.nodes then
        require('nvim-tree.actions.node.open-file').fn(action, node.link_to)
        view.close() -- Close the tree if file was opened

    elseif node.nodes ~= nil then
        lib.expand_or_collapse(node)

    else
        require('nvim-tree.actions.node.open-file').fn(action, node.absolute_path)
        view.close() -- Close the tree if file was opened
    end

end

local function vsplit_preview()
    local lib = require("nvim-tree.lib")
    local view = require("nvim-tree.view")

    -- open as vsplit on current node
    local action = "vsplit"
    local node = lib.get_node_at_cursor()

    -- Just copy what's done normally with vsplit
    if node.link_to and not node.nodes then
        require('nvim-tree.actions.node.open-file').fn(action, node.link_to)

    elseif node.nodes ~= nil then
        lib.expand_or_collapse(node)

    else
        require('nvim-tree.actions.node.open-file').fn(action, node.absolute_path)

    end

    -- Finally refocus on tree if it was lost
    view.focus()
end

return CONFIG
