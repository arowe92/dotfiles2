
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
alias dfi="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
alias rmswap="rm /tmp/*.swp; rm /tmp/*.sw;"

_exists hub && alias git='hub'
_exists colordiff && alias diff='colordiff'
_exists svim && alias vim='svim'
_exists ccat && alias cat='ccat'
_exists exa && alias ls='exa'

alias todo="vim +:TD"
alias cranger='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'

## Fasd Aliases
alias a='fasd -a'
alias ai='fasd_fzf_inline -la'
alias d='fasd -d'
alias di='fasd_fzf_inline -ld'
alias f='fasd -f'
alias fi='fasd_fzf_inline -lf'

alias fvi='fasd_fzf -l svim'

alias fv='fasd_fn -a svim'
alias fr='fasd_fn -d ranger'
alias fp='fasd_fn -a prev'

alias zz='fasd_fzf -ld cd'
alias ff="find . -name"

# FZF Aliases
alias fb='git checkout `git branch | sed -e "s/\\*//g" | fzf-tmux -p`'
alias fz='cat $HOME/.vim/plugin/pythia_targets | fzf-tmux -p'
