
" ========================================
"  Quick UI menu
" ========================================
let g:quickui_border_style = 2
let g:quickui_color_scheme = 'papercol_dark'

if exists('g:plugin_quickui')
noremap <leader><CR> :call quickui#menu#open()<CR>
nnoremap <leader>' ' :call quickui#tools#clever_context('k', g:context_menu_k, {})<cr>

call quickui#menu#reset()

call quickui#menu#install("&Tools", [
            \ ['&Find...', ':Farf'],
            \ ['Find \& &Replace...', ':Farr'],
            \ ['&Tag List', ':TlistToggle'],
            \ ])

call quickui#menu#install("&Git", [
            \ ['&Status', ':Git'],
            \ ['&Patch', ':GitPatch'],
            \ ['&Add', ':Git add --patch'],
            \ ['&Blame', ':Git blame'],
            \ ['&Undo Hunk', ':GitGutterUndoHunk'],
            \ ['&Diff', ':Gdiffsplit'],
            \ ['&Log', ':Git log'],
            \ ['&Graph', ':Git log --oneline --decorate --graph'],
            \ ])

call quickui#menu#install("&Scripts", [
            \ ['&New Pythia Test', ':NewPythiaTest'],
            \ ])

call quickui#menu#install("&Fuzzy", [
            \ ['&Grep', ':Telescope live_grep'],
            \ ['&History', ':Telescope oldfiles'],
            \ ['&Commands', ':Telescope commands'],
            \ ['&GFile', ':Giles'],
            \ ['G&it Status', ':GFiles?'],
            \ ['C&olors',':Colors'],
            \ ['All Buffer &Lines', ':Lines'],
            \ ['C&urrent Buffer Lines', ':BLines'],
            \ ['&Tags', ':Tags'],
            \ ['&Buffer Tags', ':BTags'],
            \ ['&Marks', ':Marks'],
            \ ['&Windows', ':Windows'],
            \ ['Co&mmand History', ':History:'],
            \ ['&Edit History', ':History/'],
            \ ['&Snippets', ':Snippets'],
            \ ['Commi&ts', ':Commits'],
            \ ['B&uffer Commits', ':BCommits'],
            \ ['Ma&ps', ':Maps'],
            \ ['Helpta&gs', ':Helptags'],
            \ ['Filet&ypes', ':Filetypes'],
            \ ['Files', ':Files'],
            \ ['Buffers', ':Buffers']
            \ ])

" Folding
call quickui#menu#install("F&olding", [
            \ ["&Syntax\t(foldmethod)", ':setlocal foldmethod=syntax'],
            \ ["&Manual\t(foldmethod)", ':setlocal foldmethod=manual'],
            \ ["&Indent\t(foldmethod)", ':setlocal foldmethod=indent'],
            \ ["&Close All", ':setlocal foldlevel=0'],
            \ ["&Open All", ':setlocal foldlevel=99']
            \ ])

endif
