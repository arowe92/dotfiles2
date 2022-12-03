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
vim.cmd('colorscheme moonlight')

-- Source VIM Mappings
vim.cmd('source ' .. env.DOTFILE_PATH .. '/vim/init.vim')

-- General Mapped functions
require 'nvim_config.functions'
