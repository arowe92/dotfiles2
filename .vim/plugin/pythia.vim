
function! PythiaBazel(action) abort
    let l:query = 'attr(visibility, "//visibility:public", //pythia/src:*)'
    let l:cmd = 'bazel query "'.l:query.'"'
    call fzf#run({'source': l:cmd, 'sink': ':Bazel '.a:action, 'tmux': '-p'})
endfunction

function! PythiaTest() abort
    let l:query = 'attr(visibility, "//visibility:public", //pythia/src:*)'
    let l:cmd = 'bazel query "'.l:query.'"'
    call fzf#run({'source': l:cmd, 'sink': ':Bazel test', 'tmux': '-p'})
endfunction

function! PythiaBuild() abort
    let l:query = 'attr(visibility, "//visibility:public", //pythia/src:*)'
    let l:cmd = 'bazel query "'.l:query.'"'
    call fzf#run({'source': l:cmd, 'sink': ':Bazel build', 'tmux': '-p'})
endfunction

function! FasdDir() abort
    call fzf#run({'source': 'fasd -ld', 'sink': 'e', 'tmux': '-p'})
endfunction

function! FasdFile() abort
    call fzf#run({'source': 'fasd -lf', 'sink': 'e', 'tmux': '-p'})
endfunction

function! FasdCWD() abort
    call fzf#run({'source': 'fasd -ld', 'sink': 'cd', 'tmux': '-p'})
    NERDTreeToggle
endfunction

command! FasdDir call FasdDir()<CR>
command! FasdFile call FasdFile()<CR>
command! FasdCWD call FasdCWD()<CR>

