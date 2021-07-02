"
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

" Fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Navigation
Plug 'easymotion/vim-easymotion'
Plug 'dkprice/vim-easygrep'
Plug 'Yohannfra/Vim-Goto-Header'
Plug 'yegappan/taglist'
Plug 'bogado/file-line'

" Windows
Plug 'caenrique/nvim-maximize-window-toggle'
Plug 'junegunn/goyo.vim'
Plug 'Asheq/close-buffers.vim'

" Text Editing
Plug 'ycm-core/YouCompleteMe'
Plug 'terryma/vim-multiple-cursors'
Plug 'AndrewRadev/sideways.vim'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'brooth/far.vim'
Plug 'tpope/vim-eunuch'

" Tmux Integration
Plug 'preservim/vimux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'roxma/vim-tmux-clipboard'

" Misc
Plug 'mbbill/undotree'

" ==== Language Support  ====
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'vim-syntastic/syntastic'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'pangloss/vim-javascript',  { 'for': 'javascript' }
Plug 'elixir-editors/vim-elixir'
Plug 'google/vim-maktaba'
Plug 'bazelbuild/vim-bazel'
Plug 'rust-lang/rust.vim'

" ==== Appearance====
Plug 'luochen1990/rainbow'
Plug 'Yggdroot/indentLine'
Plug 'ryanoasis/vim-devicons'
" Plug 'psliwka/vim-smoothie'
Plug 'joeytwiddle/sexy_scroller.vim'
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
call plug#end()

"-------------------------
"     Theme Settings
"-------------------------
" Available values: `'default'`, `'atlantis'`, `'andromeda'`, `'shusia'`, `'maia'`, `'espresso'`
let g:sonokai_style = 'atlantis'
let g:sonokai_enable_italic = 1
let g:sonokai_disable_italic_comment = 0

colorscheme sonokai

" let g:airline_theme=theme
let g:quickui_color_scheme = 'gruvbox'

" Invisible Characters
set list
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:·
" :set colorcolumn=100
set cursorline

" Syntax and file type detection
syntax on
filetype plugin indent on

"-------------------------
"    General Settings
"-------------------------
set autoindent
set wrap
set number
set backspace=indent,eol,start
set hlsearch
set incsearch
set ignorecase
set smartcase
set textwidth=0
set undolevels=1000
set showcmd
set showmatch
set autowrite
set mouse=a
set nopaste
set wildmenu
set wildchar=<Tab>
set shiftwidth=4
set tabstop=4
set expandtab
set encoding=UTF-8
set ttimeoutlen=500
set ttimeoutlen=5
set foldlevel=99

