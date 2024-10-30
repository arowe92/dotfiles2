let mapleader=" "

" Save  File
nnoremap <C-s> <cmd>w<CR>
inoremap <C-s> <ESC><cmd>w<CR>

" De-highlight
nnoremap <silent> <leader>H :nohlsearch<cr>

" Delete buffer / Close
" noremap <nowait> <C-w> <cmd>bd<CR>
noremap <nowait> <C-w> <cmd>bp<bar>sp<bar>bn<bar>bd<CR>
noremap <C-q> <cmd>q<CR>

" Easy Indenting
nnoremap <M-H> <<
nnoremap <M-L> >>
inoremap <M-H> <cmd>normal <<<CR>
inoremap <M-L> <cmd>normal >><CR>
vnoremap <M-H> <gv
vnoremap <M-L> >gv

" Easy Line Moving
nnoremap <A-K> <cmd>m .-2<CR>
nnoremap <A-J> <cmd>m .+1<CR>
inoremap <A-K> <cmd>m .-2<CR>
inoremap <A-J> <cmd>m .+1<CR>

vnoremap <A-J> :m '>+1<CR>gv
vnoremap <A-K> :m '<-2<CR>gv

" ==== Windows and Panes ==== {{{2
" Pane Selection
" noremap <C-j> <C-w>j
" noremap <C-k> <C-w>k
" noremap <C-l> <C-w>l
" noremap <C-h> <C-w>h

" Pane Creation
noremap <C-x><C-j> <C-W>s<C-w><C-j>
noremap <C-x><C-k> <C-w>s<C-w><C-k>
noremap <C-x><C-l> <C-w>v<C-w><C-l>
noremap <C-x><C-h> <C-w>v<C-w><C-h>

" Resizing Panes
nnoremap <leader>= :vertical resize +10<CR>
nnoremap <leader>- :vertical resize -10<CR>
nnoremap <leader>+ :resize +10<CR>
nnoremap <leader>_ :resize -10<CR>

"" Buffers
noremap <C-x>l :bn<CR>
noremap <C-x>h :bp<CR>
nnoremap <S-Tab> <C-^>

"" Tabs
noremap <C-x>k :tabn<CR>
noremap <C-x>j :tabp<CR>

" QuickFix Managing
nnoremap <silent> <leader>qo <cmd>copen<CR>
nnoremap <silent> <leader>qc <cmd>cclose<CR>
nnoremap <silent> <leader>qq <cmd>copen<CR>
nnoremap <silent> <leader>qx <cmd>call setqflist([], 'r')<CR>

" Incrementing
vnoremap <C-g> g<C-a>
nnoremap <A-8> <C-a>
nnoremap <A-7> <C-x>

" ==== Insert Mode ====
" Paste
inoremap <C-v> <C-r>"
" Move to End of line
inoremap <C-e> <Esc>A

" Open / Close tags
inoremap <M-{> {<CR><CR>}<UP><C-f>
inoremap <M-[> []<Left>
inoremap <M-(> ()<Left>
inoremap <M-"> ""<Left>
inoremap <M-'> ''<Left>

" ==== Command Mode ==== {{{2
cnoremap <C-v> <C-r>"
cnoremap <M-r> <C-f>
cnoremap <M-v> <C-r>/

cnoremap <C-j> <C-W>s<C-w><C-k>
cnoremap <C-k> <C-w>s<C-w><C-k>
cnoremap <C-l> <C-w>v<C-w><C-l>
cnoremap <C-h> <C-w>v<C-w><C-h>

" Delete Word and Line
inoremap <C-U> <C-G>u<C-U>
inoremap <C-W> <C-G>u<C-W>

" ==== Vim Command Overrides ==== {{{2
" Move to end of line easy
nnoremap H ^
nnoremap L $
xnoremap H ^
xnoremap L $
onoremap H ^
onoremap L $

" Command Prompt
noremap ; :<Up>

" End visual mode at bottom
xmap y ygv<Esc>
xmap Y <cmd>normal! y<CR>

" X Does not go to clipboard
xnoremap x "_d
xnoremap X "_D
xnoremap X "_D

" C does not go to clipboard
noremap c "_c
noremap C "_C

" Copy to system
xnoremap <leader>y "+y

" silent search if wrap-around enabled
map <silent> n n

" Easier block mode
nnoremap v <C-v>
nnoremap <C-v> v

" Classic jk escape
inoremap jk <esc>
inoremap kj <esc>

cnoremap jk <esc>
cnoremap kj <esc>
cnoremap jh <CR>
cnoremap hj <CR>
cnoremap jk <CR>

" Inser line above / below
nnoremap <leader>sk mpO<esc>`pdmp
nnoremap <leader>sj mpo<esc>`pdmp

" Select All
noremap <M-a> 1GVG

" Easy Semicolon / comma
nnoremap <silent> <M-;> mmA;<esc>`mmm
nnoremap <silent> <M-:> mm$x`mmm
nnoremap <silent> <M-,> mmA,<esc>`mmm

" Dont yank on replace
vnoremap p "_dP

" New line when completion open
inoremap <M-CR> <Esc>o

" Quit All
nnoremap ZZ <CMD>qa!<CR>
nnoremap Zz <CMD>qa<CR>

" Replace Search
nnoremap <leader>r :%s/<C-r>///g<Left><Left>
nnoremap <leader>R *:%s/<C-r>///g<Left><Left>
vnoremap <leader>r :%s/<C-r>///g<Left><Left>
vnoremap <leader>R :%s/<C-r>///g<Left><Left>

" Toggles
nnoremap <leader>tw :set wrap!<CR>

" Filetype mappings
autocmd FileType rust inoremap <buffer> <A-u> .unwrap()
autocmd FileType rust inoremap <buffer> <A-c> .clone()
