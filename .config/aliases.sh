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
alias rmswap="rm /tmp/*.swp; rm /tmp/*.sw;"

alias cranger='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'

alias ls='/bin/ls --color=tty'
_exists exa && alias ls='exa'

## Fasd Aliases
alias a='fasd -a'
alias ax='fasd_fzf_inline -la'
alias d='fasd -d'
alias dx='fasd_fzf_inline -ld'
alias f='fasd -f'
alias fx='fasd_fzf_inline -lf'

alias zz='fasd_fzf -ld cd'

# FZF Aliases
alias fb='git checkout `git branch | sed -e "s/\\*//g" | fzf-tmux -p`'

programs=( \
    "a:nvim" \
    "a:svim" \
    "f:cat" \
    "f:bat" \
    "a:fd" \
    "d:cd" \
    "a:ranger" \
    "a:ls" \
    "d:tree" \
    "a:prev" \
)

for program in ${programs[@]}; do
    flag=$program[1]
    bin=$program[3,-1]
    alias "${bin}x"="fasd_fzf -l$flag $bin"
done;

