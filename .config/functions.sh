
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


# Use fzf as the interactive bit of  fasd
# fasd_fzf <fasd flags> <command to run> [<fasd query>] [<command args>...]
fasd_fzf () {
    local _cmd=$2
    local _args=${@:4}
    local _fasd_ret="$(fasd $1 $3 | fzf-tmux $FZF_TMUX_OPTS --layout=reverse --preview="$HOME/.local/bin/prev {}")"
    [ -z "$_fasd_ret" ] && return
    $_cmd $(echo $_args | xargs) "$_fasd_ret"
}

# Use fasd with fzf, return result inline
# fasd_fzf_inline <fasd flags> [<fasd query>]
fasd_fzf_inline () {
    local _fasd_ret="$(fasd $1 ${@:2} | fzf-tmux $FZF_TMUX_OPTS --layout=reverse --preview="$HOME/.local/bin/prev {}")"
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

fasd_echo () {
    fasd_fzf -la echo -n
}

# Enable file completion for prev function
# complete -G '*' prev

plugin_vim () {
    url=$1
    url=$(echo $url | sed 's{\([^/]+/[^/]+\)${\1{g')
    sed -i ~/.vimrc -e "s{\(.*NEW_PLUGINS.*\){\1\nPlug '$url'{g" > ~/new_vim
    nvim '+:PlugInstall | :qall'
}

swap () {
    file1="$1"
    file2="$2"
    tmp="$1.bak"
    mv -nv $file1 $tmp
    mv -nv $file2 $file1
    mv -nv $tmp $file2
}

nvim_socket () {
    first=1
    # nvim="`ps aux | grep nvim | awk '{ print $11 }' | grep ^/usr/bin/nvim`"
    if [[ -f "$NVIM_LISTEN_ADDRESS" ]]; then
        first=0
    fi
    /usr/bin/nvim $@

    if [[ "$first" == "1" ]]; then
        rm $NVIM_LISTEN_ADDRESS 2>/dev/null
    fi
}

pyhelp () {
    import="$1"
    help="$2"
    version="$3"

    if [[ -z "$help" ]]; then
        help="$import"
    else
        help="$import.$help"
    fi

    if [[ -z "$version" ]]; then
        version="3.7"
    fi

    if [[ "$help" =~ '\.$' ]]; then
        help=${help:0:-1}
        if [[ "$import" =~ '\.$' ]]; then
            import=${import:0:-1}
        fi;
        cmd="import $import; [print(a) for a in dir($help)]"
        py="`python$version -c $cmd`"
        help=$help.$(echo $py | fzf-tmux $FZF_TMUX_OPTS)
    fi;

    bash -c "python$version -c 'import $import; help($help)'"
}

help () {
    out=$($@ --help 2>/dev/null)
    result="$?"

    if [ ! $result -eq 0 ]; then
        out=$($@ -h 2>/dev/null)
        result="$?"
    fi

    if [ ! $result -eq 0 ]; then
        out="$(man $@ 2>/dev/null)"
        result="$?"
    fi

    if [ ! $result -eq 0 ]; then
        echo "Help not found"
        return
    fi

    echo $out | bat -l man
}

# ZLE Widgets
# Leader
bindkey -r '^S'

# Search for Help
help_cmd () {
    cmd="$(print -rC1 -- ${(ko)commands} | fzf-tmux $FZF_TMUX_OPTS)"
    help $cmd
}
zle -N help_cmd
bindkey '^Sh' help_cmd

# Insert Command
insert_cmd () {
    cmd="$(print -rC1 -- ${(ko)commands} | fzf-tmux $FZF_TMUX_OPTS)"
    RBUFFER="${RBUFFER}$cmd "
    zle end-of-line
}
zle -N insert_cmd
bindkey '^Sc' insert_cmd
