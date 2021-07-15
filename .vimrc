" Install vim-plug if it doesnt exist
if empty(glob('~/.vim/autoload/plug.vim'))
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin()

" UI
Plug 'skywind3000/vim-quickui'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' } " File Tree
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'kshenoy/vim-signature' "Show Marks in Sidebar
Plug 'neoclide/coc.nvim'
Plug 'puremourning/vimspector'

" Fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Navigation
Plug 'easymotion/vim-easymotion'
Plug 'Yohannfra/Vim-Goto-Header'
Plug 'yegappan/taglist'
Plug 'bogado/file-line'

" Windows
Plug 'caenrique/nvim-maximize-window-toggle'
Plug 'junegunn/goyo.vim'
Plug 'Asheq/close-buffers.vim'

" Text Editing
Plug 'terryma/vim-multiple-cursors'
Plug 'AndrewRadev/sideways.vim'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sensible'
Plug 'brooth/far.vim'
Plug 'tpope/vim-eunuch'
Plug 'meain/vim-printer'
Plug 'SirVer/ultisnips'

" Tmux Integration
Plug 'preservim/vimux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'roxma/vim-tmux-clipboard'

" Misc
Plug 'mbbill/undotree'
Plug 'tpope/vim-repeat'

" ==== Language Support  ====
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'pangloss/vim-javascript',  { 'for': 'javascript' }
Plug 'elixir-editors/vim-elixir'
Plug 'google/vim-maktaba'
Plug 'bazelbuild/vim-bazel'
Plug 'rust-lang/rust.vim'
Plug 'MTDL9/vim-log-highlighting'
Plug 'plasticboy/vim-markdown'

" ==== Appearance====
Plug 'luochen1990/rainbow' | let g:rainbow_active = 1
Plug 'Yggdroot/indentLine'
Plug 'ryanoasis/vim-devicons'
" Plug 'psliwka/vim-smoothie'
" Plug 'joeytwiddle/sexy_scroller.vim'
Plug 'lfv89/vim-interestingwords'

" Status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ojroques/vim-scrollstatus'

" ==== Color schemes ====
Plug 'nanotech/jellybeans.vim'
Plug 'morhetz/gruvbox'
Plug 'junegunn/seoul256.vim'
Plug 'ajh17/Spacegray.vim'
Plug 'roosta/srcery'
Plug 'tomasr/molokai'
Plug 'romainl/Apprentice'
Plug 'dracula/vim'
Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'mkarmona/materialbox'
Plug 'kyoz/purify'
Plug 'cocopon/iceberg.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'sainnhe/sonokai'

" == NEW_PLUGINS == "
Plug 'liuchengxu/vim-which-key'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'

" == Bleeding Edge Plugins == "
if has('nvim-0.5')
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
endif

call plug#end()

"-------------------------
"     Theme Settings
"-------------------------
" Available values: `'default'`, `'atlantis'`, `'andromeda'`, `'shusia'`, `'maia'`, `'espresso'`
let g:sonokai_style = 'atlantis'
let g:sonokai_enable_italic = 0
let g:sonokai_disable_italic_comment = 0

colorscheme sonokai

let g:quickui_color_scheme = 'gruvbox'

"-------------------------
"    General Settings
"-------------------------
set wrap
set number
set hlsearch
set smartcase
set ignorecase
set textwidth=0
set undolevels=1000
set showcmd
set autowrite
set mouse=a
set wildmenu
set wildchar=<Tab>
set foldlevel=99
set cursorline
set hidden
set noshowmode
set iskeyword=@,48-57,_,192-255,=,~,*,! " Removed: :[]<>

" From coc.vim
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Tabs
set shiftwidth=4
set tabstop=4
set expandtab

