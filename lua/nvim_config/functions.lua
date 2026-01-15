-- Smart Insert
local function smart_insert(mode)
    local lineChars = vim.fn.getline('.')
    if lineChars:gsub("%s+", ""):len() == 0 then
        return '"_cc'
    else
        return mode
    end
end

vim.keymap.set('n', 'A', function() return smart_insert('A') end, { expr = true })

-- Easy Append
local function toggle_tail(char)
    local lineChars = vim.fn.getline('.')
    if lineChars:sub(-1) == char then
        return '$x'
    else
        return vim.api.nvim_replace_termcodes('A' .. char .. '<esc>', true, false, true)
    end
end

vim.keymap.set('n', '<M-,>', function() return toggle_tail(',') end, { expr = true })
vim.keymap.set('n', '<M-;>', function() return toggle_tail(';') end, { expr = true })

local orig_dir = vim.fn.getcwd()
vim.keymap.set('n', '<leader>cd', '<cmd>cd ' .. orig_dir .. '<CR>')
vim.keymap.set('n', '<leader>c-', '<cmd>cd -<CR>')

-- C++ function implementation using clangd
local function implement_function()
    local line = vim.fn.getline('.')
    local line_num = vim.fn.line('.')

    -- Extract function signature (simplified pattern)
    local func_pattern = "^%s*(.-)%s+([%w_]+)%s*%((.-)%)%s*[;{]?%s*$"
    local return_type, func_name, params = line:match(func_pattern)

    if not func_name then
        -- Try multiline function declaration
        local lines = {}
        local start_line = line_num
        local end_line = line_num

        -- Look backwards for function start
        while start_line > 1 do
            local prev_line = vim.fn.getline(start_line - 1)
            if prev_line:match(';%s*$') or prev_line:match('{%s*$') or prev_line:match('}%s*$') then
                break
            end
            start_line = start_line - 1
        end

        -- Look forwards for function end
        while end_line < vim.fn.line('$') do
            local next_line = vim.fn.getline(end_line + 1)
            if next_line:match(';%s*$') or next_line:match('{%s*$') then
                end_line = end_line + 1
                break
            end
            end_line = end_line + 1
        end

        -- Combine lines
        for i = start_line, end_line do
            table.insert(lines, vim.fn.getline(i))
        end
        local full_declaration = table.concat(lines, ' '):gsub('%s+', ' ')
        return_type, func_name, params = full_declaration:match(func_pattern)
    end

    if not func_name then
        print("Could not parse function declaration")
        return
    end

    -- Get class name if we're in a class
    local class_name = nil
    for i = line_num, 1, -1 do
        local check_line = vim.fn.getline(i)
        local class_match = check_line:match('^%s*class%s+([%w_]+)')
        if class_match then
            class_name = class_match
            break
        end
    end

    -- Switch to cpp file
    vim.cmd('LspClangdSwitchSourceHeader')

    -- Create function implementation
    local implementation = ""
    if class_name then
        implementation = string.format("%s %s::%s(%s) {\n    // TODO: Implement\n}",
            return_type or "void", class_name, func_name, params or "")
    else
        implementation = string.format("%s %s(%s) {\n    // TODO: Implement\n}",
            return_type or "void", func_name, params or "")
    end

    -- Go to end of file and add implementation
    vim.cmd('normal! G')
    vim.cmd('normal! o')
    vim.cmd('normal! o' .. implementation)
    vim.cmd('normal! k')
    print(string.format("Added %s stub to cpp file", func_name))
end

vim.keymap.set('n', '<leader>ci', implement_function, { desc = 'Implement function in cpp file' })


