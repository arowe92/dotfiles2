###################################
## PLUGINS
###################################
# zmodload zsh/zprof

DISABLE_UPDATE_PROMPT=true
source ~/.oh-my-zsh/oh-my-zsh.sh
source ~/.zplug/init.zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/pip", from:oh-my-zsh
zplug "plugins/vi-mode", from:oh-my-zsh
zplug "plugins/fzf", from:oh-my-zsh

zplug "clvv/fasd"
zplug "lincheney/fzf-tab-completion", use:"zsh/*"
zplug "zsh-users/zsh-autosuggestions", defer:2
zplug "zsh-users/zsh-history-substring-search", defer:3
zplug "zsh-users/zsh-syntax-highlighting", defer:3

zplug "themes/3den", from:oh-my-zsh, as:theme

zplug load


###################################
## PATH
###################################
PATH="/usr/local/bin:${PATH}"
PATH="$HOME/.local/bin:${PATH}"
PATH="$HOME/.cargo/bin:${PATH}"
PATH="$HOME/.n/bin:${PATH}"
PATH="$DOTFILE_PATH/bin:${PATH}"
export PATH

###################################
## EXPORTS
###################################
## Env Aliases
export ZSH="$HOME/.oh-my-zsh"
export TERM='xterm-256color'
export COLORTERM=truecolor
export SSH_KEY_PATH="~/.ssh/id_rsa"
export KEYTIMEOUT=1
export _FASD_BACKENDS="native spotlight recently-used current"
export N_PREFIX="$HOME/.n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).
export GIT_DISCOVERY_ACROSS_FILESYSTEM=1
export FZF_DEFAULT_COMMAND='fd --color=always'
export FZF_DEFAULT_OPTS='--ansi --bind ctrl-e:preview-up,ctrl-y:preview-down,ctrl-u:preview-page-up,ctrl-d:preview-page-down,ctrl-t:toggle-all --color=hl:yellow,hl+:green'
export FZF_TMUX_OPTS="-p70%,70%"
export FZF_CTRL_R_OPTS="--reverse --preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
export FZF_CTRL_T_COMMAND="fd --color=always"
export NVIM_LISTEN_ADDRESS="/tmp/nvimsocket-$(tmux display-message -p '#{session_name}' 2>/dev/null)"
export BAT_CONFIG_PATH="$HOME/.bat.conf"

# Pagers
_exists () { command -v $1 > /dev/null }
_exists nvim && export EDITOR=nvim
_exists bat && export MANPAGER="sh -c 'col -bx | bat -l man -p'"
_exists bat && export PAGER='bat -p'

###################################
## EVALS
###################################
eval "$(fasd --init auto)";
unalias a && unalias s && unalias sd && unalias sf

eval $(thefuck --alias 2>/dev/null)

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

bindkey -s '^n' 'nvim\n'
bindkey -s '^,' 'ranger\n'
bindkey -M vicmd -s '^n' '^[invim\n'
bindkey -s '^b' '`git branch | fzf`\t'
bindkey -s '^g' 'git checkout `git branch | fzf`\t'
bindkey -s '^sr' 'ranger\n'

# Searching
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

###################################
## SOURCES
###################################
source ~/.fzf.zsh

eval "$(starship init zsh)"
