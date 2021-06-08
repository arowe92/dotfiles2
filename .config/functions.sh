
# View preview of a file, using ranger's scope.sh
prev () {
	args=$#
	cols=`tput cols`
	lines=`tput lines`
	for var in "$@"
	do
		$HOME/.config/ranger/scope.sh $var $cols $lines /tmp/cache False
	done
}

# Open vim in any currently existing tmux pane
svim ()  {
    pane="`tmux list-panes -s -F '#{pane_current_command} #{window_index}.#{pane_index}' | grep nvim | awk '{ print $2 }' | head -n 1`"

    if [ -z "$pane" -o -z "$1" ]; then
        nvim $@
        return 
    fi

    tmux send-keys -t $pane :e `realpath $1` Enter
    tmux select-window -t $pane
    tmux select-pane -t $pane
}

# Use fzf as the interactive bit of  fasd
# fasd_fzf <fasd flags> <command to run> [<fasd query>] [<command args>...]
fasd_fzf () {
    local _cmd=$2
    local _args=${@:4}
    local _fasd_ret="$(fasd $1 $3 | fzf-tmux -p --layout=reverse --preview="$HOME/.local/bin/prev {}")"
    [ -z "$_fasd_ret" ] && return
    $_cmd $(echo $_args | xargs) "$_fasd_ret" 
}

# Use fasd with fzf, return result inline
# fasd_fzf_inline <fasd flags> [<fasd query>]
fasd_fzf_inline () {
    local _fasd_ret="$(fasd $1 ${@:2} | fzf-tmux -p --layout=reverse --preview="$HOME/.local/bin/prev {}")"
    [ -z "$_fasd_ret" ] && return
    echo "$_fasd_ret" 
}

# Same as fasd -e, but works with user defined functions 
# fasd_fn <fasd flags> <command> [<fasd query>] [<command args>]
fasd_fn () {
    local _cmd=$2
    local _args=${@:4}
    local _fasd_ret="$(fasd $1 $3)"
    [ -z "$_fasd_ret" ] && return
    $_cmd $(echo $_args | xargs) "$_fasd_ret" 
}

fasd_svim () {
    fasd_fzf -l svim
}

# Enable file completion for prev function
complete -G '*' prev