" Allow Italics
set t_ZH=^[[3m
set t_ZR=^[[23m

" ??
set termguicolors

" Swap file location
set directory^=/tmp/

" Add Path for easy jumping
set path+=/home/arowe/repos/sims
set path+=/home/arowe/repos/sims/pythia/src
set path+=/home/arowe/.local/include
set tags+=~/.vim/tags

set completeopt-=preview

" LEADER KEY MAPPING
" use space as leader
let mapleader=" "

" ==== Plugin Settings ====
" Ignore files in ctrlp search
let g:ctrlp_cmd = 'CtrlPCurWD'
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|bazel*'
let g:rainbow_active = 1

let g:airline#extensions#tabline#enabled = 2
let g:airline#extensions#fzf#enabled = 1
let g:airline#extensions#searchcount#enabled = 1
let g:airline_powerline_fonts = 1
let g:scrollstatus_symbol_track = '┈'
let g:scrollstatus_symbol_bar = '━'
let g:airline_section_z = airline#section#create(['%l:%c'])
let g:airline_section_y = '%{ScrollStatus()}'
let g:airline_section_x = '%{Cwd()}'
let g:airline_extensions = ["tabline", "hunks", "searchcount"]


let g:goto_header_use_find = 1
let g:goto_header_includes_dirs = ["."]

let g:autoload_session = 0
let g:indentLine_char = '▏'

let g:ycm_max_diagnostics_to_display = 9999
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_completion = 0

" Windows fix
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="-"

" Nerdtree rainbow fix
let g:rainbow_conf = {'separately': {'nerdtree': 0}}
let g:NERDTreeHijackNetrw = 1

" Use Global FZF if tmux exists
if exists('$TMUX')
    let g:fzf_layout = { 'tmux': '-p80%,60%' }
else
    let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
endif


"----------------------------
"         Key Mappings
"----------------------------

" ========= Plugins ========
noremap <C-\> :NERDTreeToggle<CR>
noremap <leader>\ :NERDTreeToggle<CR>

" Quick UI
noremap <leader><CR> :call quickui#menu#open()<CR><CR>

" FZF Mappings
nnoremap <C-p> :Files<CR>
nnoremap <C-b> :Buffers<CR>
nnoremap <M-o> :GotoHeaderSwitch<CR>
nnoremap <M-P> :Commands<CR>

nnoremap <leader>pc :Commands<CR>
nnoremap <leader>ph :History<CR>
nnoremap <leader>pa :BTags<CR>
nnoremap <leader>pt :Tags<CR>
nnoremap <leader>pg :Ag<CR>

" bind K to grep word under cursor
nnoremap gw :execute 'Ag '.expand('<cword>')<CR>
nnoremap gW :execute 'Agf '.expand('<cword>')<CR>
nnoremap ga :execute 'Tags '.expand('<cword>')<CR>
nnoremap <M-T> :BTags<CR>

" Git Gutter
nnoremap <leader>g] :GitGutterNextHunk<CR>
nnoremap <leader>g[ :GitGutterPrevHunk<CR>
nnoremap <leader>gh :GitGutterLineHighlightsToggle<CR>
nnoremap <leader>gg :GitGutterToggle<CR>

" YCM "
nnoremap gl :YcmCompleter GoToDefinition<CR>
nnoremap gk :YcmCompleter GoToDeclaration<CR>
nnoremap gj <C-]>

" Git Command
nnoremap <M-g> :Git 

" EasyMotion Commands
" <Leader>f{char} to move to {char}
vmap  <leader>f <Plug>(easymotion-bd-f)
nmap <leader>f <Plug>(easymotion-overwin-f)
" s{char}{char} to move to {char}{char}
vmap s <Plug>(easymotion-bd-f2)
nmap s <Plug>(easymotion-overwin-f2)
" Move to line
vmap <leader>l <Plug>(easymotion-bd-jk)
nmap <leader>l <Plug>(easymotion-overwin-line)
" Move to word
vmap  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

" Comment
noremap <M-/> :Commentary<CR>

" Undo Tree
nnoremap <leader>u :UndotreeToggle \| UndotreeFocus<CR>

" Vimux
let g:VimuxOrientation = "h"
noremap <M-`> :VimuxTogglePane<CR>
noremap <M-R> :VimuxPromptCommand<CR>
noremap <M-r> :VimuxRunLastCommand<CR>

" clear the highlighting of :set hlsearch
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
nnoremap Q :Bdelete menu<CR>

" Terminal Escape
tnoremap <C-e> <C-\><C-n>

" Easy Line Moving / Indenting
nnoremap <M-H> <<
nnoremap <M-L> >>
inoremap <M-H> <Esc><<<CR>gi
inoremap <M-L> <Esc>>><CR>gi
vnoremap <M-H> <gv
vnoremap <M-L> >gv

nnoremap <A-K> :m .-2<CR>
nnoremap <A-J> :m .+1<CR>
inoremap <A-J> <Esc>:m .+1<CR>gi
inoremap <A-K> <Esc>:m .-2<CR>gi
vnoremap <A-J> :m '>+1<CR>gv
vnoremap <A-K> :m '<-2<CR>gv

noremap <A-j> 10j
noremap <A-k> 10k


" Move Arguments left or right
noremap <M-,> :SidewaysLeft<CR>
noremap <M-.> :SidewaysRight<CR>

noremap <M-j> 10j
noremap <M-k> 10k

" Wrap in function
nnoremap <leader>0 :normal ysiw)<CR>i
nnoremap yss :normal ysiw"<CR>
nnoremap ysS :normal ysiw'<CR>
nnoremap ysa :normal ysiW"<CR>
nnoremap ysA :normal ysiW'<CR>

" Insert / Command Mode Mappings
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

" Switch to Layout  Maximize Pane
nnoremap <leader>L1 <C-w>\| <C-w>_
nnoremap <leader>L2 <C-W>=
nnoremap <leader>L3 :exe 'vert resize ' . ((&columns)*2/3)<CR>
nnoremap <leader>L` :Goyo<CR>
nnoremap <C-N><C-M> :ToggleOnly<CR>
nnoremap <leader>m :ToggleOnly<CR>


" Splitting / Sizing Panes
:nnoremap <leader>= :vertical resize +10<CR>
:nnoremap <leader>- :vertical resize -10<CR>

:nnoremap <leader>+ :resize +10<CR>
:nnoremap <leader>_ :resize -10<CR>


"" Buffers
noremap <leader>] :bn<CR>
noremap <leader>[ :bp<CR>
noremap <M-]> :bn<CR>
noremap <M-[> :bp<CR>
nnoremap <S-Tab> <C-^>

"" Tabs
nnoremap <leader>t :tab split<CR>
noremap <M-}> :tabn<CR>
noremap <M-{> :tabp<CR>

noremap <leader>} :tab split<CR>
noremap <leader>{ :tab new \| tabm -1<CR>

" VimRc
:nnoremap <leader>ev :tab split ~/.vimrc<cr>
:nnoremap <leader>ez :tab split ~/.zshrc<cr>
:nnoremap <leader>et :tab split ~/.tmux.conf<cr>

" Folding
:nnoremap zF :setlocal foldcolumn=1<CR>
:nnoremap zS :setlocal foldmethod=syntax<CR>
:nnoremap zu :setlocal foldmethod=manual<CR>

" Misc
noremap <leader>R :redraw!<CR>
noremap <leader>r @:<CR> "Run Last Command"

" ===================
" Custom Commands
" ===================
command! TD Todoist

" Copy The Path of the file
command! CP :let @" = expand('%')

" Custom Session Handler
source ~/.config/nvim/SessionHandler.vim

" ========= Auto Commands ==============
" Remove spaceds
augroup remove_spaces
    au!
    autocmd BufWritePre *.h,*.cc %s/\s\+$//e
    autocmd BufNewFile,BufRead *.h,*.cc   set syntax=cpp.doxygen
augroup END

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
endif

" ========================================
" =  Quick UI menu
" ========================================
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

           " \ ['Locate', ':Locate'],
           "  \ ['&Rg', ':Rg'],

call system('upfind WORKSPACE')
if v:shell_error == 0
call quickui#menu#install("Bazel", [
            \ ['&Build', ':Bazel build //pythia/src:pythia'],
            \ ['Test &Current File', 'execute "Bazel test //pythia/src:unit_tests/".expand("%:t:r")'],
            \ ['&Test', ':Bazel test //pythia/src:fast'],
            \ ])
endif

call quickui#menu#install("&Vimux", [
            \ ['&Open Runner', ':VimuxOpenRunner'],
            \ ['Run &Prompt <M-R>', ':VimuxPromptCommand'],
            \ ['Run &Last <M-r>', ':VimuxRunLastCommand'],
            \ ])

