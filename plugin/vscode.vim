if !exists('g:vscode')
finish
endif

function! VSMap(...) abort
        execute "nmap ".a:1." <cmd>call VSCodeNotify(".a:2.")<CR>"
endfunction
command! -nargs=+ VSMap call VSMap(<f-args>)

"----------------------------
"         Key Mappings
"----------------------------
let mapleader=" "

VSMap <leader>\\ 'workbench.action.toggleSidebarVisibility'

VSMap <leader>c[ 'editor.action.marker.next'
VSMap <leader>c] 'editor.action.marker.next'
VSMap <leader>cq 'editor.action.quickFix'

VSMap gh 'editor.action.showHover'
VSMap gk 'editor.action.revealDefinition'
VSMap gK 'editor.action.revealDefinitionAside'
VSMap gH 'editor.action.peekDefinition'
VSMap gH 'editor.action.peekDefinition'

VSMap <c-x>k 'workbench.action.quickOpenPreviousRecentlyUsedEditorInGroup'
VSMap <c-x>j 'workbench.action.quickOpenLeastRecentlyUsedEditorInGroup'

" Move Arguments left or right
nmap <leader>. :SidewaysRight<CR>
nmap <leader>, :SidewaysLeft<CR>

"" Tabs
nmap <c-x>h :tabp<CR>
nmap <c-x>l :tabn<CR>
nmap <leader>] :tabn<CR>
nmap <leader>[ :tabp<CR>

