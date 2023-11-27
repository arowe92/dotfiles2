
local CONFIG = {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cmd = {
        "NvimTreeToggle",
        "NvimTreeFindFile",
        "NvimTreeOpen",
    },
    ft = {
        "netrw"
    },
    config = function()
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
        vim.opt.termguicolors = true
        local on_attach = function (bufnr)
            local api = require "nvim-tree.api"

            local function opts(desc)
                return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
            end
            api.config.mappings.default_on_attach(bufnr)

            local utils = require('nvim_config.utils')
            utils.nmapc('<leader>\\', "NvimTreeToggle")
            utils.nmapc('<leader>|', "NvimTreeFindFile")
            utils.nmapc('<M-=>', "NvimTreeResize +20")
            utils.nmapc('<M-->', "NvimTreeResize -20")

            vim.keymap.set("n", "l", edit_or_open,          opts("Edit Or Open"))
            vim.keymap.set("n", "L", vsplit_preview,        opts("Vsplit Preview"))
            vim.keymap.set("n", "h", api.tree.close,        opts("Close"))
            vim.keymap.set("n", "H", api.tree.collapse_all, opts("Collapse All"))
            -- vim.keymap.set("n", "<leader>\\", api.tree.open, opts("Open"))
            -- vim.keymap.set("n", "<leader>|"  , api.tree.fin, opts("Open"))
        end

        require('nvim-tree').setup {
            on_attach = on_attach,
            git = {
                ignore = false,
            },
            view = {
                width = 50,
                    -- list = {
                    --     { key = { "<C-]>" }, action = "cd" },
                    --     { key = "C-[", action = "dir_up" },
                    --     { key = "l", action = "edit", action_cb = edit_or_open },
                    --     { key = "L", action = "vsplit_preview", action_cb = vsplit_preview },
                    --     { key = "h", action = "close_node" },
                    --     { key = "H", action = "collapse_all", action_cb = collapse_all }
                    -- }
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
    end
}

-- Copied From https://github.com/nvim-tree/nvim-tree.lua/wiki/Recipes


function edit_or_open()
  local api = require("nvim-tree.api")
  local node = api.tree.get_node_under_cursor()

  if node.nodes ~= nil then
    -- expand or collapse folder
    api.node.open.edit()
  else
    -- open file
    api.node.open.edit()
    -- Close the tree if file was opened
    api.tree.close()
  end
end

-- open as vsplit on current node
function vsplit_preview()
  local api = require("nvim-tree.api")
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

return CONFIG
