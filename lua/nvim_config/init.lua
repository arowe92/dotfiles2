-- Perform Bootstrap Installs
(require 'nvim_config.bootstrap')()

-- Load env constants
local env = require('nvim_config.env')

-- Configure and load plugins
local load_plugins = require 'nvim_config.plugins.init'
require('packer').startup(load_plugins)

-- Setups that have to come after package management
require('nvim_config.plugins.lsp')._post_config()

-- Set Colorscheme
-- vim.cmd('colorscheme carbonfox')

-- Source VIM Config files
vim.cmd('source ' .. env.DOTFILE_PATH .. '/vim/init.vim')

-- General Mapped functions
require 'nvim_config.functions'
require 'nvim_config.keymap'
require 'nvim_config.options'

dofile("/home/arowe/nvim.lua")
vim.cmd "source /home/arowe/.vimrc"

-- Persistent Colorscheme
vim.api.nvim_create_augroup('colors', { clear = true })
vim.api.nvim_create_autocmd('Colorscheme', {
    group = 'colors',
    pattern = { '*' },
    callback = function()
        io.popen('echo colorscheme ' .. vim.api.nvim_command_output('color') .. ' > ~/.local/share/nvim/colorscheme.vim')
    end
})
require('rose-pine').setup({
    variant = 'main',
    dark_variant = 'main',
    disable_italics = true
})
vim.cmd('silent source ~/.local/share/nvim/colorscheme.vim')


vim.api.nvim_create_augroup('term', { clear = true })
vim.api.nvim_create_autocmd('BufWinEnter', {
    group = 'term',
    pattern = { 'term://*' },
    callback = function()
        vim.cmd "startinsert"
    end
})
