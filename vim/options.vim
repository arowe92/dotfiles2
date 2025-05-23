
set wrap
set number
" Disable line numbers in terminal mode
autocmd TermOpen * setlocal nonumber
set hlsearch
set smartcase
set ignorecase
set textwidth=0
set undolevels=1000
set showcmd
set autowrite
set mouse=a
set wildmenu
set wildmode=full
set wildchar=<Tab>
set foldlevel=99
set cursorline
set hidden
set noshowmode
set iskeyword=@,48-57,_,192-255
set scrolloff=3 " Keep 3 lines below and above the cursor
set foldmethod=indent
set shortmess+=A
set shortmess+=S
set formatoptions-=cro

" Vim-sensible options
set autoindent
set backspace=indent,eol,start
set complete-=i
set smarttab
set nrformats-=octal
set laststatus=2
set ruler
set display+=lastline
set encoding=utf-8
set listchars=tab:·┈,trail:￮,multispace:￮,lead:\ ,extends:▶,precedes:◀,nbsp:‿
set tabpagemax=50
set history=1000
set viminfo^=!
set sessionoptions-=options
set viewoptions-=options

" Tabs
set shiftwidth=4
set tabstop=4
set expandtab

" Allow Italics
set t_ZH=^[[3m
set t_ZR=^[[23m
set t_Co=16

set directory^=/tmp/swp
set tags+=~/.vim/tags

if has('nvim')
endif

if executable('rg')
    " Use rg over grep
    set grepprg=rg\ --vimgrep\ --hidden
endif

" Diagnistic symbols
sign define DiagnosticSignError text= texthl=TextError linehl= numhl=
sign define DiagnosticSignWarn  text= texthl=TextWarn  linehl= numhl=
sign define DiagnosticSignInfo  text= texthl=TextInfo  linehl= numhl=
sign define DiagnosticSignHint  text= texthl=TextHint  linehl= numhl=

" Auto Command to set formatopions on all files
autocmd FileType * set formatoptions-=cro


