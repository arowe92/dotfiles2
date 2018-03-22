
plugins=(git fasd brew extract zsh-autosuggestions vi-mode)

# Set name of the theme to load.
ZSH_THEME="robbyrussell"

###################################
## PATH
###################################
PATH="$PATH:/Users/alexrowe/Programs/Scripts/"
PATH="/Users/alexrowe/Library/Python/3.6/bin:$PATH"
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
PATH="/Library/Frameworks/Python.framework/Versions/3.4/bin:${PATH}"
PATH="/usr/local/mysql/bin:${PATH}"
PATH="/usr/local/opt/mongo/bin:${PATH}"
PATH="/opt/local/bin:/opt/local/sbin:$PATH"
PATH="/usr/local/sbin:$PATH"
export PATH

###################################
## EXPORTS
###################################
# Path to your oh-my-zsh installation.
export ZSH=/Users/alexrowe/.oh-my-zsh
export TERM='xterm-256color'
export SSH_KEY_PATH="~/.ssh/id_rsa"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=0'
export KEYTIMEOUT=1
export _FASD_BACKENDS="native spotlight recently-used current"
export N_PREFIX="$HOME/.n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

###################################
## SOURCES
###################################
source $ZSH/oh-my-zsh.sh

## Source Git autocompletion
# source $HOME/Programs/Scripts/git_zsh

## Source git prompt
source $HOME/.oh-my-zsh/custom/zshrc.sh
source $HOME/.config/functions.sh
source $HOME/.config/aliases.sh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

###################################
## PROMPT
###################################
autoload -Uz colors && colors
PROMPT=' %{$fg[yellow]%}%1~ %{$reset_color%}%{$fg[blue]%}⇒ '
_RPROMPT='%{$reset_color%}$(git_super_status) [%{$fg_no_bold[yellow]%}%~%{$reset_color%}]'
RPROMPT="$_RPROMPT"

###################################
## EVALS
###################################
eval "$(fasd --init auto)"
eval $(thefuck --alias)

###################################
# Key Bindings
###################################

## Vim keybindings in terminal
bindkey -v

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

