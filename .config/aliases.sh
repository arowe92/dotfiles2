
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
alias pkill='pkill -lf'
alias pgrep='pgrep -lf'
alias vim='nvim'

###################################
# FASD
###################################
alias aa='fasd -a'        # any
alias ss='fasd -si'       # show / search / select
alias d='fasd -d'        # directory
alias f='fasd -f'        # file
alias sd='fasd -sid'
alias sf='fasd -sif'
alias z='fasd_cd -d'     # cd, same functionality as j in autojump
alias zz='fasd_cd -d -i' # cd with interactive selection
alias e='fasd -f -e'

alias hist="history | tail -r | peco | sed 's/^\ *[0-9][0-9]*\ *//g'"