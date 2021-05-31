" Install vim-plug if it doesnt exist
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins
call plug#begin()

" ==== Tools ====
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' } " File Tree
Plug 'kien/ctrlp.vim' " Fuzzy Search- <C-p>
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'


" Commenting out code: 'gc'
Plug 'tpope/vim-commentary' 
"Plug 'preservim/nerdcommenter'

" EasyMotion Navigation
Plug 'easymotion/vim-easymotion'

" Panes
Plug 'caenrique/nvim-toggle-terminal'

" Maximize Pane
" AutoCompletion
"Plug 'vim-scripts/AutoComplPop' 
"Plug 'ycm-core/YouCompleteMe'


" ==== Languages ==== 
Plug 'pangloss/vim-javascript',  { 'for': 'javascript' }  
Plug 'elixir-editors/vim-elixir'

" ==== Appearance==== 
Plug 'frazrepo/vim-rainbow'
Plug 'Yggdroot/indentLine'

"Status bar
"Plug 'itchyny/lightline.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"Plug 'vim-syntastic/syntastic'

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
colorscheme srcery

" Invisible Characters
:set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<",space:·
:set list

" Syntax and file type detection
syntax on
filetype plugin indent on

"-------------------------
"    General Settings
"-------------------------
set wrap
set autoindent
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

" Swap file location
set directory^=/tmp/

" LEADER KEY MAPPING
" use space as leader
let mapleader=" "


" ==== Plugin Settings ====
" Ignore files in ctrlp search
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
let g:rainbow_active = 1
let g:airline_theme='simple'
let g:airline#extensions#tabline#enabled = 2
let g:airline#extensions#ctrlp#enabled = 0

"----------------------------
"         Key Mappings
"----------------------------

" ========= Plugins ========
nnoremap <C-\> :NERDTreeToggle<CR>  "File Tree Explorer
nnoremap <C-p> :CtrlP<CR>         "Fuzzy search

" noremap <leader>p :Files<CR>
nnoremap <leader>pf :Files<CR>
nnoremap <leader>pb :Buffers<CR>
nnoremap <leader>pc :Colors<CR>
nnoremap <leader>ph :History<CR>
nnoremap <leader>pw :Windows<CR>
nnoremap <leader>po :Commands<CR>


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
"nnoremap <leader>x :call NERDComment(1, 'toggle')<CR>
map <leader>c gcc

" Autocompletion of file paths
inoremap <C-f> <C-x><C-f>

" Save  File
nnoremap <C-s> :w<CR>
inoremap <C-s> <ESC>:w<CR>

" File Operations
nnoremap <C-c> :echo 'ctrl-c twice to quit'<CR> 
nnoremap <C-c><C-c><C-c> :qall!<CR>
map <C-k>w :q<CR>
map <leader>q :q<CR>

" Terminal Escape
tnoremap <C-K>e <C-\><C-n>

" Easy Line Moving / Indenting
noremap <C-M-H> <<
noremap <C-M-L> >>
noremap <C-M-K> :m +1<CR>
noremap <C-_>k :m-2<CR>

" Swap command and repeat movement
"noremap ; :
"noremap : ;

" ==== PANES ====
" Pane Naviation
noremap <C-k>j <C-W><C-J>
noremap <C-k>k <C-W><C-K>
noremap <C-k>l <C-W><C-L>
noremap <C-k>h <C-W><C-H>

" Pane Creation
noremap <C-k><C-J> <C-W>s<C-W><C-J>
noremap <C-k><C-K> <C-W>s<C-W><C-K>
noremap <C-k><C-L> <C-W>v<C-W><C-L>
noremap <C-k><C-H> <C-W>v<C-W><C-H>

" Minimize Maximize Pane
noremap <leader>M <C-W>\| <C-W>_
noremap <leader>m <C-W>=

" Splitting / Sizing Panes
:nnoremap <leader>h :split<CR> 
:nnoremap <leader>v :vsplit<CR>

:nnoremap <leader>= :vertical resize +10<CR>
:nnoremap <leader>- :vertical resize -10<CR>

:nnoremap <leader>+ :resize +10<CR>
:nnoremap <leader>_ :resize -10<CR>


"" Tabs
nnoremap <leader>t :tab split<CR> 
nnoremap <leader>T :tab <C-W>T
nnoremap <leader>o gt
nnoremap <S-Tab> :tabn<CR> 

" VimRc
:nnoremap <leader>ev :vsplit ~/.vimrc<cr>
:nnoremap <leader>ez :vsplit ~/.zshrc<cr>

" source vimrc on save
augroup vimrc
	autocmd!
	autocmd BufWritePost .vimrc source $MYVIMRC
augroup end

"Graveyard
"let &t_Co=256 " Terminal Colors?"

" Cursor Shapes (Windows may need)
"let &t_SI = "\<Esc>]50;CursorShape=1\x7"
"let &t_SR = "\<Esc>]50;CursorShape=2\x7"
"let &t_EI = "\<Esc>]50;CursorShape=0\x7"

"let &t_SI = "\<Esc>[6 q"
"let &t_SR = "\<Esc>[4 q"
"let &t_EI = "\<Esc>[2 q"

"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"Plug 'Raimondi/delimitMate'
"Plug 'tpope/vim-sensible'
"
" toggle quickfix window
":nnoremap <silent> <leader>qo :lopen<cr>
":nnoremap <silent> <leader>qc :lclose<cr>
"
"nnoremap <silent> <C-T> :ToggleTerminal<Enter>
"inoremap <silent> <C-T> :ToggleTerminal<Enter>
"tnoremap <silent> <C-T> <C-\><C-n>:ToggleTerminal<Enter>
"
" clear the highlighting of :set hlsearch
" nnoremap <silent> <leader>h :nohlsearch<cr>
