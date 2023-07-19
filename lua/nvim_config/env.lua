local utils = require('nvim_config.utils')

local M = {}

-- Path to Dot Repo
M.DOTFILE_PATH = vim.fn.resolve(utils.script_path() .. '../../')
M.HOME = vim.fn.expand("$HOME")
M.COLORSCHEME = M.HOME .. '/.local/share/nvim/colorscheme.vim'

M.MODULES = {}

return M
