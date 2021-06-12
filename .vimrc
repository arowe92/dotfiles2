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
Plug 'yegappan/taglist'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'kshenoy/vim-signature'
Plug 'junegunn/goyo.vim'

" Fzf if installed else, ctrlp
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Navigation
Plug 'easymotion/vim-easymotion'
Plug 'dkprice/vim-easygrep'
Plug 'Yohannfra/Vim-Goto-Header'

" Text Editing
" Plug 'ycm-core/YouCompleteMe'
Plug 'terryma/vim-multiple-cursors'
Plug 'AndrewRadev/sideways.vim'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-commentary'

" Tmux Integration
Plug 'preservim/vimux'
Plug 'christoomey/vim-tmux-navigator'

" ==== Language Support  ====
" Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'bfrg/vim-cpp-modern'
Plug 'pangloss/vim-javascript',  { 'for': 'javascript' }
Plug 'elixir-editors/vim-elixir'
Plug 'google/vim-maktaba'
Plug 'bazelbuild/vim-bazel'

" ==== Appearance====
" Plug 'frazrepo/vim-rainbow'
Plug 'luochen1990/rainbow'
Plug 'Yggdroot/indentLine'
Plug 'ryanoasis/vim-devicons'

"Status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ojroques/vim-scrollstatus'

" ==== Color schemes ====
Plug 'nanotech/jellybeans.vim'
Plug 'sjl/badwolf'
Plug 'morhetz/gruvbox'
Plug 'junegunn/seoul256.vim'
Plug 'ajh17/Spacegray.vim'
Plug 'roosta/srcery'
Plug 'tomasr/molokai'
Plug 'romainl/Apprentice'
Plug 'dracula/vim'
call plug#end()

"-------------------------
"     Theme Settings
"-------------------------
colorscheme gruvbox

" Invisible Characters
:set list
" :set colorcolumn=100

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


" Swap file location
set directory^=/tmp/

" Add Path for easy jumping
set path+=/home/arowe/repos/sims
set tags+=~/.vim/tags

" LEADER KEY MAPPING
" use space as leader
let mapleader=" "

" ==== Plugin Settings ====
" Ignore files in ctrlp search
let g:ctrlp_cmd = 'CtrlPCurWD'
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|bazel*'
let g:rainbow_active = 1

let g:airline_theme='simple'
let g:airline#extensions#tabline#enabled = 2
let g:airline_powerline_fonts = 1
let g:scrollstatus_symbol_track = '┈'
let g:scrollstatus_symbol_bar = '━'
let g:airline_section_x = airline#section#create(['%l'])
let g:airline_section_y = '%{ScrollStatus()}'
let g:airline_section_z = airline#section#create([''])
let g:airline_extensions = ["tabline"]

let g:goto_header_use_find = 1
let g:goto_header_includes_dirs = ["."]

let g:autoload_session = 0
let g:indentLine_char = '▏'

let g:quickui_color_scheme = 'gruvbox'

let g:ycm_max_diagnostics_to_display = 9999

" Windows fix
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="-"

" Nerdtree rainbow fix
let g:rainbow_conf = {'separately': {'nerdtree': 0}}


"----------------------------
"         Key Mappings
"----------------------------

" ========= Plugins ========
noremap <C-\> :NERDTreeToggle<CR>
noremap <leader>\ :NERDTreeToggle<CR>

" Quick UI 
noremap <leader><CR> :call quickui#menu#open()<CR>
nnoremap <leader><leader> :call quickui#tools#clever_context('k', g:context_menu_k, {})<cr>

" FZF Mappings
nnoremap <C-p> :Files<CR>
nnoremap <C-b> :Buffers<CR>
nnoremap <M-o> :GotoHeaderSwitch<CR>
nnoremap <leader>p :Commands<CR>

" bind K to grep word under cursor
nnoremap gw :execute 'Ag '.expand('<cword>')<CR>

