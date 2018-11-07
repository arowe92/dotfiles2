unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac
echo ${machine}

mkalias () {
  echo alias $1="\"${@:2}\"" >> ~/.config/aliases.sh
  echo alias $1="\"${@:2}\""
  source ~/.config/aliases.sh
}

_exists () {
    command -v $1
}

## Aliases
alias s='git status 2>/dev/null || (pwd && ls -lF)'
alias add='git add --patch'
alias tf='tail -f'
alias erc='vim ~/.zshrc && source ~/.zshrc'

if [ "$machine" -eq "Mac" ]; then
    alias pkill='pkill -lf'
    alias pgrep='pgrep -lf'
    alias co='pbcopy -pboard'
    alias pa='pbpaste -pboard'
fi

_exists hub && alias git='hub'
_exists colordiff && alias diff='colordiff'
_exists nvim && alias vim='nvim'
_exists ccat && alias cat='ccat'
_exists exa && alias ls='exa'

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