" Allow Italics
set t_ZH=^[[3m
set t_ZR=^[[23m
set t_Co=16

" ??
set termguicolors
set completeopt-=preview

" Swap file location
set directory^=/tmp/swp
set tags+=~/.vim/tags

"-------------------------
"    Plugin Settings
"-------------------------
" Airline
let g:airline_powerline_fonts = 1
let g:airline_left_sep = "\uE0B4"
let g:airline_right_sep = "\uE0B6"
let g:airline_section_c_only_filename = 1
let g:airline_section_x = '%{Cwd()}'
let g:airline_section_y = '%{ScrollStatus()}'
let g:airline_section_z = airline#section#create(['%l:%c'])
let g:airline_extensions = ["tabline", "hunks", "searchcount"]
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#enabled = 2
let g:airline#extensions#searchcount#enabled = 1

" Scroll Status
let g:scrollstatus_symbol_track = '─'
let g:scrollstatus_symbol_bar = '━'

" Goto Header
let g:goto_header_use_find = 1
let g:goto_header_includes_dirs = ["."]

" YCM
let g:ycm_max_diagnostics_to_display = 9999
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_completion = 0

" NERDTree
let g:NERDTreeHijackNetrw = 1
let g:NERDTreeDirArrowExpandable="+" " Windows Fix
let g:NERDTreeDirArrowCollapsible="-" " Windows Fix
let g:rainbow_conf = {'separately': {'nerdtree': 0}} " Fix

" Misc PLugins
let g:autoload_session = 0
let g:indentLine_char = '▏'
let g:VimuxOrientation = "h"
let g:UltiSnipsExpandTrigger="<M-u>"
let g:smoothie_speed_exponentiation_factor=1.3
let g:gitgutter_map_keys = 0
let g:session_autosave_periodic=3
let g:session_autosave='yes'
let g:session_autoload='no'

" == FZF ==
" Use tmux FZF if tmux exists
if exists('$TMUX')
    let g:fzf_layout = { 'tmux': '-p80%,60%' }
else
    let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
endif

" Use ag if it exists
" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
endif

" Vim Printer
let g:vim_printer_print_below_keybinding = '<leader>gp'
let g:vim_printer_print_above_keybinding = '<leader>gP'
let g:vim_printer_items = {
            \ 'javascript': 'console.log("{$}:", {$})',
            \ 'python': 'print("{$}:", {$})',
            \ 'cpp': 'info(0) << "{$}:" << {$} << std::endl;',
            \ }

" Which Key
let g:which_key_map =  {}
let g:which_key_map.p = { 'name' : '+fuzzy' }
let g:which_key_map.c = { 'name' : '+coc' }
let g:which_key_map.d = { 'name' : '+vimspector' }
let g:which_key_map.e = { 'name' : '+edit' }
let g:which_key_map.g = { 'name' : '+git' }
let g:which_key_map.x = { 'name' : '+extension' }
call which_key#register('<Space>', "g:which_key_map")

"----------------------------
"         Key Mappings
"----------------------------
let mapleader=" "

" ==== Plugin Mappings =====
" NerdTree
noremap <C-\> :NERDTreeToggle<CR>
noremap <leader>\ :NERDTreeToggle<CR>

" Quick UI
noremap <leader><CR> :call quickui#menu#open()<CR>

" FZF Mappings
nnoremap <C-p> :Files<CR>
nnoremap <M-P> :History:<CR>
nnoremap <M-p> :History<CR>
nnoremap <M-b> :Buffers<CR>
nnoremap <M-t> :BTags<CR>
nnoremap <M-f> :execute 'Ag '.input("Search For: ")<CR>

" FZF <leader>p* Commands
nnoremap <leader>pc :Commands<CR>
nnoremap <leader>ph :History<CR>
nnoremap <leader>pr :History:<CR>
nnoremap <leader>pb :Buffers<CR>
nnoremap <leader>pf :Lines<CR>
nnoremap <leader>pa :BTags<CR>
nnoremap <leader>pt :Tags<CR>
nnoremap <leader>pg :Ag<CR>
nnoremap <leader>py :Filetypes<CR>

nnoremap <leader>pi :Include<CR>
nnoremap <leader>pd :FzfCd<CR>
nnoremap <leader>pD :FzfCdIter<CR>
nnoremap <leader>po :FasdFile<CR>
nnoremap <leader>pO :FasdDir<CR>
nnoremap <leader>pC :FasdCWD<CR>

" Go To everywhere Commands
nnoremap gw :execute 'Ag '.expand('<cword>')<CR>
nnoremap gW :execute 'Agf '.expand('<cword>')<CR>
nnoremap ga :execute 'Tags '.expand('<cword>')<CR>

" Git Gutter
nnoremap <leader>g] :GitGutterNextHunk<CR>
nnoremap <leader>g[ :GitGutterPrevHunk<CR>
nnoremap <leader>gh :GitGutterLineHighlightsToggle<CR>
nnoremap <leader>gg :GitGutterToggle<CR>

" EasyMotion Commands
map <leader>f <Plug>(easymotion-bd-f2)
map s <Plug>(easymotion-bd-f)
map <Leader>w <Plug>(easymotion-bd-w)

map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)

" Vimux
noremap <M-`> :VimuxTogglePane<CR>
noremap <M-R> :VimuxPromptCommand<CR>
noremap <M-r> :VimuxRunLastCommand<CR>

" Surround
nnoremap <leader>0 :normal ysiw)<CR>i
nnoremap yss :normal ysiw"<CR>
nnoremap ysS :normal ysiw'<CR>
nnoremap ysa :normal ysiW"<CR>
nnoremap ysA :normal ysiW'<CR>

"VimSpector
nmap <leader>dc <Plug>VimspectorContinue
nmap <leader>ds <Plug>VimspectorLaunch
nmap <leader>dS :VimspectorReset<CR>
nmap <leader>dr <Plug>VimspectorRestart
nmap <leader>dt <Plug>VimspectorStop
nmap <leader>dp <Plug>VimspectorPause
nmap <leader>dd <Plug>VimspectorToggleBreakpoint
nmap <leader>dD <Plug>VimspectorToggleConditionalBreakpoint
nmap <leader>df <Plug>VimspectorAddFunctionBreakpoint
nmap <leader>dC <Plug>VimspectorRunToCursor
nmap <leader>dj <Plug>VimspectorStepOver
nmap <leader>dl <Plug>VimspectorStepInto
nmap <leader>dh <Plug>VimspectorStepOut

" Misc Plugins
execute 'nnoremap <M-g> :Git '
noremap <M-/> :Commentary<CR>
nnoremap <leader>u :UndotreeToggle \| UndotreeFocus<CR>
nnoremap <M-o> :GotoHeaderSwitch<CR>
nnoremap Q :Bdelete menu<CR>
nnoremap <leader>' ' :call quickui#tools#clever_context('k', g:context_menu_k, {})<cr>
nnoremap <C-t> :TlistToggle<CR>

" ==== Vim Mappings ====
" Clear the highlighting of :set hlsearch
nnoremap <silent> <leader>H :nohlsearch<cr>

" Save  File
nnoremap <C-s> :w<CR>
inoremap <C-s> <ESC>:w<CR>
noremap <leader><C-s> :WriteSession<CR>

" File /Buffer Operations
nnoremap <C-c> :echo 'ctrl-c thrice to quit'<CR>
nnoremap <C-c><C-c><C-c> :qall!<CR>
map <C-w> :bd<CR>
map <C-q> :q<CR>

" Terminal Escape
tnoremap <C-e> <C-\><C-n>

" Easy Indenting
nnoremap <M-H> <<
nnoremap <M-L> >>
inoremap <M-H> <Esc><<<CR>gi
inoremap <M-L> <Esc>>><CR>gi
vnoremap <M-H> <gv
vnoremap <M-L> >gv

" Easy Line Moving
nnoremap <A-K> :m .-2<CR>
nnoremap <A-J> :m .+1<CR>
inoremap <A-J> <Esc>:m .+1<CR>gi
inoremap <A-K> <Esc>:m .-2<CR>gi
vnoremap <A-J> :m '>+1<CR>gv
vnoremap <A-K> :m '<-2<CR>gv

" Move Arguments left or right
noremap <M->> :SidewaysLeft<CR>
noremap <M-<> :SidewaysRight<CR>

" Jumps!
" noremap <A-j> 10j
" noremap <A-k> 10k
" noremap <A-l> 10l
" noremap <A-h> 10h

" Split Lines
nnoremap S :execute 's/\('.nr2char(getchar()).'\)\ */\1\r/g' \| :nohl<CR>
nnoremap S/ :execute 's/\/\ */\/\r/g' \| :nohl<CR>
nnoremap SS :execute 's/\('.input("String to Split on").'\)\ */\1\r/g' \| :nohl<CR>

" task Insert / Command Mode Mappings
" Paste
inoremap <C-v> <C-r>"
cnoremap <C-v> <C-r>"
inoremap <C-e> <Esc>A

" ==== Windows and Panes ====
" Remap window prefix
nnoremap <C-n> <C-W>

" Rotate Panes
nnoremap <C-n>J <C-w>J
nnoremap <C-n>H <C-w>H
nnoremap <C-n>r <C-w>r
nnoremap <C-n><C-r> <C-w><C-r>

" Pane Creation
noremap <C-n><C-j> <C-W>s<C-w><C-k>
noremap <C-n><C-k> <C-w>s<C-w><C-k>
noremap <C-n><C-l> <C-w>v<C-w><C-l>
noremap <C-n><C-h> <C-w>v<C-w><C-h>

" Switch to Layout / Maximize Pane
nnoremap <leader>L1 <C-w>\| <C-w>_
nnoremap <leader>L2 <C-W>=
nnoremap <leader>L3 :exe 'vert resize ' . ((&columns)*2/3)<CR>
nnoremap <leader>L` :Goyo<CR>
nnoremap <leader>m :ToggleOnly<CR>
nnoremap <M-Enter> :ToggleOnly<CR>

" Resizing Panes
nnoremap <leader>= :vertical resize +10<CR>
nnoremap <leader>- :vertical resize -10<CR>
nnoremap <leader>+ :resize +10<CR>
nnoremap <leader>_ :resize -10<CR>

"" Buffers
noremap <C-n>l :bn<CR>
noremap <C-n>h :bp<CR>
noremap <M-]> :bn<CR>
noremap <M-[> :bp<CR>
nnoremap <S-Tab> <C-^>

"" Tabs
nnoremap <leader>t :tab split<CR>
noremap <M-}> :tabn<CR>
noremap <M-{> :tabp<CR>
noremap <C-n>k :tabn<CR>
noremap <C-n>j :tabp<CR>

" Vimrc
nnoremap <leader>ev :tab split ~/.vimrc<cr>
nnoremap <leader>ez :tab split ~/.zshrc<cr>
nnoremap <leader>et :tab split ~/.tmux.conf<cr>

" Folding
nnoremap zS :setlocal foldmethod=syntax<CR>
nnoremap zu :setlocal foldmethod=manual<CR>

" Misc
noremap <leader>R :redraw!<CR>
noremap <leader>r @:<CR> "Run Last Command"

" Easy Macros / Replacing
vmap gs "my/<C-R>m<CR>
vmap <M-Q> gsNqq
nmap <M-Q> viw<M-Q>
nnoremap <M-q> nzz@q

" Command Mods
vmap y ygv<Esc>
map <silent> n n
map <silent> N N
noremap <M-A> 1GVG

" ===================
" Custom Commands
" ===================
" Copy The Path of the file
command! CP :let @" = expand('%')

" Find one instance of query in file
command! -bang -nargs=* Agf call fzf#vim#ag(<q-args>, '-m1', fzf#vim#with_preview(), <bang>0)

" Clang-format file
command! Clang silent execute '%!clang-format %'
command! JsonFormat silent execute '%!python -m json.tool'

" Fasd Commands
command! FasdDir call fzf#run({'source': 'fasd -ld', 'sink': 'NERDTree', 'tmux': '-p'})
command! FasdFile call fzf#run({'source': 'fasd -lf', 'sink': 'e', 'tmux': '-p'})
command! FasdCWD execute("call fzf#run({'source': 'fasd -ld', 'sink': 'cd', 'tmux': '-p'}) | NERDTreeToggle")

command! Branches call fzf#run({'source': 'git branch', 'sink': 'Git checkout', 'tmux': '-p'})

" ========= Auto Commands ==============
" Remove spaceds
augroup Cmds
    au!
    autocmd BufWritePre * :%s/\s\+$//e
    autocmd BufWritePre *.h,*.cc %s/\s\+$//e
    autocmd BufNewFile,BufRead *.h,*.cc   set syntax=cpp.doxygen
    autocmd FileType vim inoremap " "
    autocmd WinEnter * if &buftype == 'quickfix' | nnoremap <buffer><nowait><silent> <Enter> <Enter>:wincmd j<CR> | endif
augroup END

" ========================================
" =  Quick UI menu
" ========================================
let g:quickui_border_style = 2
let g:quickui_color_scheme = 'papercol_dark'

call quickui#menu#reset()
call quickui#menu#install("&Fuzzy", [
            \ ['&Ag', ':Ag'],
            \ ['&History', ':History'],
            \ ['&Commands', ':Commands'],
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

call quickui#menu#install("&Tools", [
            \ ['&Find...', ':Farf'],
            \ ['Find \& &Replace...', ':Farr'],
            \ ['&Tag List', ':TlistToggle'],
            \ ])

call quickui#menu#install("&Git", [
            \ ['&Status', ':Git'],
            \ ['&Add', ':Git add --patch'],
            \ ['&Blame', ':Git blame'],
            \ ['&Undo Hunk', ':GitGutterUndoHunk'],
            \ ['&Diff', ':Gdiffsplit'],
            \ ['&Log', ':Git log'],
            \ ['&Graph', ':Git log --oneline --decorate --graph'],
            \ ])


