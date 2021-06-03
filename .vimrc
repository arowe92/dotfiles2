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
Plug 'junegunn/fzf'
Plug 'airblade/vim-gitgutter'

" Commenting out code: 'gc'
Plug 'tpope/vim-commentary'
"Plug 'preservim/nerdcommenter'

" EasyMotion Navigation
Plug 'easymotion/vim-easymotion'

" C++ HEader
Plug 'Yohannfra/Vim-Goto-Header'

" Panes
Plug 'caenrique/nvim-toggle-terminal'
Plug 'romgrk/todoist.nvim'

" Maximize Pane
" AutoCompletion
"Plug 'vim-scripts/AutoComplPop'
"Plug 'ycm-core/YouCompleteMe'

" TMux Integration
Plug 'preservim/vimux'
Plug 'christoomey/vim-tmux-navigator'


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
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|bazel*'
let g:ctrlp_cmd = 'CtrlPCurWD'
let g:rainbow_active = 1
let g:airline_theme='simple'
let g:airline#extensions#tabline#enabled = 2
let g:airline#extensions#ctrlp#enabled = 0
let g:goto_header_use_find = 1
let g:goto_header_includes_dirs = ["."]
let g:autoload_session = 1
let todoist = {
\  'icons': {
\    'unchecked': ' ○ ',
\    'checked':   ' ● ',
\    'loading':   ' ◌ ',
\    'error':     ' ⚠ ',
\  },
\  'defaultProject': 'Inbox',
\  'useMarkdownSyntax': v:true,
\}



"----------------------------
"         Key Mappings
"----------------------------

" ========= Plugins ========
noremap <C-\> :NERDTreeToggle<CR>
nmap <C-p> :CtrlPCurWD<CR>
nnoremap <C-b> :CtrlPBuffer<CR>
nnoremap <M-o> :GotoHeaderSwitch<CR>

" noremap <leader>p :Files<CR>
"nnoremap <C-p> :Files<CR>
nnoremap <leader>pf :Files<CR>
nnoremap <leader>pb :Buffers<CR>
nnoremap <leader>pc :Colors<CR>
nnoremap <leader>ph :History<CR>
nnoremap <leader>pw :Windows<CR>
nnoremap <leader>po :Commands<CR>

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
"nnoremap <leader>x :call NERDComment(1, 'toggle')<CR>
nmap <leader>c gcc

" Autocompletion of file paths
inoremap <C-f> <C-x><C-f>

" Save  File
noremap <leader><C-s> :WriteSession<CR>
nnoremap <C-s> :w<CR>
inoremap <C-s> <ESC>:w<CR>

" File Operations
nnoremap <C-c> :echo 'ctrl-c twice to quit'<CR>
nnoremap <C-c><C-c><C-c> :qall!<CR>
map <C-n>w :wq<CR>
map <leader>q :q<CR>
map <C-w> :q<CR>

" Terminal Escape
tnoremap <C-n>e <C-\><C-n>

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
noremap <leader>M <C-w>\| <C-w>_
noremap <leader>m <C-W>=

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

command TD Todoist

" source vimrc on save
augroup vimrc
        autocmd!
        autocmd BufWritePost .vimrc source $MYVIMRC
augroup end

source ~/.config/nvim/SessionHandler.vim

"Graveyard
"let &t_Co=256 " Terminal Colors?"

" Cursor Shapes (Windows may need)
" let &t_SI = "\<Esc>]50;CursorShape=1\x7"
" let &t_SR = "\<Esc>]50;CursorShape=2\x7"
" let &t_EI = "\<Esc>]50;CursorShape=0\x7"

let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

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
"
"
" " Returns the directory of the first file in `argv` or `cwd` if it's empty
