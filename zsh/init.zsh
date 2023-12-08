export DOTFILE_PATH="${0:a:h:h}"

###################################
## PLUGINS
###################################
autoload -Uz compinit && compinit

# Vim Edit
autoload edit-command-line
zle -N edit-command-line

if [[ ! $HOME/.zsh_plugins.zsh -nt $DOTFILE_PATH/zsh_plugins.txt ]]; then
	source ${ZDOTDIR:-~}/.antidote/antidote.zsh
	antidote bundle <$DOTFILE_PATH/zsh_plugins.txt > $HOME/.zsh_plugins.zsh
fi
source $HOME/.zsh_plugins.zsh

#antidote load

compinit

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
export TMUX_SHELL="$(which zsh)"
export TERM='xterm-256color'
export COLORTERM=truecolor
export SSH_KEY_PATH="~/.ssh/id_rsa"
export KEYTIMEOUT=1
export _FASD_BACKENDS="native spotlight recently-used current"
export N_PREFIX="$HOME/.n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).
export GIT_DISCOVERY_ACROSS_FILESYSTEM=1
export NVIM_LISTEN_ADDRESS="/tmp/nvimsocket-$(tmux display-message -p '#{session_name}' 2>/dev/null)"
export BAT_CONFIG_PATH="$DOTFILE_PATH/.config/bat.conf"
export RIPGREP_CONFIG_PATH="$DOTFILE_PATH/.config/ripgreprc"
export FZF_PATH="/home/linuxbrew/.linuxbrew/opt/fzf"

# Pagers
_exists () { command -v $1 > /dev/null }
_exists nvim && export EDITOR=nvim
_exists bat && export MANPAGER="sh -c 'col -bx | bat -l man -p'"
_exists bat && export PAGER='bat -p'

###################################
## EVALS
###################################
_exists fasd && eval "$(fasd --init auto)";
unalias a && unalias s && unalias sd && unalias sf

_exists thefuck && eval $(thefuck --alias 2>/dev/null)
_exists starship && eval "$(starship init zsh)"

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
source $DOTFILE_PATH/zsh/aliases.sh
source $DOTFILE_PATH/zsh/functions.sh
source $DOTFILE_PATH/zsh/ctrlp.zsh
source $DOTFILE_PATH/zsh/fzf.zsh


