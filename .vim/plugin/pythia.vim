
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

