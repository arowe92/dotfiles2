local CONFIG = {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    -- keys = {
    --     "<leader>\\",
    --     "<leader>|"
    -- },
    -- cmd = {
    --     "NvimTreeToggle",
    --     "NvimTreeOpen",
    --     "NvimTreeFindFile",
    -- },
    config = function()
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
        vim.opt.termguicolors = true

        require('nvim-tree').setup {
            on_attach = on_attach,
            git = {
                ignore = false,
            },
            view = {
                width = 30,
            },
            renderer = {
                icons = {
                    glyphs = {
                        git = {
                            unstaged = "",
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

function collapse_all()
    require("nvim-tree.actions.tree-modifiers.collapse-all").fn()
end

function edit_or_open()
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

-- open as vsplit on current node
local function vsplit_preview()
    local api = require('nvim-tree.api')
    local node = api.tree.get_node_under_cursor()

    if node.nodes ~= nil then
        -- expand or collapse folder
        api.node.open.edit()
    else
        -- open file as vsplit
        api.node.open.vertical()
    end

    -- Finally refocus on tree if it was lost
    api.tree.focus()
end

function on_attach(bufnr)
    local function print_node_path(node)
        print(node.absolute_path)
    end

    local api = require('nvim-tree.api')

    api.config.mappings.default_on_attach(bufnr)

    local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr }
    end

    vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node, opts('CD'))
    vim.keymap.set('n', '<C-[>', api.tree.change_root_to_parent, opts('Up'))
    vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
    vim.keymap.set('n', 'L', vsplit_preview, opts('Preview'))
    vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Directory'))
    vim.keymap.set('n', 'H', api.tree.collapse_all, opts('Collapse'))
end

return CONFIG
