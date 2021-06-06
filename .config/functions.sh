
prev () {
	args=$#
	cols=`tput cols`
	lines=`tput lines`
	for var in "$@"
	do
		$HOME/.config/ranger/scope.sh $var $cols $lines /tmp/cache False
	done
}

# function to execute built-in cd
fasd_fzf() {
    local _cmd=$2
    local _args=${@:3}
    local _fasd_ret="$(fasd $1 $3 | fzf --preview="$HOME/.local/bin/prev {}")"
    # local _fasd_ret="$(fasd -e 'printf %s' "$@")"
    [ -z "$_fasd_ret" ] && return
    $_cmd $(echo $_args | xargs) "$_fasd_ret" 
}


complete -G '*' prev
