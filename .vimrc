" Install vim-plug if it doesnt exist
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins
call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'kien/ctrlp.vim'
Plug 'easymotion/vim-easymotion'
Plug 'vim-scripts/AutoComplPop'
Plug 'Raimondi/delimitMate'

" Languages
Plug 'maksimr/vim-jsbeautify'
" Plug 'pangloss/vim-javascript',  { 'for': 'javascript' }  
Plug 'jelera/vim-javascript-syntax',  { 'for': 'javascript' }  


" Status bar
Plug 'itchyny/lightline.vim'
Plug 'vim-syntastic/syntastic'

" Color schemes
Plug 'nanotech/jellybeans.vim'
Plug 'sjl/badwolf'
Plug 'altercation/vim-colors-solarized'
Plug 'morhetz/gruvbox'
Plug 'junegunn/seoul256.vim'
Plug 'ajh17/Spacegray.vim'
Plug 'roosta/srcery'
Plug 'tomasr/molokai'
Plug 'romainl/Apprentice'
call plug#end()

" Settings
set wrap
set shiftwidth=2
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
set tabstop=2
set expandtab

" Swap file location
set directory^=/tmp/

syntax on
filetype plugin indent on

set bg=dark
colorscheme apprentice

" Plugin Settings
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
let &t_Co=256

" Cursor
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_javascript_checkers=['eslint']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


" Key Mappings
nnoremap <C-\> :NERDTreeToggle<CR>
nnoremap <S-C-p> :CtrlP<CR>
nnoremap <C-c> :echo 'ctrl-c twice to quit'<CR>
nnoremap <C-c><C-c> :qall!<CR>
nnoremap <S-Tab> :tabn<CR> 
nnoremap <C-W> :q<CR>

" Autocompletion of file paths
inoremap <C-f> <C-x><C-f>

" Save ctrl-A
nnoremap <C-s> :w<CR>
map <C-s> :w<CR>

" Tab Naviation
nnoremap <C-K>k <C-W><C-J>
nnoremap <C-K>i <C-W><C-K>
nnoremap <C-K>l <C-W><C-L>
nnoremap <C-K>j <C-W><C-H>

nnoremap <C-K><C-L> <C-W>v
nnoremap <C-K><C-J> <C-W>v
nnoremap <C-K><C-I> <C-W>s
nnoremap <C-K><C-K> <C-W>s

" Easier Commands
nnoremap ; :
vnoremap ; :

" LEADER KEY MAPPINGS
" use space as leader
let mapleader=" "

" clear the highlighting of :set hlsearch
nnoremap <silent> <leader>h :nohlsearch<cr>

" quickly open vimrc
:nnoremap <leader>ev :vsplit ~/.vimrc<cr>

" Splitting
:nnoremap <leader>h :split<CR>
:nnoremap <leader>v :vsplit<CR>

" Run Las Command
:nnoremap <leader>r :@:<CR>

" toggle quickfix window
:nnoremap <silent> <leader>qo :lopen<cr>
:nnoremap <silent> <leader>qc :lclose<cr>

" Aliases
command! TE tabedit
command! SS split 
command! OL browse oldfiles 


" source vimrc on save
augroup vimrc
	autocmd!
	autocmd BufWritePost .vimrc source $MYVIMRC
augroup end

