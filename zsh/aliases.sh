# aliases.sh
# Various Aliases

# Add an alias to alias file
mkalias () {
  echo alias $1="\"${@:2}\"" >> $DOTFILE_PATH/.config/aliases.sh
  echo alias $1="\"${@:2}\""
  source $DOTFILE_PATH/.config/aliases.sh
}

# Add an alias to zshrc file
mkalias_rc () {
  echo alias $1="\"${@:2}\"" >> ~/.zshrc
  echo alias $1="\"${@:2}\""
  alias $1="\"${@:2}\""
}

# Check if sonething exists
_exists () {
    command -v $1 > /dev/null
}

########################
# General Aliases
########################
alias s='git status 2>/dev/null || (pwd && ls -lF)'
alias add='git add --patch'
alias rmswap="rm /tmp/*.swp; rm /tmp/*.sw; rm $HOME/.local/share/nvim/swap/*"
alias qvim="VIM_LITE=1 nvim"
alias cap="tmux capture-pane -p -S -"
alias ezsync="rsync -azvpH"

alias ls='/bin/ls --color=tty'
_exists exa && alias ls='exa'
_exists ugrep && alias zg='ugrep -B5 -A5 --fuzzy=+3'

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

alias cmds='print -rC1 -- ${(ko)commands} | fzf-tmux $FZF_TMUX_OPTS'

########################
# Create fasd aliases
# <flag>:executable
# a,f,d: files directory or both
########################
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

alias py="python3"

########################
# NEW ALIASES
########################
alias ipy="ipython"
alias gb="git br | grep \* | awk '{print \$2}'"
alias dco="docker-compose"
alias ports="sudo netstat -tulpn | grep LISTEN"
alias pkill="\pkill -9 -fc"
