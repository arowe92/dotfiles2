local DOTFILE_PATH = require('nvim_config.env').DOTFILE_PATH;
local nmapc = require('nvim_config.utils').nmapc
local nmap = require('nvim_config.utils').nmap
local nmapc2 = require('nvim_config.utils').nmapc_text

-- Edit Files
nmapc('<leader>ed', "e " .. DOTFILE_PATH)
nmapc('<leader>ep', "e " .. DOTFILE_PATH .. '/lua/nvim_config/plugins/init.lua')
nmapc('<leader>ek', "e " .. DOTFILE_PATH .. '/lua/nvim_config/keymap.lua')
nmapc('<leader>en', "e " .. DOTFILE_PATH .. '/lua/nvim_config/functions.lua')
nmapc('<leader>ei', "e " .. DOTFILE_PATH .. '/lua/nvim_config/init.lua')
nmapc('<leader>ev', "e " .. DOTFILE_PATH .. '/.vimrc')

-- CDing
nmapc('<leader>ef', 'cd %:p:h')
nmapc('<leader>yf', 'let @" = expand("%")')

-- Run
nmapc('<leader>xf', "luafile %")
nmapc('<leader>xc', 'PackerCompile')
nmapc('<leader>xi', 'PackerInstall')

-- Misc
vim.keymap.set('n', '<a-5>', ':%s///g<Left><Left><Left>')

-- Fuzzy Find Quick Keys
nmapc('<C-p>', 'Files')
nmapc('<M-f>', 'Telescope live_grep')
nmapc('<M-p>', 'Telescope buffers')
nmapc('<S-M-p>', 'Telescope oldfiles')
nmapc('<M-r>', 'Telescope commands')
nmapc('<M-t>', 'Telescope lsp_document_symbols')

-- Telescope
nmapc('<leader>pp', 'Telescope find_files')
nmapc('<leader>pg', 'Telescope git_files')
nmapc('<leader>pF', 'Telescope live_grep')
nmapc('<leader>ph', 'Telescope help_tags')
nmapc('<leader>pc', 'Telescope commands')
nmapc('<leader>pf', 'Telescope current_buffer_fuzzy_find')

-- FZF
nmapc('<leader>pi', 'Include')
nmapc('<leader>pC', 'FuzzyCheckout')
nmapc('<leader>pG', 'FuzzyGedit')
nmapc('<leader>pR', 'FuzzyReset')

-- Find Word anywhere
nmapc('gw', 'exe "Rg ".expand("<cword>")')

vim.keymap.set('n', '<leader>xr', function()
    for k, v in pairs(package.loaded) do
        if string.match(k, "^nvim_config") then
            package.loaded[k] = nil
        end
        require('nvim_config')

        vim.cmd('PackerCompile')
    end
end)

