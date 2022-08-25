#!/usr/bin/env zsh

_fzf_show () {
    if [[ -d "$1" ]]; then
        echo tree $1
    else
        if [[ -f "$1" ]]; then
            echo bat --color=always $1
        else
            echo help $1
        fi
    fi;
}

_fzf_edit () {
    if [[ -d "$1" ]]; then
        echo cd $1
    else
        if [[ -f "$1" ]]; then
            echo nvim $1
        else
            echo nvim $(which $1)
        fi
    fi;
}

ctrlp () {
    cmd="fzf"
    opts=""

    if [[ "$1" == "tmux" ]]; then
        cmd="fzf-tmux";
        opts="$FZF_TMUX_OPTS"
    fi;

    while true; do
        pwd=$PWD

        IFS=: read -r selected < <(

            $cmd $opts --ansi \
            --color "hl:-1:underline,hl+:-1:underline:reverse" \
            --bind "ctrl-d:change-prompt($PWD Dirs> )+enable-search+reload(fd -H -t d {q})" \
            --bind "alt-d:change-prompt($PWD Dirs> )+enable-search+reload(fd -d 1 -H -t d {q})" \
            --bind "ctrl-f:change-prompt($PWD Files> )+enable-search+reload(fd -H -t f {q})" \
            --bind "alt-f:change-prompt($PWD Files> )+enable-search+reload(fd -d 1 -H -t f {q})" \
            --bind "ctrl-c:change-prompt($PWD Commands> )+enable-search+reload(print -rC1 -- ${(ko)commands})" \
            --bind "alt-t:change-prompt($PWD Recent> )+enable-search+reload(fasd -al | grep $PWD)" \
            --bind "ctrl-t:change-prompt($PWD Recent> )+enable-search+reload(fasd -al)" \
            --bind "ctrl-w:abort" \
            --bind "ctrl-b:change-prompt($PWD Files+Dirs> )+reload(fd -H {q})" \
            --bind "alt-b:change-prompt($PWD Files+Dirs> )+reload(fd -d 1 -H {q})" \
            --bind "enter:accept+execute(echo _fzf_edit {1})" \
            --bind "ctrl-s:accept+execute(echo _fzf_show {1})" \
            --bind "ctrl-r:accept+execute(echo echo {1})" \
            --bind "ctrl-u:accept+execute(echo CTRLP_UP)" \
            --bind "ctrl-y:accept+execute(echo CTRLP_BACK)" \
            --bind "ctrl-p:accept+execute(echo CTRLP_CD {})" \
            --bind "ctrl-x:accept+execute(echo CTRLP_TMUX)" \
            --bind "ctrl-e:accept+execute(echo echo echo {})" \
            --prompt "$PWD Files+Dirs> " \
            --delimiter : \
            --header '[F]iles | [D]irs | [B]oth | [C]ommands | Recen[T] - [E]dit | [S]how | [R]un - [W] Close | [U]p | [Y] Back' \
            --preview 'prev {1}' \
            --preview-window 'right,60%,border-bottom,+{2}+3/3,~3'
        )
        case "$selected" in
            "")
                break
                ;;
            CTRLP_UP)
                cd ..
                ;;
            CTRLP_BACK)
                cd -
                ;;
            CTRLP_CD*)
                cd "$(echo $selected | sed -e 's{.*CTRLP_CD {{g')"
                ;;
            CTRLP_TMUX)
                cmd="fzf-tmux";
                opts="$FZF_TMUX_OPTS"
            ;;
            *)
                eval "${selected}"
                break
                ;;
        esac
    done;
}
