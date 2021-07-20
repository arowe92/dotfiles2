function! GitPatchStop() abort
    unmap <buffer> y<CR>
    unmap <buffer> a<CR>
    unmap <buffer> d<CR>
    unmap <buffer> n<CR>
    unmap <buffer> p<CR>
    unmap <buffer> u<CR>
    unmap <buffer> <ESC>
endfunction

function! GitPatchNextHunk() abort
    let l:val = trim(execute("GitGutterNextHunk"))
    if l:val == 'No more hunks'
        echo "Done"
        call GitPatchStop()
    endif
endfunction

function! GitPatch() abort
    :0 | call GitPatchNextHunk()
    nnoremap <buffer> y<CR> :GitGutterStageHunk \| call GitPatchNextHunk()<CR>
    nnoremap <buffer> a<CR> :Git add % \| call GitPatchStop()<CR>
    nnoremap <buffer> d<CR> :call GitPatchStop()<CR>
    nnoremap <buffer> n<CR> :call GitPatchNextHunk()<CR>
    nnoremap <buffer> p<CR> :GitGutterPrevHunk<CR>
    nnoremap <buffer> u<CR> :GitGutterUndoHunk \| call GitPatchNextHunk()<CR>
    nnoremap <buffer> <ESC> :call GitPatchStop()<CR>
endfunction
command! GitPatch call GitPatch()
