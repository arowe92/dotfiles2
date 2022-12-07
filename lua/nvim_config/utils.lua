local M = {}

-- Mapping Convenience
M.nmapc = function(lhs, rhs)
    vim.keymap.set('n', lhs, '<cmd>' .. rhs .. '<CR>')
end

-- Mapping Convenience
M.nmapc_text= function(lhs, rhs, text)
    if not text then
        text = rhs:gsub('"', '\\"')
    end

    vim.keymap.set('n', lhs, '<cmd>' .. rhs .. ' | echo "'..text..'"<cr>')
end

-- Get path to script that is calling this functions
M.script_path = function()
    local str = debug.getinfo(2, 'S').source:sub(2)

    local is_win = package.config:sub(1, 1) == '\\'
    if is_win then
        str = str:gsub('/', '\\')
    end

    local sep = '/'
    if is_win then
        sep = '\\'
    end

    return str:match('(.*' .. sep .. ')')
end

return M
