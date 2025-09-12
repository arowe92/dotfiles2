-- Perform Bootstrap Installs
require 'nvim_config.bootstrap'

-- Load env constants
local env = require('nvim_config.env')

-- Set Mapleader
vim.g.mapleader = ' '

-- Configure and load plugins
local load_plugins = require 'nvim_config.plugins.init'

-- Setups that have to come after package management
vim.opt.runtimepath:append(env.DOTFILE_PATH)

-- Source VIM Config files
vim.cmd('source ' .. env.DOTFILE_PATH .. '/vim/init.vim')

-- General Mapped functions
require 'nvim_config.functions'
require 'nvim_config.keymap'
require 'nvim_config.options'

require("lazy").setup(load_plugins, {})
require('nvim_config.plugins.lsp')._post_config()

-- Load a custom lua
if vim.fn.filereadable(env.HOME .. '/nvim.lua') == 1 then
    dofile(env.HOME .. "/nvim.lua")
end

-- Load a custom vimrc
if vim.fn.filereadable(env.HOME .. '/.vimrc') == 1 then
    vim.cmd('source ' .. env.HOME .. '/.vimrc')
end


-- Persistent Colorscheme
vim.api.nvim_create_augroup('colors', { clear = true })
vim.api.nvim_create_autocmd('Colorscheme', {
    group = 'colors',
    pattern = { '*' },
    callback = function()
        io.popen('echo colorscheme ' .. vim.api.nvim_command_output('color') .. ' > ' .. env.COLORSCHEME)
    end
})

-- Load fzf-lua colors
-- This has to be after plugin loading
local base = vim.env.TEMP .. "/colors/pack/fzf-lua/opt"
local handle = vim.loop.fs_scandir(base)
if handle then
    while true do
      local name, t = vim.loop.fs_scandir_next(handle)
      if not name then break end
      if t == "directory" then
        vim.opt.runtimepath:append(base .. "/" .. name)
      end
    end
end

if vim.fn.filereadable(env.COLORSCHEME) then
    vim.cmd('silent source ' .. env.COLORSCHEME)
else
    vim.cmd('colorscheme carbonfox')
end


vim.api.nvim_create_augroup('term', { clear = true })
vim.api.nvim_create_autocmd('BufWinEnter', {
    group = 'term',
    pattern = { 'term://*' },
    callback = function()
        vim.cmd "startinsert"
    end
})
