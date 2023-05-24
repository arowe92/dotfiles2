return {
    'shaunsingh/moonlight.nvim',
    'edenEast/nightfox.nvim',
    'folke/tokyonight.nvim',
    'rebelot/kanagawa.nvim',

    {
        'rose-pine/neovim',
        as = 'rose-pine',
        config = function()
            require('rose-pine').setup({
                variant = 'moon',
                dark_variant = 'moon',
                disable_italics=true
            })
        end
    }
}
