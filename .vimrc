" Install vim-plug if it doesnt exist
"
if empty(glob('~/.vim/autoload/plug.vim'))
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" Plugins

call plug#begin()

" ==== Tools ====
Plug 'terryma/vim-multiple-cursors'
Plug 'skywind3000/vim-quickui'
"
" Navigation
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' } " File Tree
" Plug 'kien/ctrlp.vim' " Fuzzy Search- <C-p>
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'easymotion/vim-easymotion'
Plug 'dkprice/vim-easygrep'
Plug 'lornix/vim-scrollbar'

" AutoComplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'tpope/vim-fugitive'

" Snippets
" Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Indicators
Plug 'airblade/vim-gitgutter'
Plug 'kshenoy/vim-signature'

" Commenting out code: 'gc'
Plug 'tpope/vim-commentary'
"Plug 'preservim/nerdcommenter'

" Code Header
Plug 'Yohannfra/Vim-Goto-Header'

" Window Management
" Plug 'caenrique/nvim-toggle-terminal'
" Plug 'romgrk/todoist.nvim'

" AutoCompletion
" Plug 'vim-scripts/AutoComplPop'
Plug 'ycm-core/YouCompleteMe'
" Plug 'grailbio/bazel-compilation-database'


" TMux Integration
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
Plug 'junegunn/goyo.vim'
" Plug 'frazrepo/vim-rainbow'
Plug 'luochen1990/rainbow'
Plug 'Yggdroot/indentLine'
Plug 'ryanoasis/vim-devicons'

"Status bar
"Plug 'itchyny/lightline.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

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
:set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<",space:·
:set list

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

" LEADER KEY MAPPING
" use space as leader
let mapleader=" "


" ==== Plugin Settings ====
" Ignore files in ctrlp search
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|bazel*'
let g:ctrlp_cmd = 'CtrlPCurWD'
let g:rainbow_active = 1
let g:airline_theme='simple'
let g:airline#extensions#tabline#enabled = 2
let g:airline#extensions#ctrlp#enabled = 1
let g:goto_header_use_find = 1
let g:goto_header_includes_dirs = ["."]
let g:autoload_session = 0
let g:deoplete#enable_at_startup = 1

" Windows fix
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="-"

" Nerdtree rainbow fix
let g:rainbow_conf = {
  \    'separately': {
  \       'nerdtree': 0
  \    }
  \}


call deoplete#custom#option('candidate_marks',
      \ ['A', 'S', 'D', 'F', 'G'])
inoremap <expr><M-a>       pumvisible() ?
\ deoplete#insert_candidate(0) : '<M-a>'
inoremap <expr><M-s>       pumvisible() ?
\ deoplete#insert_candidate(1) : '<M-s>'
inoremap <expr><M-d>       pumvisible() ?
\ deoplete#insert_candidate(2) : '<M-d>'
inoremap <expr><M-f>       pumvisible() ?
\ deoplete#insert_candidate(3) : '<M-f>'
inoremap <expr><M-g>      pumvisible() ?
\ deoplete#insert_candidate(4) : '<M-g>'
inoremap <expr><Tab>       pumvisible() ?
\ deoplete#insert_candidate(0) : '<Tab>'

"----------------------------
"         Key Mappings
"----------------------------

" ========= Plugins ========
noremap <C-\> :NERDTreeToggle<CR>
noremap <leader>\ :NERDTreeToggle<CR>
nnoremap <C-p> :Files<CR>
nnoremap <C-b> :Buffers<CR>
nnoremap <M-o> :GotoHeaderSwitch<CR>
nnoremap <leader>p :Commands<CR>

