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


function! s:SortTimeStamps(lhs, rhs)
  return a:lhs[1] > a:rhs[1] ?  1
     \ : a:lhs[1] < a:rhs[1] ? -1
     \ :                        0
endfunction

function! s:Close(nb_to_keep)
  let saved_buffers = filter(range(0, bufnr('$')), 'buflisted(v:val) && ! getbufvar(v:val, "&modified")')
  let times = map(copy(saved_buffers), '[(v:val), getftime(bufname(v:val))]')
  call filter(times, 'v:val[1] > 0')
  call sort(times, function('s:SortTimeStamps'))
  let nb_to_keep = min([a:nb_to_keep, len(times)])
  let buffers_to_strip = map(copy(times[0:(nb_to_keep-1)]), 'v:val[0]')
  exe 'bw '.join(buffers_to_strip, ' ') 
endfunction

" Two ways to use it
" - manually
command! -nargs=1 CloseOldBuffers call s:Close(<args>)
" - or automatically
" and don't forget to set the option in your .vimrc
let g:nb_buffers_to_keep = 5


function! s:ShowMaps()
  let old_reg = getreg("a")          " save the current content of register a
  let old_reg_type = getregtype("a") " save the type of the register as well
try
  redir @a                           " redirect output to register a
  " Get the list of all key mappings silently, satisfy "Press ENTER to continue"
  silent map | call feedkeys("\<CR>")    
  redir END                          " end output redirection
  vnew                               " new buffer in vertical window
  put a                              " put content of register
  " Sort on 4th character column which is the key(s)
  %!sort -k1.4,1.4
finally                              " Execute even if exception is raised
  call setreg("a", old_reg, old_reg_type) " restore register a
endtry
endfunction
com! ShowMaps call s:ShowMaps()      " Enable :ShowMaps to call the function
