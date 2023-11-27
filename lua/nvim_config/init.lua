-- Perform Bootstrap Installs
require 'nvim_config.bootstrap'

-- Load env constants
local env = require('nvim_config.env')

-- Mapleader
vim.g.mapleader = ' '

-- Configure and load plugins
local load_plugins = require 'nvim_config.plugins.init'
require("lazy").setup(load_plugins, {})

-- Setups that have to come after package management
require('nvim_config.plugins.lsp')._post_config()

-- Source VIM Config files
vim.cmd('source ' .. env.DOTFILE_PATH .. '/vim/init.vim')
vim.opt.runtimepath:append(env.DOTFILE_PATH)

-- General Mapped functions
require 'nvim_config.functions'
require 'nvim_config.keymap'
require 'nvim_config.options'

--dofile("/home/arowe/nvim.lua")
--vim.cmd"source /home/arowe/.vimrc"

-- Persistent Colorscheme
vim.api.nvim_create_augroup('colors', { clear = true })
vim.api.nvim_create_autocmd('Colorscheme', {
    group = 'colors',
    pattern = { '*' },
    callback = function()
        io.popen('echo colorscheme '.. vim.api.nvim_command_output('color') .. ' > ~/.local/share/nvim/colorscheme.vim')
    end
})
--vim.cmd('silent source ~/.local/share/nvim/colorscheme.vim')
vim.cmd 'colorscheme carbonfox'
