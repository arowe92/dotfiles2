" ==== Grep functions ==== {{{2
" Grep
command! -nargs=1 QFindInWorkspace let g:_last_grep = <q-args> | silent grep <q-args> | copen
command! QFindSearchInWorkspace call FindSearchInWorkspace()
command! QFindSearchInFile call FindSearchInFile()
command! -nargs=1 QFindInFile let g:_last_grep = <q-args> | silent grep <q-args> % | copen
command! -nargs=1 QReplace execute "cdo s/".g:_last_grep."/".<q-args>."/g"
command! -nargs=1 QReplaceAndWrite execute "cdo s/".g:_last_grep."/".<q-args>."/g | w"

nnoremap <leader>qf <cmd>execute("QFindInFile ".input("Search Current File: "))<CR>
nnoremap <leader>qF <cmd>execute("QFindInWorkspace ".input("Search Global: "))<CR>
nnoremap <leader>qr <cmd>execute("QReplace ".input("Replace '".g:_last_grep."' in ".len(getqflist())." places with: "))<CR>
nnoremap <leader>qR <cmd>execute("QReplaceAndWrite ".input("Replace and WRITE '".g:_last_grep."' in ".len(getqflist())." places with: "))<CR>

nnoremap <leader>qs <cmd>execute("QFindSearchInFile")<CR>
nnoremap <leader>qS <cmd>execute("QFindSearchInWorkspace")<CR>

nnoremap <leader>qa <cmd>execute("QFindInFile ".g:_last_grep)<CR>
nnoremap <leader>qA <cmd>execute("QFindInWorkspace ".g:_last_grep)<CR>

nnoremap <leader>S :%s///g<Lef><Left><Left>
nnoremap <leader>f /
nnoremap <leader>F ?

function! FindSearchInWorkspace()
    let l:search = @/
    let l:search = substitute(l:search, "<", "", "g")
    let l:search = substitute(l:search, "\\", "", "g")
    let l:search = substitute(l:search, ">", "", "g")
    execute "QFindInWorkspace ".l:search
endfunction

function! FindSearchInFile()
    let l:search = @/
    let l:search = substitute(l:search, "<", "", "g")
    let l:search = substitute(l:search, "\\", "", "g")
    let l:search = substitute(l:search, ">", "", "g")
    execute "QFindInFile ".l:search
endfunction

" QuickFix Utils {{{ 3
" When using `dd` in the quickfix list, remove the item from the quickfix list.
function! RemoveQFItem()
  let curqfidx = line('.') - 1
  let qfall = getqflist()
  call remove(qfall, curqfidx)
  call setqflist(qfall, 'r')
  execute curqfidx + 1 . "cfirst"
  :copen
endfunction
:command! RemoveQFItem :call RemoveQFItem()
" Use map <buffer> to only map dd in the quickfix window. Requires +localmap
autocmd FileType qf map <buffer> dd <cmd>RemoveQFItem<cr>

function! GrepQuickFix(pat)
  let all = getqflist()
  for d in all
    if bufname(d['bufnr']) !~ a:pat && d['text'] !~ a:pat
        call remove(all, index(all,d))
    endif
  endfor
  call setqflist(all)
endfunction

function! GrepQuickFixRemove(pat)
  let all = getqflist()
  for d in all
    if bufname(d['bufnr']) =~ a:pat || d['text'] =~ a:pat
        call remove(all, index(all,d))
    endif
  endfor
  call setqflist(all)
endfunction
command! -nargs=* GrepQF call GrepQuickFix(<q-args>)
command! -nargs=* GrepQFRemove call GrepQuickFixRemove(<q-args>)
nnoremap <silent> <leader>q/ <cmd>exe "GrepQF ".input("Select Items /")<CR>
nnoremap <silent> <leader>q? <cmd>exe "GrepQFRemove ".input("Remove Items /")<CR>

