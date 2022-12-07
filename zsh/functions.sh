# functions.sh
# Various non-alias functions and widgets

#############################################################
#  FASD-FZF Interactions
#############################################################
##
# Use fzf as the interactive bit of  fasd
# fasd_fzf <fasd flags> <command to run> [<fasd query>] [<command args>...]
##
fasd_fzf () {
    local _cmd=$2
    local _args=${@:4}
    local _fasd_ret="$(fasd $1 $3 | tac | fzf-tmux $FZF_TMUX_OPTS --layout=reverse --preview="$HOME/.local/bin/prev {}")"
    [ -z "$_fasd_ret" ] && return
    $_cmd $(echo $_args | xargs) "$_fasd_ret"
}

##
# Use fasd with fzf, return result inline
# fasd_fzf_inline <fasd flags> [<fasd query>]
##
fasd_fzf_inline () {
    local _fasd_ret="$(fasd $1 ${@:2} | tac | fzf-tmux $FZF_TMUX_OPTS --layout=reverse --preview="$HOME/.local/bin/prev {}")"
    [ -z "$_fasd_ret" ] && return
    echo "$_fasd_ret"
}

##
# Same as fasd -e, but works with user defined functions
# fasd_fn <fasd flags> <command> [<fasd query>] [<command args>]
##
fasd_fn () {
    local _cmd=$2
    local _args=${@:4}
    local _fasd_ret="$(fasd $1 $3)"
    [ -z "$_fasd_ret" ] && return
    $_cmd $(echo $_args | xargs) "$_fasd_ret"
}

##
# Find a file and echo its path
##
fasd_echo () {
    fasd_fzf -la echo -n
}

#############################################################
#  Docker Functions
#############################################################
function dock () {
    folder="${PWD##*/}"
    tag="latest"
    case "$1" in

    b)
        docker build . -t "$folder:$tag"
        ;;

    r)
        docker run -it --rm "$folder:$tag" $2
        ;;

    *)
        echo "Options: [r]un, [b]uild"
        ;;
esac
}



#############################################################
#  General Functions
#############################################################
## TODO fix
# View preview of a file, using ranger's scope.sh
##
prev () {
	args=$#
	cols=`tput cols`
	lines=`tput lines`
	for var in "$@"
	do
		$HOME/.config/ranger/scope.sh $var $cols $lines /tmp/cache False
	done
}


# TODO fix
# Enable file completion for prev function
# complete -G '*' prev
plugin_vim () {
    url=$1
    url=$(echo $url | sed 's{\([^/]+/[^/]+\)${\1{g')
    sed -i ~/.vimrc -e "s{\(.*NEW_PLUGINS.*\){\1\nPlug '$url'{g" > ~/new_vim
    nvim '+:PlugInstall | :qall'
}

##
# Swap Two files
# @usage swap file1 file2
##
swap () {
    file1="$1"
    file2="$2"
    tmp="$1.bak"
    mv -nv $file1 $tmp
    mv -nv $file2 $file1
    mv -nv $tmp $file2
}


##
# Open NVIM  With reseting a the socket
##
nvim_socket () {
    first=1
    # nvim="`ps aux | grep nvim | awk '{ print $11 }' | grep ^/usr/bin/nvim`"
    if [[ -f "$NVIM_LISTEN_ADDRESS" ]]; then
        first=0
    fi
    \nvim $@

    if [[ "$first" == "1" ]]; then
        rm $NVIM_LISTEN_ADDRESS 2>/dev/null
    fi
}

##
# Navigate through python help documents
# @usage pyhelp <package> [<module>] [<python_version>]
##
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

##
# Get help for a command
# Tries --help, -h and man
##
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

##############################################################
# ZLE Widgets
#############################################################
# Leader
bindkey -r '^S'

###############################
# Search Help Widget
# @hotkey h
###############################
help_cmd () {
    cmd="$(print -rC1 -- ${(ko)commands} | fzf-tmux $FZF_TMUX_OPTS)"
    help $cmd
}
zle -N help_cmd
bindkey '^Sh' help_cmd

###############################
# Search Commands Widget
# @hotkey c
###############################
insert_cmd () {
    cmd="$(print -rC1 -- ${(ko)commands} | fzf-tmux $FZF_TMUX_OPTS)"
    RBUFFER="${RBUFFER}$cmd "
    zle end-of-line
}
zle -N insert_cmd
bindkey '^Sc' insert_cmd

###############################
# Edit Command Widget
# @hotkey C
###############################
edit_cmd () {
    cmd="$(print -rC1 -- ${(ko)commands} | fzf-tmux $FZF_TMUX_OPTS)"
    nvim `which $cmd`
    RBUFFER="${RBUFFER}nvim `which $cmd`"
    zle end-of-line
}
zle -N edit_cmd
bindkey '^SC' edit_cmd

###############################
# Select DIR Widget
###############################
fzf-get-dir-widget() {
    LBUFFER+=$(dx)
}
zle -N fzf-get-dir-widget
bindkey '^Sd' fzf-get-dir-widget

###############################
# Select File Widget
# @hotkey f
###############################
fzf-get-file-widget() {
    LBUFFER+=$(fx)
}
zle -N fzf-get-file-widget
bindkey '^Sf' fzf-get-file-widget

###############################
# Ctrlp Widget
# @hotkey ^p (no leader)
###############################
_ctrlp() {
    cmd=$(ctrlp)
    LBUFFER+="$cmd"
    zle accept-line
}
zle -N _ctrlp
bindkey '^p' _ctrlp

###############################
# CD Up Widget
# @hotkey ^u (no leader)
###############################
fzf_cd_up() {
    i=0
    dirs=""
    while true; do
        i=$((i+1))
        dir="`pwd | cut -d/ -f -$i`"
        dirs="$dir\n$dirs"
        if [[ "$((i - 1))" == "`pwd | grep -o '/' | wc -l`" ]] then
            break;
        fi
    done

    choice="`echo $dirs | grep . | fzf-down`"

    [[ -n "$choice" ]] && cd $choice

}
bindkey -s '^u' 'fzf_cd_up\n'

###############################
# Echo Path Widget
# @hotkey o
###############################
bindkey -s '^So' '`fasd_echo`\t'

###############################
# Edit in Nvim Widget
# @hotkey p
###############################
bindkey -s '^Sp' 'nvim `fasd_echo`\n'

###############################
# Search Flags Widget
# @hotkey
###############################
fzf-flags-widget() {
    local result=$(flags.py \
        | fzf-tmux $FZF_TMUX_OPTS \
        | awk '{print $2}')
    LBUFFER+=$result
}
zle -N fzf-flags-widget
bindkey '^sF' fzf-flags-widget

## Sandbox
cheatsheet-widget() {
    tmux popup -w 50% -h 50% bat $HOME/Documents/notes.md
}
zle -N cheatsheet-widget
bindkey '^st' cheatsheet-widget

edit-cheatsheet-widget() {
    tmux popup -w 50% -h 50% 'VIM_RAW=1 nvim $HOME/Documents/notes.md'
}
zle -N edit-cheatsheet-widget
bindkey '^sT' edit-cheatsheet-widget
