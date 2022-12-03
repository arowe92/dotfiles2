local utils = require('nvim_config.utils')

local M = {}

-- Path to Dot Repo
M.DOTFILE_PATH = vim.fn.resolve(utils.script_path() .. '../../')

return M
