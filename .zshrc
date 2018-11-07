###################################
## PLUGINS
###################################
source ~/.oh-my-zsh/custom/antigen.zsh

antigen use oh-my-zsh
antigen bundle git
antigen bundle pip
antigen bundle vi-mode
antigen bundle clvv/fasd
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle git-prompt

antigen theme robbyrussell

antigen apply

###################################
## PATH
###################################
PATH="/usr/local/bin:${PATH}"
export PATH

###################################
## EXPORTS
###################################
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export TERM='xterm-256color'
export SSH_KEY_PATH="~/.ssh/id_rsa"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=0'
export KEYTIMEOUT=1
export EDITOR=vim
export _FASD_BACKENDS="native spotlight recently-used current"
export N_PREFIX="$HOME/.n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

###################################
## SOURCES
###################################
## Source Git autocompletion
# source $HOME/Programs/Scripts/git_zsh

## Source git prompt
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
# eval $(thefuck --alias)

###################################
# Key Bindings
###################################

## Vim keybindings in terminal
bindkey -v

# bindkey -s '^r' '`hist`\t'
# bindkey -s '^f' '`fasd -al | tail -r | peco`\t'
# bindkey -s '^b' '`git branch | sed "s/\*//g" | peco`\t'
# bindkey -s '^o' 'pbpaste | grep . | tail -n 10 | peco | pbcopy\n'

bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word

bindkey '^ ' autosuggest-execute
