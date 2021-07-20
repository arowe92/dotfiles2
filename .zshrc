###################################
## PLUGINS
###################################
source ~/.oh-my-zsh/oh-my-zsh.sh
source ~/.zplug/init.zsh

zplug "plugins/git", from:oh-my-zsh
zplug "plugins/pip", from:oh-my-zsh
zplug "plugins/vi-mode", from:oh-my-zsh
zplug "plugins/fzf", from:oh-my-zsh

zplug "clvv/fasd"
zplug "zsh-users/zsh-autosuggestions", defer:2
zplug "zsh-users/zsh-history-substring-search", defer:3

zplug "themes/tonotdo", from:oh-my-zsh, as:theme

zplug load


###################################
## PATH
###################################
PATH="/usr/local/bin:${PATH}"
PATH="$HOME/.local/bin:${PATH}"
PATH="$HOME/.cargo/bin:${PATH}"
PATH="$HOME/.n/bin:${PATH}"
export PATH

###################################
## EXPORTS
###################################
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export TERM='xterm-256color'
export SSH_KEY_PATH="~/.ssh/id_rsa"
export KEYTIMEOUT=1
export EDITOR=nvim
export _FASD_BACKENDS="native spotlight recently-used current"
export N_PREFIX="$HOME/.n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).
export GIT_DISCOVERY_ACROSS_FILESYSTEM=1
export FZF_TMUX_OPTS="-p -w 65% -p 45%"
export FZF_CTRL_R_OPTS="--reverse --preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
export FZF_DEFAULT_COMMAND='ag --nocolor --ignore node_modules -g ""'
export FZF_DEFAULT_OPTS='--bind ctrl-e:preview-up,ctrl-y:preview-down,ctrl-u:preview-page-up,ctrl-d:preview-page-down --keep-right'

###################################
## EVALS
###################################
eval "$(fasd --init auto)";
eval $(thefuck --alias 2>/dev/null)

###################################
## SOURCES
###################################
## Source git prompt
source $HOME/.config/functions.sh
source $HOME/.config/aliases.sh

###################################
# Key Bindings
###################################

## Vim keybindings in terminal
bindkey -v

bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word

bindkey '^ ' autosuggest-execute
bindkey -M vicmd v edit-command-line

zle -N fasd_svim
bindkey '^o' fasd_svim

bindkey -s '^f' '`fzf`'
bindkey -s '^n' 'nvim\n'
bindkey -M vicmd -s '^n' '^[invim\n'
bindkey -s '^b' '`git br | fzf`\t'

# Searching
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
