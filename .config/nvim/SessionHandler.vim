
function FindSessionFile()
    if len(argv()) > 0
        let path = fnamemodify(argv()[0], ':p:h')
    else
        let path = getcwd()
    endif

    let dir = $HOME."/.vim/sessions/"

    let short_path = substitute(path, $HOME."/", "", "g")
    let slug = substitute(short_path, "/", "-", "g")
    let full_path = dir.slug.".vim"

    return full_path
endfunction!

function LoadSession()
    let full_path = FindSessionFile()
    if filereadable(full_path)
        execute "source " . full_path
    endif
endfunction!

function WriteSession()
    let full_path = FindSessionFile()
    echo "Writing Session to ".full_path

    try
        let dir = $HOME."/.vim/sessions/"
        call mkdir(dir, "p")
    endtry

    exe "mksession! " . full_path
endfunction!


command! WriteSession call WriteSession()
command! LoadSession call LoadSession()

if get(g:, 'autoload_session', 1) == 1
    LoadSession
endif
