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
Plug 'caenrique/nvim-toggle-terminal'

" Languages
Plug 'maksimr/vim-jsbeautify'
" Plug 'pangloss/vim-javascript',  { 'for': 'javascript' }  
Plug 'jelera/vim-javascript-syntax',  { 'for': 'javascript' }  

Plug 'elixir-editors/vim-elixir'
Plug 'frazrepo/vim-rainbow'
Plug 'Yggdroot/indentLine'

Plug 'preservim/nerdcommenter'
Plug 'grailbio/bazel-compilation-database'


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
Plug 'dracula/vim'
call plug#end()

" Settings
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

"":set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:·
:set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<
:set list


syntax on
filetype plugin indent on

set bg=dark
colorscheme apprentice

" Plugin Settings
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
let &t_Co=256

" Cursor
"let &t_SI = "\<Esc>]50;CursorShape=1\x7"
"let &t_SR = "\<Esc>]50;CursorShape=2\x7"
"let &t_EI = "\<Esc>]50;CursorShape=0\x7"
"

let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

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
nnoremap <leader>t :tabnew<CR> 
nnoremap <C-W> :q<CR>

" Autocompletion of file paths
inoremap <C-f> <C-x><C-f>

" Save ctrl-A
nnoremap <C-s> :w<CR>
inoremap <C-s> <ESC>:w<CR>

" Tab Naviation
noremap <C-k>k <C-W><C-J>
noremap <C-k>i <C-W><C-K>
noremap <C-k>l <C-W><C-L>
noremap <C-k>j <C-W><C-H>

tnoremap <C-k>k <C-W><C-J>
tnoremap <C-k>i <C-W><C-K>
tnoremap <C-k>l <C-W><C-L>
tnoremap <C-k>j <C-W><C-H>
"tnoremap <C-k>j <C-W><C-H>

" Tab Creation
noremap <C-k><C-L> <C-W>v
noremap <C-k><C-J> <C-W>v
noremap <C-k><C-I> <C-W>s
noremap <C-k><C-K> <C-W>s

tnoremap <C-k><C-L> <C-W>v
tnoremap <C-k><C-J> <C-W>v
tnoremap <C-k><C-I> <C-W>s
tnoremap <C-k><C-K> <C-W>s

" Minimize Maximize
noremap <C-K>M <C-W>\| <C-W>_
noremap <C-K>m <C-W>=
tnoremap <C-K>M <C-W>\| <C-W>_
tnoremap <C-K>m <C-W>=

nnoremap <C-k>w :q<CR>
tnoremap <C-k>w :q<CR>
nnoremap <leader>w :q<CR>

" Terminal Escape
tnoremap <C-K>e <C-\><C-n>

nnoremap <leader>x :call NERDComment(1, 'toggle')<CR>

" noremap <C-M-H> <<
" noremap <C-M-L> >>
noremap <C-_>k :m-2<CR>
" noremap <C-M-K> :m +1<CR>
" 

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

:nnoremap <leader>= :vertical resize +10<CR>
:nnoremap <leader>- :vertical resize -10<CR>

:nnoremap <leader>+ :resize +10<CR>
:nnoremap <leader>_ :resize -10<CR>

" Run Las Command
:nnoremap <leader>r :@:<CR>

" toggle quickfix window
:nnoremap <silent> <leader>qo :lopen<cr>
:nnoremap <silent> <leader>qc :lclose<cr>

nnoremap <silent> <C-T> :ToggleTerminal<Enter>
inoremap <silent> <C-T> :ToggleTerminal<Enter>

" Aliases
tnoremap <silent> <C-T> <C-\><C-n>:ToggleTerminal<Enter>
command! TE tabedit
command! OL browse oldfiles 


command! SS split 
" source vimrc on save
augroup vimrc
	autocmd!
	autocmd BufWritePost .vimrc source $MYVIMRC
augroup end

