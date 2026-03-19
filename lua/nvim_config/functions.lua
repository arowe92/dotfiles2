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

-- Toggle Menu
local toggles = {
    {
        name = "Word Wrap",
        state = function() return vim.o.wrap end,
        toggle = function() vim.o.wrap = not vim.o.wrap end,
    },
    {
        name = "Mouse",
        state = function() return vim.o.mouse == "a" end,
        toggle = function() vim.o.mouse = vim.o.mouse == "a" and "" or "a" end,
    },
    {
        name = "Auto Comments",
        state = function() return vim.o.formatoptions:find("c") ~= nil end,
        toggle = function()
            if vim.o.formatoptions:find("c") then
                vim.cmd("set formatoptions-=cro")
            else
                vim.cmd("set formatoptions+=cro")
            end
        end,
    },
    {
        name = "Show Invisibles",
        state = function() return vim.o.list end,
        toggle = function() vim.o.list = not vim.o.list end,
    },
    {
        name = "Show Spaces",
        state = function() return vim.o.list and vim.opt.listchars:get().space ~= nil end,
        toggle = function()
            if vim.o.list and vim.opt.listchars:get().space then
                vim.opt.listchars:remove("space")
            else
                vim.opt.list = true
                vim.opt.listchars:append({ space = "·", lead = "·" })
            end
        end,
    },
    {
        name = "Diagnostics",
        state = function() return vim.diagnostic.is_enabled() end,
        toggle = function()
            vim.diagnostic.enable(not vim.diagnostic.is_enabled())
        end,
    },
    {
        name = "Relative Line Numbers",
        state = function() return vim.o.relativenumber end,
        toggle = function() vim.o.relativenumber = not vim.o.relativenumber end,
    },
    {
        name = "Cursor Line",
        state = function() return vim.o.cursorline end,
        toggle = function() vim.o.cursorline = not vim.o.cursorline end,
    },
    {
        name = "Spell Check",
        state = function() return vim.o.spell end,
        toggle = function() vim.o.spell = not vim.o.spell end,
    },
}

local function toggle_menu()
    local items = {}
    for _, t in ipairs(toggles) do
        local ok, state = pcall(t.state)
        local indicator = ok and (state and "[x]" or "[ ]") or "[?]"
        table.insert(items, indicator .. " " .. t.name)
    end

    require("fzf-lua").fzf_exec(items, {
        prompt = "Toggle> ",
        winopts = { height = 0.4, width = 0.35 },
        fzf_opts = { ["--no-sort"] = true },
        actions = {
            ["default"] = function(selected)
                if not selected or not selected[1] then return end
                -- strip ANSI codes then grab everything after "] "
                local clean = selected[1]:gsub("\27%[[%d;]*m", "")
                local name = clean:match("%] (.+)$")
                if not name then
                    vim.notify("toggle menu: no match in: " .. vim.inspect(selected[1]), vim.log.levels.WARN)
                    return
                end
                for _, t in ipairs(toggles) do
                    if t.name == name then
                        local ok, err = pcall(t.toggle)
                        if not ok then
                            vim.notify("toggle error: " .. tostring(err), vim.log.levels.ERROR)
                        end
                        return
                    end
                end
            end,
        },
    })
end

vim.keymap.set("n", "<leader>pt", toggle_menu, { desc = "Toggle settings" })