call quickui#menu#install("Tools", [
            \ ['&Find', ':Farr'],
            \ ['Find \& &Replace', ':Farf'],
            \ ['&Tag List', ':TlistToggle'],
            \ ['&Git Gutter', ':GitGutterToggle'],
            \ ['Git &Diff', ':Gdiffsplit'],
            \ ])

let g:context_menu_k = [
            \ ["&Find In Buffers", 'exec "BLines ".expand("<cword>")']
            \ ]

" Open Context Menu
nnoremap <leader>' ' :call quickui#tools#clever_context('k', g:context_menu_k, {})<cr>

function! Cwd() abort
    let l:path = getcwd()
    let l:pattern = getenv("HOME")
    let l:new_path = substitute(l:path, l:pattern, "~", "g")
    return l:new_path
endfunction

" Find one instance of query in file
command! -bang -nargs=* Agf call fzf#vim#ag(<q-args>, '-m1', fzf#vim#with_preview(), <bang>0)

command! Clang silent execute '!clang-format -i %' | e

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

nnoremap <leader>i :Include<CR>
nnoremap <leader>pi :Include<CR>

" Nerd Tree into Folder
function! NERDFolder() abort
    let l:file = trim(system("fd -t d | fzf-tmux -p --reverse"))
    if l:file == ""
        return
    endif

    let l:root = trim(system("git rev-parse --show-toplevel"))
    let l:fullpath = trim(system("realpath ".l:file))
    exe "NERDTree " . l:fullpath
endfunction

command! NERDFolder call NERDFolder()
nnoremap <leader>pd :NERDFolder<CR>
