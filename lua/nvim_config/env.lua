local utils = require('nvim_config.utils')

local M = {}

-- Path to Dot Repo
M.DOTFILE_PATH = vim.fn.resolve(utils.script_path() .. '../../')
M.HOME = vim.fn.expand("$HOME")
M.COLORSCHEME = M.HOME .. '/.local/share/nvim/colorscheme.vim'

-- Lite mode: disabled heavy plugins for quick edits (git commits, etc.)
M.LITE_MODE = vim.env.NVIM_LITE == "1" or vim.env.NVIM_LITE == "true"

M.MODULES = {}

return M
