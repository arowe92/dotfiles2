" ===================
"  Commands
" ===================
" Copy The Path of the file
command! CP :let @" = expand('%')
command! CdFile cd %:p:h
command! CdGit exe 'cd '.finddir('.git', '.;').'/../'

" Run FZF With Defaults
function! Fzf(dict)
    call fzf#run(extend(copy({
                \ 'tmux': '-p80%,80%',
                \ 'options': '--preview="prev {}"'
                \ }), a:dict))
endfunction

function! Include(file, ...) abort
    let l:file = a:file

    if l:file == ""
        return
    endif

    let l:root = trim(system("git rev-parse --show-toplevel"))
    let l:fullpath = trim(system("realpath --relative-to=".l:root." ".l:file))
    let l:include = '#include "'.l:fullpath.'"'
    exe "normal! o" . l:include . "\<Esc>"
endfunction
command! Include call Fzf({'source': 'fd "\.h$"', 'sink': function('Include')}))

function! s:checkout(line, ...) abort
    let parts = split(a:line)
    exe '!git checkout '.parts[0].' -- '.expand('%')
endfunction
function! s:checkout_fzf() abort
    let l:file = fnamemodify(expand("%"), ":~:.")
    call Fzf({
                \ 'source': 'git log --oneline '.l:file, 
                \ 'sink': function('s:checkout'),
                \ 'options': '--preview="git diff {1} '.l:file.' | delta"'
                \ })
                "\ 'options': '--preview="git show {1}:'.l:file.' | bat --color=always -l '.&filetype.'"'
endfunction
command! FuzzyCheckout call s:checkout_fzf()

function! s:gedit(line, ...) abort
    let parts = split(a:line)
    exe 'Gedit '.parts[0].':%'
endfunction
function! s:gedit_fzf() abort
    let l:file = fnamemodify(expand("%"), ":~:.")
    call Fzf({
                \ 'source': 'git log --oneline '.l:file, 
                \ 'sink': function('s:gedit'),
                \ 'options': '--preview="git diff {1} '.l:file.' | delta"'
                \ })
endfunction
command! FuzzyGedit call s:gedit_fzf()

function! s:reset(line, ...) abort
    let parts = split(a:line)
    exe '!git reset '.parts[0].' -- '.expand('%')
endfunction
function! s:reset_fzf() abort
    let l:file = fnamemodify(expand("%"), ":~:.")
    call Fzf({
                \ 'source': 'git log --oneline '.l:file, 
                \ 'sink': function('s:reset'),
                \ 'options': '--preview="git diff {1} '.l:file.' | delta"'
                \ })
endfunction
command! FuzzyReset call s:reset_fzf()
