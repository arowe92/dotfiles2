let s:qf = []

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
        call GitPatchNext()
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
        call GitPatchNext()
    elseif l:action == 'd'
        call GitPatchNext()
    elseif l:action == 'q'
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
    cclose
endfunction

function! GitPatchNext() abort
    GitGutterLineHighlightsDisable
    GitGutterAll
    sign unplace * group=Patch
    augroup GitPatch
        au!
    augroup END

    let l:idx = RemoveFile()
    if len(s:qf) >= 1
        execute l:idx + 1 . "cfirst"
        call GitPatch()
    endif
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
command! GitPatch call GetFiles() | call GitPatch()
command! GitPatchContinue call GitPatchNextHunk()

function! GetFiles()
    let s:qf = []
    let l:files = split(trim(system('git status --porcelain=v2 -uno | awk "{print \$NF}"')), '\n')
    for file in l:files
        call add(s:qf, {"filename": l:file})
    endfor
    call setqflist(s:qf)
    copen
endfunction

function! RemoveFile()
    let l:idx = 0
    for file in s:qf
        if l:file['filename'] == expand('%')
            break
        endif
        let l:idx = l:idx + 1
    endfor

    if l:idx == len(s:qf)
        return -1
    endif

    call remove(s:qf, l:idx)
    call setqflist(s:qf)
    return l:idx
endfunction


