" :set guicursor=
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

if has('nvim-0.5')
lua <<EOF
require'nvim-treesitter.configs'.setup {
    ensure_installed = { "cpp" }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    ignore_install = { }, -- List of parsers to ignore installing
    highlight = {
        enable = true,              -- false will disable the whole extension
        disable = { },  -- list of language that will be disabled
    },
    indent = {
        enable = false
    },
    incremental_selection = {
        enable = true
    }
}
EOF

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
endif
