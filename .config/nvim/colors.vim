PlugDef 'tjdevries/colorbuddy.nvim'

PlugDef 'sainnhe/sonokai'
PlugDef 'AlessandroYorba/Sierra'
PlugDef 'AlessandroYorba/Arcadia'
PlugDef 'AlessandroYorba/Despacio'
PlugDef 'AlessandroYorba/Breve'
PlugDef 'AlessandroYorba/Alduin'
PlugDef 'morhetz/gruvbox'

PlugDef 'rafamadriz/neon'
PlugDef 'tomasiser/vim-code-dark'
PlugDef 'marko-cerovac/material.nvim'
PlugDef 'bluz71/vim-nightfly-guicolors'
PlugDef 'bluz71/vim-moonfly-colors'
PlugDef 'ChristianChiarulli/nvcode-color-schemes.vim'
PlugDef 'folke/tokyonight.nvim'
PlugDef 'sainnhe/sonokai'
PlugDef 'kyazdani42/blue-moon'
PlugDef 'mhartington/oceanic-next'
PlugDef 'glepnir/zephyr-nvim'
PlugDef 'rockerBOO/boo-colorscheme-nvim'
PlugDef 'jim-at-jibba/ariake-vim-colors'
PlugDef 'Th3Whit3Wolf/onebuddy'
PlugDef 'ishan9299/modus-theme-vim'
PlugDef 'sainnhe/edge'
PlugDef 'theniceboy/nvim-deus'
PlugDef 'bkegley/gloombuddy'
PlugDef 'Th3Whit3Wolf/one-nvim'
PlugDef 'PHSix/nvim-hybrid'
PlugDef 'Th3Whit3Wolf/space-nvim'
PlugDef 'yonlu/omni.vim'
PlugDef 'ray-x/aurora'
PlugDef 'novakne/kosmikoa.nvim'
PlugDef 'tanvirtin/monokai.nvim'
PlugDef 'savq/melange'
PlugDef 'fenetikm/falcon'
PlugDef 'shaunsingh/nord.nvim'
PlugDef 'MordechaiHadad/nvim-papadark'
PlugDef 'ishan9299/nvim-solarized-lua'
PlugDef 'shaunsingh/moonlight.nvim'
PlugDef 'navarasu/onedark.nvim'
PlugDef 'sainnhe/gruvbox-material'
PlugDef 'sainnhe/everforest'
PlugDef 'NTBBloodbath/doom-one.nvim'
PlugDef 'yashguptaz/calvera-dark.nvim'
PlugDef 'nxvu699134/vn-night.nvim'
PlugDef 'adisen99/codeschool.nvim'
PlugDef 'kdheepak/monochrome.nvim'
PlugDef 'rose-pine/neovim'
PlugDef 'mcchrish/zenbones.nvim'
PlugDef 'Pocco81/Catppuccino.nvim'
PlugDef 'FrenzyExists/aquarium-vim'
PlugDef 'EdenEast/nightfox.nvim'
PlugDef 'kvrohit/substrata.nvim'
PlugDef 'ldelossa/vimdark'
PlugDef 'mangeshrex/uwu.vim'
PlugDef 'adisen99/apprentice.nvim'
PlugDef 'sainnhe/everforest'
PlugDef 'catppuccin/nvim', {'as': 'catppuccin'}
PlugDef 'Th3Whit3Wolf/space-nvim'
PlugDef 'savq/melange'
PlugDef 'mangeshrex/uwu.vim'

" Settings
" Available values: `'default'`, `'atlantis'`, `'andromeda'`, `'shusia'`, `'maia'`, `'espresso'`
let g:sonokai_style = 'andromeda'
let g:sonokai_enable_italic = 0
let g:sonokai_disable_italic_comment = 0

let g:arcadia_Sunset = 1
let g:arcadia_Pitch = 1

lua << EOF
require "catppuccin".setup {
    styles = {
        comments = "italic",
        functions = "NONE",
        keywords = "NONE",
        strings = "NONE",
        variables = "NONE",
        }
    }
EOF
