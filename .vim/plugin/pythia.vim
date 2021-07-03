
function! PythiaBazel(action) abort
    let l:cmd = 'cat $HOME/.vim/plugin/pythia_targets'
    call fzf#run({'source': l:cmd, 'sink': ':Bazel '.a:action, 'tmux': '-p'})
endfunction

call system('upfind WORKSPACE')
if v:shell_error == 0
call quickui#menu#install("&Bazel", [
            \ ['&Build...', 'call PythiaBazel("build")'],
            \ ['&Test...', 'call PythiaBazel("test")'],
            \ ['Build &All', ':Bazel build //pythia/src:pythia'],
            \ ['Test A&ll', ':Bazel test //pythia/src:fast'],
            \ ['Test &Current File', 'execute "Bazel test //pythia/src:unit_tests/".expand("%:t:r")'],
            \ ])
endif

" Add Path for easy jumping
set path+=/home/arowe/repos/sims
set path+=/home/arowe/repos/sims/pythia/src
set path+=/home/arowe/.local/include