" Git Gutter "
nnoremap <leader>g] :GitGutterNextHunk<CR>
nnoremap <leader>g[ :GitGutterPrevHunk<CR>
nnoremap <leader>gh :GitGutterLineHighlightsToggle<CR>
nnoremap <leader>gt :GitGutterToggle<CR>


" EasyMotion Commands
" <Leader>f{char} to move to {char}
map  <leader>f <Plug>(easymotion-bd-f)
nmap <leader>f <Plug>(easymotion-overwin-f)
" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)
" Move to line
map <leader>l <Plug>(easymotion-bd-jk)
nmap <leader>l <Plug>(easymotion-overwin-line)
" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

" Comment
" nnoremap <leader>x :call NERDComment(1, 'toggle')<CR>
nnoremap <leader>c gcc

" clear the highlighting of :set hlsearch
nnoremap <silent> <leader>h :nohlsearch<cr>

" Save  File
noremap <leader><C-s> :WriteSession<CR>
nnoremap <C-s> :w<CR>
inoremap <C-s> <ESC>:w<CR>

" File Operations
nnoremap <C-c> :echo 'ctrl-c thrice to quit'<CR>
nnoremap <C-c><C-c><C-c> :qall!<CR>
map <C-n>w :wq<CR>
map <leader>q :q<CR>
map <C-w> :bd<CR>
map <C-q> :q<CR>
noremap <leader>r @:<CR>

" Terminal Escape
tnoremap <C-n>e <C-\><C-n>

" Easy Line Moving / Indenting
noremap <M-h> <<
noremap <M-l> >>
noremap <M-k> :m+1<CR>
noremap <M-j> :m-2<CR>

" Swap command and repeat movement
"noremap ; :
"noremap : ;

" ==== PANES ====
" Pane Naviation
noremap <C-n>j <C-W><C-J>
noremap <C-n>k <C-W><C-K>
noremap <C-n>l <C-W><C-L>
noremap <C-n>h <C-W><C-H>

noremap <C-j> <C-w><C-j>
noremap <C-k> <C-w><C-k>
noremap <C-l> <C-w><C-l>
noremap <C-h> <C-w><C-h>
tnoremap <C-j> <C-w><C-j>
tnoremap <C-k> <C-w><C-k>
tnoremap <C-l> <C-w><C-l>
tnoremap <C-h> <C-w><C-h>

" Pane Creation
noremap <C-n><C-j> <C-W>s<C-w><C-k>
noremap <C-n><C-k> <C-w>s<C-w><C-k>
noremap <C-n><C-l> <C-w>v<C-w><C-l>
noremap <C-n><C-h> <C-w>v<C-w><C-h>

" Minimize Maximize Pane
noremap <leader>l1 <C-w>\| <C-w>_
noremap <leader>l2 <C-W>=
nnoremap <leader>l` :Goyo<CR>

" remap winddow prefix
nnoremap <C-n> <C-W>

" Splitting / Sizing Panes
:nnoremap <leader>h :split<CR>

:nnoremap <leader>v :vsplit<CR>
:nnoremap <leader>= :vertical resize +10<CR>
:nnoremap <leader>- :vertical resize -10<CR>

:nnoremap <leader>+ :resize +10<CR>
:nnoremap <leader>_ :resize -10<CR>


"" Buffers
nnoremap <leader>n :bn<CR>
nnoremap <leader>N :bp<CR>
noremap <leader>] :bn<CR>
noremap <leader>[ :bp<CR>

"" Tabs
nnoremap <leader>t :tab split<CR>
nnoremap <leader>T :tab <C-W>T<CR>
nnoremap <leader>o gt
nnoremap <S-Tab> :tabn<CR>

noremap <leader>} :tab split<CR>
noremap <leader>{ :tab new \| tabm -1<CR>

" VimRc
:nnoremap <leader>ev :vsplit ~/.vimrc<cr>
:nnoremap <leader>ez :vsplit ~/.zshrc<cr>

noremap <leader>R :redraw!<CR>

" ===================
" Custom Commands
" ===================
command! TD Todoist

" Copy The Path of the file
command! CP :let @" = system("realpath " . shellescape(expand('%')))

" Custom Session Handler
source ~/.config/nvim/SessionHandler.vim

" source vimrc on save
" augroup vimrc
"         autocmd!
"         autocmd BufWritePost .vimrc source $MYVIMRC
" augroup end

" ========= Auto Commands ==============
" Remove spaceds
augroup twig_ft
    au!
    autocmd BufWritePre *.h,*.cc %s/\s\+$//e
    autocmd BufNewFile,BufRead *.h,*.cc   set syntax=cpp.doxygen
augroup END


" ========================================
" =  Quick UI menu
" ========================================
noremap <leader><CR> :call quickui#menu#open()<CR>
let g:quickui_color_scheme = 'gruvbox'
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

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
