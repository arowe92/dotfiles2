function! GitPatchNextHunk() abort
    GitGutterNextHunk
endfunction

function! GitPatchPrevHunk() abort
    GitGutterPrevHunk
endfunction

function! GitPatchPrompt() abort
    GitGutterAll
    augroup GitPatch
        au!
    augroup END

    execute "normal zz"

	sign unplace 99 group=Patch
	exe "sign place 99 line=".line('.')." group=Patch name=Patch priority=99"
    redraw!

    if join(GitGutterGetHunks()) == ''
        echo "Done!"
        call GitPatchStop()
        return
    endif
    echo " Action? y/n/a/d/p/e/u/c/?"
    let l:action = nr2char(getchar())

    if l:action == 'y'
        GitGutterStageHunk
        call GitPatchNextHunk()
        call GitPatchPrompt()
    elseif l:action == 'n'
        call GitPatchNextHunk()
        call GitPatchPrompt()
    elseif l:action == 'a'
        silent call system('git add '.expand('%'))
        call GitPatchStop()
    elseif l:action == 'd' || l:action == 'q'
        call GitPatchStop()
    elseif l:action == 'p'
        call GitPatchPrevHunk()
        call GitPatchPrompt()

    elseif l:action == 'u'
        GitGutterUndoHunk
        call GitPatchNextHunk()
        call GitPatchPrompt()

    elseif l:action == 'e'
        sign unplace 99 group=Patch
        let s:linenr = line('.')-2
        augroup GitPatch
            au!
            autocmd BufWritePost *
                        \ execute(':'.s:linenr) |
                        \ GitGutterNextHunk |
                        \ call GitPatchPrompt()
        augroup END
    elseif l:action == '?'
    elseif l:action == '\<esc>'
        call GitPatchStop()
    else
        call GitPatchPrompt()
    endif
endfunction

function! GitPatchStop() abort
    GitGutterLineHighlightsDisable
    GitGutterAll
    sign unplace * group=Patch
    augroup GitPatch
        au!
    augroup END
endfunction

function! GitPatch() abort
    GitGutterAll
	sign define Patch text=>> texthl=Search
    GitGutterLineHighlightsEnable
    :0
    redraw!
    call GitPatchNextHunk()
    call GitPatchPrompt()
endfunction
command! GitPatch call GitPatch()
command! GitPatchContinue call GitPatchNextHunk()