" ======= Functions ========
function! Cwd() abort
    let l:path = getcwd()
    let l:pattern = getenv("HOME")
    let l:new_path = substitute(l:path, l:pattern, "~", "g")
    return l:new_path
endfunction

" Easy way to Include c++ files
function! Include() abort
    let l:file = trim(system("fd '\.h$' | fzf-tmux -p"))

    if l:file == ""
        return
    endif

    let l:root = trim(system("git rev-parse --show-toplevel"))
    let l:fullpath = trim(system("realpath --relative-to=".l:root." ".l:file))
    let l:include = '#include "'.l:fullpath.'"'
    exe "normal! o" . l:include . "\<Esc>"
endfunction
command! Include silent call Include()

" Nerd Tree into Folder
function! FzfCd() abort
    let l:file = trim(system("fd -t d | fzf-tmux -p --reverse"))
    if l:file == ""
        return
    endif

    let l:root = trim(system("git rev-parse --show-toplevel"))
    let l:fullpath = trim(system("realpath ".l:file))
    exe "NERDTree " . l:fullpath
endfunction
command! FzfCd call FzfCd()

function! FzfCdIter() abort
    let l:path = './'
    while 1
        let l:cmd = "fd --prune --base-directory=".l:path." -t d ."
        let l:choices = trim(system(cmd))
        if l:choices == ''
            break
        endif
        let l:result = trim(system(l:cmd." | fzf-tmux -p --reverse"))
        if l:result == ''
            break
        endif
        let l:path = l:path.l:result.'/'
    endwhile

    if l:path == './'
        return
    endif
    execute 'NERDTree '.l:path
endfunction!

command! FzfCdIter call FzfCdIter()

" TreeSitter
if has('nvim-0.5')
lua <<EOF
require'nvim-treesitter.configs'.setup {
    ensure_installed = { "cpp", "jsonc", "javascript", "python" }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    ignore_install = { }, -- List of parsers to ignore installing
    highlight = {
        enable = true,              -- false will disable the whole extension
        disable = { },  -- list of language that will be disabled
    },
    indent = {
        enable = false
    },
    incremental_selection = {
        enable = true
    }
}
EOF

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
endif
