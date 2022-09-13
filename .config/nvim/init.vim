set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

if exists('g:vscode')
    source $DOTFILE_PATH . ".config/nvim/vscode.vim"
endif
