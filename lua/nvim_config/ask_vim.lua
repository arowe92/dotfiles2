-- :AskVim — ask Claude about Neovim AND this specific config.
-- Pipes prompt via stdin to the `claude` CLI (-p prints + exits) and
-- streams the answer into a floating markdown buffer.

local env = require('nvim_config.env')

local M = {}

local SYSTEM = [[
You are a Neovim expert helping the owner of a personal Neovim config.
You will be given the FULL contents of their config (lua/nvim_config/**/*.lua,
init.lua, KEYBINDINGS.md) followed by a question.

Answer using BOTH general Neovim/Vim knowledge AND their specific setup.
When the question is about "my" keymaps/workflow/plugin (e.g. trouble.nvim,
harpoon, flash, telescope, fzf-lua, gitsigns), ground the answer in their
actual config — quote the exact keymaps and cite the file they live in
(e.g. `lua/nvim_config/plugins/init.lua`).

Be concise. Prefer a short bulleted list of keymaps over prose. If the user's
config doesn't define something they're asking about, say so and suggest the
idiomatic vanilla approach.
]]

local function read_file(path)
    local f = io.open(path, 'r')
    if not f then return nil end
    local content = f:read('*a')
    f:close()
    return content
end

local function gather_context()
    local root = env.DOTFILE_PATH
    local parts = {}

    -- Walk lua/nvim_config recursively for .lua files
    local lua_files = vim.fn.globpath(root .. '/lua/nvim_config', '**/*.lua', false, true)
    table.insert(lua_files, 1, root .. '/init.lua')

    for _, path in ipairs(lua_files) do
        local content = read_file(path)
        if content then
            local rel = path:sub(#root + 2)
            table.insert(parts, string.format('===== FILE: %s =====\n%s\n', rel, content))
        end
    end

    local kb = read_file(root .. '/KEYBINDINGS.md')
    if kb then
        table.insert(parts, string.format('===== FILE: KEYBINDINGS.md =====\n%s\n', kb))
    end

    return table.concat(parts, '\n')
end

local function open_float(title)
    local buf = vim.api.nvim_create_buf(false, true)
    vim.bo[buf].filetype = 'markdown'
    vim.bo[buf].bufhidden = 'wipe'

    local width  = math.min(120, math.floor(vim.o.columns * 0.8))
    local height = math.min(40,  math.floor(vim.o.lines   * 0.8))
    local win = vim.api.nvim_open_win(buf, true, {
        relative = 'editor',
        width    = width,
        height   = height,
        col      = math.floor((vim.o.columns - width) / 2),
        row      = math.floor((vim.o.lines   - height) / 2),
        style    = 'minimal',
        border   = 'rounded',
        title    = ' ' .. title .. ' ',
        title_pos = 'center',
    })

    vim.keymap.set('n', 'q',     '<cmd>close<cr>', { buffer = buf, silent = true })
    vim.keymap.set('n', '<esc>', '<cmd>close<cr>', { buffer = buf, silent = true })

    return buf, win
end

local function append(buf, text)
    if not vim.api.nvim_buf_is_valid(buf) then return end
    local lines = vim.split(text, '\n', { plain = true })
    local last = vim.api.nvim_buf_line_count(buf)
    local last_line = vim.api.nvim_buf_get_lines(buf, last - 1, last, false)[1] or ''
    lines[1] = last_line .. lines[1]
    vim.bo[buf].modifiable = true
    vim.api.nvim_buf_set_lines(buf, last - 1, last, false, lines)
    vim.bo[buf].modifiable = false
end

function M.ask(question)
    question = vim.trim(question or '')
    if question == '' then
        vim.notify('AskVim: empty question', vim.log.levels.WARN)
        return
    end

    if vim.fn.executable('claude') == 0 then
        vim.notify('AskVim: `claude` CLI not found in PATH', vim.log.levels.ERROR)
        return
    end

    local buf = open_float('AskVim: ' .. question)
    vim.bo[buf].modifiable = true
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, { '*thinking...*', '' })
    vim.bo[buf].modifiable = false

    local context = gather_context()
    local prompt = SYSTEM
        .. '\n\n===== USER CONFIG =====\n'
        .. context
        .. '\n===== QUESTION =====\n'
        .. question
        .. '\n'

    local started = false
    local job = vim.fn.jobstart({ 'claude', '-p' }, {
        stdout_buffered = false,
        on_stdout = vim.schedule_wrap(function(_, data)
            if not data then return end
            if not started then
                if vim.api.nvim_buf_is_valid(buf) then
                    vim.bo[buf].modifiable = true
                    vim.api.nvim_buf_set_lines(buf, 0, -1, false, { '' })
                    vim.bo[buf].modifiable = false
                end
                started = true
            end
            append(buf, table.concat(data, '\n'))
        end),
        on_stderr = vim.schedule_wrap(function(_, data)
            if not data or (#data == 1 and data[1] == '') then return end
            append(buf, '\n[stderr] ' .. table.concat(data, '\n'))
        end),
        on_exit = vim.schedule_wrap(function(_, code)
            if code ~= 0 then
                append(buf, string.format('\n\n*[claude exited with code %d]*', code))
            end
        end),
    })

    if job <= 0 then
        vim.notify('AskVim: failed to start claude', vim.log.levels.ERROR)
        return
    end

    vim.fn.chansend(job, prompt)
    vim.fn.chanclose(job, 'stdin')
end

vim.api.nvim_create_user_command('AskVim', function(opts)
    M.ask(opts.args)
end, { nargs = '+', desc = 'Ask Claude about Neovim + your config' })

vim.keymap.set('n', '<leader>?', function()
    vim.ui.input({ prompt = 'AskVim: ' }, function(input)
        if input and input ~= '' then M.ask(input) end
    end)
end, { desc = 'AskVim prompt' })

return M