" Git Gutter 
nnoremap <leader>g] :GitGutterNextHunk<CR>
nnoremap <leader>g[ :GitGutterPrevHunk<CR>
nnoremap <leader>gh :GitGutterLineHighlightsToggle<CR>
nnoremap <leader>gg :GitGutterToggle<CR>

" YCM "
nnoremap gl :YcmCompleter GoToDefinition<CR>
nnoremap gk :YcmCompleter GoToDeclaration<CR>

" EasyMotion Commands
" <Leader>f{char} to move to {char}
map  <leader>f <Plug>(easymotion-bd-f)
nmap <leader>f <Plug>(easymotion-overwin-f)
" s{char}{char} to move to {char}{char}
map s <Plug>(easymotion-bd-f2)
nmap s <Plug>(easymotion-overwin-f2)
" Move to line
map <leader>l <Plug>(easymotion-bd-jk)
nmap <leader>l <Plug>(easymotion-overwin-line)
" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

" Comment
nnoremap <leader>c :Commentary<CR>

" clear the highlighting of :set hlsearch
nnoremap <silent> <leader>H :nohlsearch<cr>

" Save  File
nnoremap <C-s> :w<CR>
inoremap <C-s> <ESC>:w<CR>
noremap <leader><C-s> :WriteSession<CR>

" File Operations
nnoremap <C-c> :echo 'ctrl-c thrice to quit'<CR>
nnoremap <C-c><C-c><C-c> :qall!<CR>
map <C-w> :bd<CR>
map <C-q> :q<CR>
noremap <leader>r @:<CR> "Run Last Command"

" Terminal Escape
tnoremap <C-n>e <C-\><C-n>

" Easy Line Moving / Indenting
noremap <M-h> <<
noremap <M-l> >>
noremap <M-j> :m+1<CR>
noremap <M-k> :m-2<CR>
noremap <M-,> :SidewaysLeft<CR>
noremap <M-.> :SidewaysRight<CR>

" Insert Mode Mappings
" Paste
inoremap <C-v> <C-r>"

" ==== Windows and Panes ====
" Remap window prefix
nnoremap <C-n> <C-W>

" Move Pane
noremap <C-j> <C-w><C-j>
noremap <C-k> <C-w><C-k>
noremap <C-l> <C-w><C-l>
noremap <C-h> <C-w><C-h>

" Pane Creation
noremap <C-n><C-j> <C-W>s<C-w><C-k>
noremap <C-n><C-k> <C-w>s<C-w><C-k>
noremap <C-n><C-l> <C-w>v<C-w><C-l>
noremap <C-n><C-h> <C-w>v<C-w><C-h>

" Switch to Layout  Maximize Pane
nnoremap <leader>l1 <C-w>\| <C-w>_
nnoremap <leader>l2 <C-W>=
nnoremap <leader>l` :Goyo<CR>


" Splitting / Sizing Panes
:nnoremap <leader>h :split<CR>

:nnoremap <leader>v :vsplit<CR>
:nnoremap <leader>= :vertical resize +10<CR>
:nnoremap <leader>- :vertical resize -10<CR>

:nnoremap <leader>+ :resize +10<CR>
:nnoremap <leader>_ :resize -10<CR>


"" Buffers
noremap <leader>] :bn<CR>
noremap <leader>[ :bp<CR>
noremap <M-]> :bn<CR>
noremap <M-[> :bp<CR>

"" Tabs
nnoremap <leader>t :tab split<CR>
noremap <M-}> :tabn<CR>
noremap <M-{> :tabp<CR>

noremap <leader>} :tab split<CR>
noremap <leader>{ :tab new \| tabm -1<CR>

" VimRc
:nnoremap <leader>ev :vsplit ~/.vimrc<cr>
:nnoremap <leader>ez :vsplit ~/.zshrc<cr>
:nnoremap <leader>et :vsplit ~/.tmux.conf<cr>

" Misc
noremap <leader>R :redraw!<CR>

" ===================
" Custom Commands
" ===================
command! TD Todoist

" Copy The Path of the file
command! CP :let @" = system("realpath " . shellescape(expand('%')))

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
            \ ['Files', ':Files'],
            \ ['Buffers', ':Buffers'],
            \ ['Commands', ':Commands'],
            \ ['GFile', ':Giles'],
            \ ['Git Status', ':GFiles?'],
            \ ['Colors',':Colors'],
            \ ['All Buffer Lines', ':Lines'],
            \ ['Current Buffer Lines', ':BLines'],
            \ ['Tags', ':Tags'],
            \ ['Buffer Tags', ':BTags'],
            \ ['Marks', ':Marks'],
            \ ['Windows', ':Windows'],
            \ ['History', ':History'],
            \ ['Command History', ':History:'],
            \ ['File History', ':History/'],
            \ ['Snippets', ':Snippets'],
            \ ['Commits', ':Commits'],
            \ ['Buffer Commits', ':BCommits'],
            \ ['Maps', ':Maps'],
            \ ['Helptags', ':Helptags'],
            \ ['Filetypes', ':Filetypes'],
            \ ['============'],
            \ ['Locate &3', ':Locate'],
            \ ['Ag &3', ':Ag'],
            "\ ['&Rg', ':Rg'],
            \ ])


call system('upfind WORKSPACE')
if v:shell_error == 0
call quickui#menu#install("&Bazel", [
            \ ['&Build', ':Bazel build //pythia/src:pythia'],
            \ ['&Test', ':Bazel test //pythia/src:fast'],
            \ ])
endif

call quickui#menu#install("&Tools", [
            \ ['&Tag List', ':TlistToggle'],
            \ ['&Git Gutter', ':GitGutterToggle'],
            \ ['Git &Diff', ':Gdiffsplit'],
            \ ])

let g:context_menu_k = [
            \ ["&Peek Definition\tAlt+;", 'call quickui#tools#preview_tag("")'],
            \ ["S&earch in Project\t\\cx", 'exec "silent! GrepCode! " . expand("<cword>")'],
            \ [ "--", ],
            \ [ "Find &Definition\t\\cg", 'call MenuHelp_Fscope("g")', 'GNU Global search g'],
            \ [ "Find &Symbol\t\\cs", 'call MenuHelp_Fscope("s")', 'GNU Gloal search s'],
            \ [ "Find &Called by\t\\cd", 'call MenuHelp_Fscope("d")', 'GNU Global search d'],
            \ [ "Find C&alling\t\\cc", 'call MenuHelp_Fscope("c")', 'GNU Global search c'],
            \ [ "Find &From Ctags\t\\cz", 'call MenuHelp_Fscope("z")', 'GNU Global search c'],
            \ [ "--", ],
            \ [ "Goto D&efinition\t(YCM)", 'YcmCompleter GoToDefinitionElseDeclaration'],
            \ [ "Goto &References\t(YCM)", 'YcmCompleter GoToReferences'],
            \ [ "Get D&oc\t(YCM)", 'YcmCompleter GetDoc'],
            \ [ "Get &Type\t(YCM)", 'YcmCompleter GetTypeImprecise'],
            \ [ "--", ],
            \ ['Dash &Help', 'call asclib#utils#dash_ft(&ft, expand("<cword>"))'],
            \ ['Cpp&man', 'exec "Cppman " . expand("<cword>")', '', 'c,cpp'],
            \ ['P&ython Doc', 'call quickui#tools#python_help("")', 'python'],
            \ ]



" let g:scrollstatus_symbol_track_start = '╣'
" let g:scrollstatus_symbol_track_end = '╠'
"let g:scrollstatus_symbol_bar_end = '┥'
"let g:scrollstatus_symbol_bar_start = '┣'
"
:set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<",space:·
