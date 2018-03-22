
mkalias () {
  echo alias $1="\"${@:2}\"" >> ~/.config/aliases.sh
  echo alias $1="\"${@:2}\""
  source ~/.config/aliases.sh
}

## Aliases
alias s='git status 2>/dev/null || (pwd && ls -lF)'
alias add='git add --patch'
alias doc='cd ~/Documents'
alias git='hub'
alias tf='tail -f'
alias no='ls'
alias cat='ccat'
alias ls='exa'
alias co='pbcopy -pboard'
alias cb='pbcopy -pboard'
alias pa='pbpaste -pboard'
alias gtree='git log --oneline --graph --all --decorate'
alias diff='colordiff'
alias erc='vim ~/.zshrc && source ~/.zshrc'

## Dumb these arent defauted
alias pkill='pkill -lf'
alias pgrep='pgrep -lf'
alias vim='nvim'

# Generated
