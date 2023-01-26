-- Smart Insert
function AIndent(mode)
    local lineChars = vim.fn.getline('.')
    if lineChars:gsub("%s+", ""):len() == 0 then
        return '"_cc'
    else
        return mode
    end
end

vim.keymap.set('n', 'A', "v:lua.AIndent('A')", { expr = true })


-- Easy Append
function ToggleTail(char)
    local lineChars = vim.fn.getline('.')
    if lineChars:sub(-1) == char then
        return '$x'
    else
        return vim.api.nvim_replace_termcodes('A' .. char .. '<esc>', true, false, true)
    end
end

vim.keymap.set('n', '<M-,>', "v:lua.ToggleTail(',')", { expr = true })
vim.keymap.set('n', '<M-;>', "v:lua.ToggleTail(';')", { expr = true })

local orig_dir = vim.fn.getcwd()
vim.keymap.set('n', '<leader>cd', '<cmd>cd ' .. orig_dir .. '<CR>')
vim.keymap.set('n', '<leader>c-', '<cmd>cd -<CR>')

