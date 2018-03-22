# Path to your oh-my-zsh installation.
export ZSH=/Users/alexrowe/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME="robbyrussell"
#ZSH_THEME="miloshadzic"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git fasd brew extract zsh-autosuggestions vi-mode)

# User configuration
PATH="$PATH:/Users/alexrowe/Programs/Scripts/"
PATH="/Users/alexrowe/Library/Python/3.6/bin:$PATH"
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
PATH="/Library/Frameworks/Python.framework/Versions/3.4/bin:${PATH}"
PATH="/usr/local/mysql/bin:${PATH}"
PATH="/usr/local/opt/mongo/bin:${PATH}"
PATH="/opt/local/bin:/opt/local/sbin:$PATH"
PATH="/usr/local/sbin:$PATH"
export PATH
# export MANPATH="/usr/local/man:$MANPATH"

export TERM='xterm-256color'

source $ZSH/oh-my-zsh.sh

## Source Git autocompletion
source /Users/alexrowe/Programs/Scripts/git_zsh

## Source git prompt
source /Users/alexrowe/Programs/Repos/zsh-git-prompt/zshrc.sh

## Source Yonomi
source /Users/alexrowe/Programs/Yonomi/scripts/yonomirc

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY_PATH="~/.ssh/id_rsa"

## ALIASES
alias alexrowe="ssh alexrowe@home.alexrowe.net"
alias prg='cd ~/Programs'
alias s='git status 2>/dev/null || (pwd && ls -lF)'
alias syn='cd ~/Programs/XCode/Synesthesia'
alias gc='cd ~/Documents/gravity_current'
alias PR='hub pull-request'
alias grandma="ssh eileenmiller@172.249.113.135"
alias asf='cd ~/Library/Application\ Support/ClubDebug';
alias add='git add --patch'
alias doc='cd ~/Documents'
eval $(thefuck --alias)
alias club="cd ~/Programs/XCode/Club"
alias asf="cd /Users/alexrowe/Library/Application\ Support/com.gravitycurrent.synesthesia.debug"
alias git='hub'
alias tf='tail -f'
alias no='ls'
alias todo='todoist'
alias cat='ccat'
alias ls='exa'
alias co='pbcopy -pboard'
alias pa='pbpaste -pboard'
alias gtree='git log --oneline --graph --all --decorate'
alias diff='colordiff'
alias dock='docker-compose'
alias pebble-build="pebble build && pebble install --cloudpebble &&  pebble logs --cloudpebble"
alias vs=code
alias erc='vim ~/.zshrc && source ~/.zshrc'

## Dumb these arent defauted
alias pkill='pkill -lf'
alias pgrep='pgrep -lf'
alias vim='nvim'

a () {
	if [ -z $1 ]; then
		atom .
	else
		atom $1
	fi
}

pdf () {
  pdftohtml -stdout -i $1 | lynx -stdin;
}

# Characters
SEGMENT_SEPARATOR="\ue0b0"
PLUSMINUS="\u00b1"
BRANCH="\ue0a0"
DETACHED="\u27a6"
CROSS="\u2718"
LIGHTNING="\u26a1"
GEAR="\u2699"

## PROMPT
autoload -Uz colors && colors
PROMPT=' %{$fg[yellow]%}%1~ %{$reset_color%}%{$fg[blue]%}⇒ '
#PROMPT='%{ $fg[yellow]%1~ $reset_color$fg[blue]⇒ %}'
_RPROMPT='%{$reset_color%}$(git_super_status) [%{$fg_no_bold[yellow]%}%~%{$reset_color%}]'
RPROMPT="$_RPROMPT"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

## Easy node version switching
set_karabiner() {
  ln -sf "/Users/alexrowe/[<65;86;64M.config/karabiner/karabiner.$1.json" "/Users/alexrowe/.config/karabiner/karabiner.json"
}

## Devkit pro (3ds) Env vars
export DEVKITPRO=/usr/local/lib/devkitPro
export DEVKITARM=${DEVKITPRO}/devkitARM

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=0'

## GO lang
export GOPATH=/usr/local/go
export PATH="$PATH:$GOPATH/bin"

# added by Miniconda3 installer
export PATH="/Users/alexrowe/.miniconda3/bin:$PATH"

## FASD
###################################
export _FASD_BACKENDS="native spotlight recently-used current"

eval "$(fasd --init auto)"

alias aa='fasd -a'        # any
alias ss='fasd -si'       # show / search / select
alias d='fasd -d'        # directory
alias f='fasd -f'        # file
alias sd='fasd -sid'
alias sf='fasd -sif'
alias z='fasd_cd -d'     # cd, same functionality as j in autojump
alias zz='fasd_cd -d -i' # cd with interactive selection

## Program fasd alias
alias af='fasd -a -e atom'
alias sf='fasd -a -e subl'
alias vf='fasd -a -e vim'
alias cf='fasd -a -e cat'
alias o='fasd -a -e open'
alias C='fasd -a | head -n1 | sed "s{[^/]*/{/{" | pbcopy'

alias e='fasd -f -e'

## Vim keybindings in terminal
bindkey -v

alias hist="history | tail -r | peco | sed 's/^\ *[0-9][0-9]*\ *//g'"
bindkey -s '^r' '`hist`\t'
bindkey -s '^f' '`fasd -al | tail -r | peco`\t'
bindkey -s '^b' '`git branch | sed "s/\*//g" | peco`\t'
bindkey -s '^o' 'pbpaste | grep . | tail -n 10 | peco | pbcopy\n'
bindkey -s '^a' 'subl .\n'

bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
# bindkey '^r' history-incremental-search-backward

bindkey '^ ' autosuggest-execute

export KEYTIMEOUT=1

zle-keymap-select () {
    if [ "$TERM" = "xterm-256color" ]; then
        if [ $KEYMAP = vicmd ]; then
            # the command mode for vi
            echo -ne "\e[2 q"
        else
            # the insert mode for vi
            echo -ne "\e[5 q"
        fi
    fi
}

export N_PREFIX="$HOME/.n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).
