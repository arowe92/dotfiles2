local components = {
    scrollbar = {
        function()
            return 'foo'
        end,
        padding = { left = 0, right = 0 },
        -- color = "SLProgress",
        cond = nil,
    },
}

return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    config = function()
        require('lualine').setup({
            globalstatus = true,
            sections = {
                lualine_a = {
                    { 'mode' },
                },
                lualine_b = { 'filename', 'branch' },
                lualine_c = { function ()
                    return vim.fn.getcwd():gsub('/home/arowe/', '~/')
                end},
                lualine_x = { 'searchcount' },
                lualine_y = { 'filetype' },
                lualine_z = {
                    function()
                        local current_line = vim.fn.line "."
                        local total_lines = vim.fn.line "$"
                        local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
                        local line_ratio = current_line / total_lines
                        local index = math.ceil(line_ratio * #chars)
                        return chars[index]
                    end,
                },
            },
        })
    end
}
