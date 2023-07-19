-- Perform Bootstrap Installs
(require 'nvim_config.bootstrap')()

-- Load env constants
local env = require('nvim_config.env')

-- Configure and load plugins
local load_plugins = require 'nvim_config.plugins.init'
require('packer').startup(load_plugins)

-- Setups that have to come after package management
require('nvim_config.plugins.lsp')._post_config()

-- Source VIM Config files
vim.cmd('source ' .. env.DOTFILE_PATH .. '/vim/init.vim')

-- General Mapped functions
require 'nvim_config.functions'
require 'nvim_config.keymap'
require 'nvim_config.options'

-- Load a custom lua
if vim.fn.filereadable(env.HOME .. '/nvim.lua') then
    dofile(env.HOME .. "/nvim.lua")
end

-- Load a custom vimrc
if vim.fn.filereadable(env.HOME .. '/.vimrc') then
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
require('rose-pine').setup({
    variant = 'main',
    dark_variant = 'main',
    disable_italics = true
})

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
