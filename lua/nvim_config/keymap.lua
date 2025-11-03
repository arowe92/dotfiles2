local DOTFILE_PATH = require('nvim_config.env').DOTFILE_PATH;
local nmapc = require('nvim_config.utils').nmapc
local nmap = require('nvim_config.utils').nmap
local nmapc2 = require('nvim_config.utils').nmapc_text

-- Edit Files
nmapc('<leader>en', "e ~/notes.md")
nmapc('<leader>et', "e ~/todo.md")

nmapc('<leader>ed', "e " .. DOTFILE_PATH)
nmapc('<leader>ep', "e " .. DOTFILE_PATH .. '/lua/nvim_config/plugins/init.lua')
nmapc('<leader>ek', "e " .. DOTFILE_PATH .. '/lua/nvim_config/keymap.lua')
nmapc('<leader>ei', "e " .. DOTFILE_PATH .. '/lua/nvim_config/init.lua')
nmapc('<leader>ev', "e " .. DOTFILE_PATH .. '/.vimrc')

-- CDing
nmapc('<leader>ef', 'cd %:p:h')
nmapc('<leader>yf', 'let @" = expand("%")')

-- Run
nmapc('<leader>xf', "luafile %")
nmapc('<leader>xc', 'PackerCompile')
nmapc('<leader>xi', 'PackerInstall')

-- Tabs
nmapc('<M-Up>', 'tabprev')
nmapc('<M-Down>', 'tabnext')

-- Misc
vim.keymap.set('n', '<a-5>', ':%s///g<Left><Left><Left>')
vim.keymap.set('t', '<c-h>', '<c-\\><c-n><c-h>')
vim.keymap.set('v', 'Y', function ()
    vim.cmd "set clipboard=unnamedplus"
    vim.cmd "normal! y"
    vim.cmd "set clipboard="
end)

-- Fuzzy Find Quick Keys
nmapc('<C-p>', 'FzfLua files')
nmapc('<M-f>', 'FzfLua live_grep')
nmapc('<M-p>', 'FzfLua buffers')
nmapc('<S-M-p>', 'FzfLua oldfiles')
nmapc('<M-r>', 'FzfLua commands')
nmapc('<S-M-r>', 'FzfLua command_history')
nmapc('<M-t>', 'FzfLua lsp_document_symbols')
nmapc('<leader>/', 'FzfLua lgrep_curbuf')
vim.keymap.set('n', '<c-t>', ':Telescope ')

-- Telescope
nmapc('<leader>pp', 'FzfLua files')
nmapc('<leader>pg', 'FzfLua git_files')
nmapc('<leader>po', 'FzfLua oldfiles')
nmapc('<leader>pF', 'FzfLua live_grep')
nmapc('<leader>ph', 'FzfLua help_tags')
nmapc('<leader>pc', 'FzfLua commands')
nmapc('<leader>pf', 'FzfLua lgrep_curbuf')
nmapc('<leader>pr', 'FzfLua resume')
nmapc('<leader>pm', 'FzfLua marks')
nmapc('<leader>pk', 'FzfLua keymaps')

nmapc('<leader>pd', 'FzfLua lsp_document_diagnostics')
nmapc('<leader>pw', 'FzfLua lsp_workspace_diagnostics')
nmapc('<leader>pR', 'FzfLua lsp_references')
nmapc('<leader>pD', 'FzfLua lsp_declarations')
nmapc('<leader>pF', 'FzfLua lsp_definitions')
nmapc('<leader>pA', 'FzfLua lsp_code_actions')

nmapc('<leader>pz', 'FzfLua')

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

nmapc('<M-CR>', 'popup PopUp')
vim.cmd('aunmenu PopUp')
vim.cmd('noremenu PopUp.Declaration <cmd>lua vim.lsp.buf.declaration()<cr>')
vim.cmd('noremenu PopUp.Definition <cmd>lua vim.lsp.buf.definition()<cr>')
vim.cmd('noremenu PopUp.Implementation <cmd>lua vim.lsp.buf.implementation()<cr>')
vim.cmd('noremenu PopUp.Type\\ Definition <cmd>lua vim.lsp.buf.type_definition()<cr>')
vim.cmd('noremenu PopUp.-1- <NOP>')
vim.cmd('noremenu PopUp.Search <cmd>execute "grep <cword>"<cr>')
vim.cmd('noremenu PopUp.References <cmd>lua vim.lsp.buf.references()<cr>')
vim.cmd('noremenu PopUp.Signature <cmd>lua vim.lsp.buf.signature_help()<cr>')
vim.cmd('noremenu PopUp.-2- <NOP>')
vim.cmd('noremenu PopUp.Rename <cmd>lua vim.lsp.buf.rename()<cr>')

