
mkalias () {
  echo alias $1="\"${@:2}\"" >> ~/.config/aliases.sh
  echo alias $1="\"${@:2}\""
  source ~/.config/aliases.sh
}

_exists () {
    command -v $1 > /dev/null
}

## Aliases
alias s='git status 2>/dev/null || (pwd && ls -lF)'
alias add='git add --patch'
alias tf='tail -f'
alias erc='vim ~/.zshrc && source ~/.zshrc'

_exists hub && alias git='hub'
_exists colordiff && alias diff='colordiff'
_exists nvim && alias vim='nvim'
_exists ccat && alias cat='ccat'
_exists exa && alias ls='exa'

alias dfi="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
alias pl="powershell.exe"
