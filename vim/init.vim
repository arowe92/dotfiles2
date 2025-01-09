let s:path = expand('<sfile>:p:h')

let g:python3_host_prog = '/mnt/c/Users/alexr/.pyenv/pyenv-win/shims/python'

exe "source " . s:path . "/keymap.vim"
exe "source " . s:path . "/options.vim"
exe "source " . s:path . "/commands.vim"
exe "source " . s:path . "/search.vim"

