
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

alias fr='fasd -e ranger -d'
alias todo="vim +:TD"
alias cranger='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'

alias a='fasd -a'

alias d='fasd -d'
alias di='fasd -d -l | fzf'

alias f='fasd -f'
alias fv='fasd -e nvim'
alias fvi='fasd_fzf -l nvim'


alias zz='fasd_fzf -ld cd'
