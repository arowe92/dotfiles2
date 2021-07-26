" Options
let g:GIT_TOOLS = 1
let g:CPP_TOOLS = 0
let g:GUI_TOOLS = 1
let g:NVIM_TOOLS = 1
let g:SNIPPETS = 1
let g:AIRLINE = 1
let g:TMUX = 1 && exists("$TMUX")

if exists('$VIM_LITE')
    let g:GIT_TOOLS = 1
    let g:CPP_TOOLS = 0
    let g:GUI_TOOLS = 0
    let g:NVIM_TOOLS = 0
    let g:SNIPPETS = 1
    let g:AIRLINE = 0
endif

if exists('g:vscode')
    let g:GIT_TOOLS = 0
    let g:CPP_TOOLS = 0
    let g:GUI_TOOLS = 0
    let g:NVIM_TOOLS = 0
    let g:SNIPPETS = 0
    let g:AIRLINE = 0
endif


" Install vim-plug if it doesnt exist
if empty(glob('~/.vim/autoload/plug.vim'))
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin()

" Plugin Helpers
function! PlugLoaded(name) abort
    let l:name = substitute(a:name, "[-.]", '_', 'g')
    let l:name = substitute(l:name, "[',]", '', 'g')
    let l:name = substitute(l:name, "\.n?vim$", '', 'g')
    return exists('g:plugin_'.l:name) || exists('g:plugin_vim_'.l:name) || exists('g:plugin_nvim_'.l:name)
endfunction
function! PlugDef(...) abort
    let l:name = split(a:000[0], '/')[1]
    let l:name = substitute(l:name, "[-.]", '_', 'g')
    let l:name = substitute(l:name, "[',]", '', 'g')
    let l:name = substitute(l:name, "\.n?vim$", '', 'g')

    if l:name =~ 'nvim' && !has('nvim')
        return
    endif

    execute 'Plug '.join(a:000)
    execute ('let g:plugin_'.l:name.' = 1')
endfunction
command! -nargs=+ PlugDef call PlugDef(<f-args>)

" Essentials
PlugDef 'easymotion/vim-easymotion'
PlugDef 'bogado/file-line'
PlugDef 'tpope/vim-surround'

" GUI Essentials
PlugDef 'kshenoy/vim-signature' " Show Marks in Sidebar

if g:GUI_TOOLS
PlugDef 'mbbill/undotree'
PlugDef 'yegappan/taglist'
PlugDef 'brooth/far.vim' " Find & Replace
PlugDef 'skywind3000/vim-quickui'
PlugDef 'liuchengxu/vim-which-key'
PlugDef 'kyazdani42/nvim-tree.lua'
endif

if g:NVIM_TOOLS
PlugDef 'neovim/nvim-lspconfig'
PlugDef 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
PlugDef 'hrsh7th/nvim-compe'
PlugDef 'nvim-lua/popup.nvim'
PlugDef 'nvim-lua/plenary.nvim'
PlugDef 'nvim-telescope/telescope.nvim'
PlugDef 'nvim-telescope/telescope-frecency.nvim'
PlugDef 'tami5/sql.nvim'
endif

if g:GIT_TOOLS
PlugDef 'tpope/vim-fugitive'
PlugDef 'airblade/vim-gitgutter'
PlugDef 'rhysd/conflict-marker.vim'
endif

" Hardcore C++ tools
if g:CPP_TOOLS
PlugDef 'puremoLheurning/vimspector', {'for': 'cpp'}
PlugDef 'Yohannfra/Vim-Goto-Header', {'for': 'cpp'}
endif

" Tmux Integration
if g:TMUX
PlugDef 'preservim/vimux'
PlugDef 'christoomey/vim-tmux-navigator'
PlugDef 'roxma/vim-tmux-clipboard'
endif

" Snippets
if g:SNIPPETS
PlugDef 'SirVer/ultisnips'
PlugDef 'honza/vim-snippets'
endif

" Status bar
if g:AIRLINE
PlugDef 'vim-airline/vim-airline'
PlugDef 'vim-airline/vim-airline-themes'
PlugDef 'ojroques/vim-scrollstatus'
endif

" Window Management
PlugDef 'caenrique/nvim-maximize-window-toggle'
PlugDef 'Asheq/close-buffers.vim'

" Text Editing
PlugDef 'terryma/vim-multiple-cursors'
PlugDef 'AndrewRadev/sideways.vim'
PlugDef 'tpope/vim-commentary'
PlugDef 'tpope/vim-sensible'
PlugDef 'tpope/vim-eunuch' " Unix Commands
PlugDef 'meain/vim-printer'

" Misc
PlugDef 'tpope/vim-repeat'
PlugDef 'lfv89/vim-interestingwords'

PlugDef 'xolox/vim-misc'
PlugDef 'xolox/vim-session'

" ==== Language Support  ====
PlugDef 'MaxMEllon/vim-jsx-pretty'
PlugDef 'pangloss/vim-javascript',  { 'for': 'javascript' }
PlugDef 'elixir-editors/vim-elixir'
PlugDef 'rust-lang/rust.vim'
PlugDef 'MTDL9/vim-log-highlighting'
PlugDef 'plasticboy/vim-markdown'
PlugDef 'cespare/vim-toml'

" ==== Appearance====
PlugDef 'luochen1990/rainbow' | let g:rainbow_active = 1
PlugDef 'Yggdroot/indentLine'
PlugDef 'ryanoasis/vim-devicons'
PlugDef 'kyazdani42/nvim-web-devicons' " for file icons

" ==== Color schemes ====
PlugDef 'sainnhe/sonokai'

call plug#end()

"=========================
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
set clipboard+=unnamedplus


" Map key
let mapleader=" "

" Use ag if it exists
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
endif

if exists(':GuiFont')
GuiFont FuraMono NF:h11
endif

"== General Settings End ==

"=========================
" Appearance
"-------------------------
if PlugLoaded('sonokai')
" Available values: `'default'`, `'atlantis'`, `'andromeda'`, `'shusia'`, `'maia'`, `'espresso'`
let g:sonokai_style = 'atlantis'
let g:sonokai_enable_italic = 0
let g:sonokai_disable_italic_comment = 0
colorscheme sonokai
endif

"=========================
"    Plugin Settings
"-------------------------
" ===== Airline ======
if PlugLoaded('airline')
let g:airline_powerline_fonts = 1
let g:airline_left_sep = "\uE0B4"
let g:airline_right_sep = "\uE0B6"
let g:airline_section_c_only_filename = 1
let g:airline_section_x = '%{Cwd()}'
let g:airline_section_y = '%{ScrollStatus()}'
let g:airline_section_z = airline#section#create(['%l:%c'])
let g:airline_extensions = ["tabline", "hunks", "searchcount", "coc"]
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#enabled = 2
let g:airline#extensions#searchcount#enabled = 1
endif

" Scroll Status
let g:scrollstatus_symbol_track = '─'
let g:scrollstatus_symbol_bar = '━'

" Goto Header
let g:goto_header_use_find = 1
let g:goto_header_includes_dirs = ["."]

" Misc PLugins
let g:autoload_session = 0
let g:indentLine_char = '▏'
let g:UltiSnipsExpandTrigger="<M-u>"
let g:smoothie_speed_exponentiation_factor=1.3
let g:session_autosave_periodic=3
let g:session_autosave='yes'
let g:session_autoload='no'
let g:interestingWordsDefaultMappings = 0

" == FZF ==
" Use tmux FZF if tmux exists
if g:TMUX
    let g:fzf_layout = { 'tmux': '-p80%,60%' }
else
    let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
endif

" Vim Printer
let g:vim_printer_print_below_keybinding = '<leader>gp'
let g:vim_printer_print_above_keybinding = '<leader>gP'
let g:vim_printer_items = {
            \ 'javascript': 'console.log("{$}:", {$})',
            \ 'python': 'print("{$}:", {$})',
            \ 'cpp': 'info(0) << "{$}:" << {$} << std::endl;',
            \ }

"====== Nvim Tree ========
if PlugLoaded('nvim_tree_lua')
noremap <leader>\ :NvimTreeToggle<CR>
noremap <leader>\| :NvimTreeFindFile<CR>

let g:nvim_tree_hijack_netrw = 1
let g:nvim_tree_disable_window_picker = 1
let g:nvim_tree_highlight_opened_files = 1
let g:nvim_tree_git_hl = 1
let g:nvim_tree_update_cwd = 1
endif

" ====== Which Key =======
if PlugLoaded('which_key')
noremap <leader> :WhichKey ' '<CR>
let g:which_key_map =  {}
let g:which_key_map.p = { 'name' : '+fuzzy' }
let g:which_key_map.c = { 'name' : '+coc' }
let g:which_key_map.d = { 'name' : '+vimspector' }
let g:which_key_map.e = { 'name' : '+edit' }
let g:which_key_map.g = { 'name' : '+git' }
let g:which_key_map.x = { 'name' : '+extension' }
call which_key#register('<Space>', "g:which_key_map")
endif

"==== Conflict Marker ====
if PlugLoaded('config_marker')
let g:conflict_marker_enable_mappings = 0
nmap <buffer>]c <Plug>(conflict-marker-next-hunk)
nmap <buffer>[c <Plug>(conflict-marker-prev-hunk)
nmap <buffer>ct <Plug>(conflict-marker-themselves)
nmap <buffer>co <Plug>(conflict-marker-ourselves)
nmap <buffer>cn <Plug>(conflict-marker-none)
nmap <buffer>cb <Plug>(conflict-marker-both)
nmap <buffer>cB <Plug>(conflict-marker-both-rev)

highlight ConflictMarkerBegin guibg=#2f7366
highlight ConflictMarkerOurs guibg=#2e5049
highlight ConflictMarkerTheirs guibg=#344f69
highlight ConflictMarkerEnd guibg=#2f628e
highlight ConflictMarkerCommonAncestorsHunk guibg=#754a81
endif

"==== Git Gutter ====
if PlugLoaded('gitgutter')
let g:gitgutter_map_keys = 0

nnoremap ]g :GitGutterNextHunk<CR>
nnoremap [g :GitGutterPrevHunk<CR>
nnoremap <leader>gg :GitGutterNextHunk<CR>
nnoremap <leader>gG :GitGutterPrevHunk<CR>
nnoremap <leader>gh :GitGutterLineHighlightsToggle<CR>
nnoremap <leader>gt :GitGutterToggle<CR>
nnoremap <leader>ga :GitGutterStageHunk<CR>
nnoremap <leader>gu :GitGutterUndoHunk<CR>
endif

"===== EasyMotion ========
if exists('g:plug_easymotion')
let g:EasyMotion_keys='asdfgtrebvcwqxzyuionmpASDFGHlkjh'
map <leader>f <Plug>(easymotion-bd-f2)
map s <Plug>(easymotion-bd-f)
map <Leader>w <Plug>(easymotion-bd-w)

map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)
endif

"===== Vimux =============
if PlugLoaded('vimux')
let g:VimuxOrientation = "h"

noremap <M-`> :VimuxTogglePane<CR>
noremap <M-R> :VimuxPrompt:Command<CR>
noremap <M-r> :VimuxRunLastCommand<CR>
endif

" ==== Telescope =========
if PlugLoaded('telescope_nvim')
nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <M-p> <cmd>Telescope frecency<cr>
nnoremap <M-P> <cmd>Telescope command_history<cr>

nnoremap <leader>pp <cmd>lua require('telescope').extensions.frecency.frecency()<CR>
nnoremap <leader>pc :Telescope commands<CR>
nnoremap <leader>ph :Telescope frecency<CR>
nnoremap <leader>pC :Telescope command_history<CR>
nnoremap <leader>pb :Telescope buffers<CR>
nnoremap <leader>pa :Telescope current_buffer_tags<CR>
nnoremap <leader>pt :Telescope tags<CR>
nnoremap <leader>pg :Telescope current_buffer_fuzzy_find<CR>
nnoremap <leader>py :Telescope filetypes<CR>
nnoremap <leader>pu :Telescope lsp_document_symbols<CR>

nnoremap <leader>pi :Include<CR>
nnoremap <leader>pd :Telescope file_browser<CR>
" nnoremap <leader>po :FasdFile<CR>
" nnoremap <leader>pO :FasdDir<CR>
" nnoremap <leader>pC :FasdCWD<CR>

if PlugLoaded('telescope_frecency')
lua require "telescope".load_extension("frecency")
endif

endif

" ==== Compe =====
if PlugLoaded('compe')
set completeopt=menuone,noselect
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.resolve_timeout = 800
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.ultisnips = v:true

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm({'keys': '<CR>', 'select': 1})
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })
endif
" ----------------------

" Nvim LSP
if PlugLoaded('nvim_lspconfig')
lua << EOF
require'lspconfig'.rust_analyzer.setup{}
EOF

nnoremap <silent> gD <Cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gk <Cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gh <Cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gH <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> gt <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>

nnoremap <silent> <leader>cwa <cmd>lua vim.lsp.buf.add_workspace_folder()<CR>
nnoremap <silent> <leader>cwr <cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>
nnoremap <silent> <leader>cwl <cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>
nnoremap <silent> <leader>cr <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <leader>ca <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> <leader>ce <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
nnoremap <silent> <leader>c[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> <leader>c] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <silent> <leader>cd <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
nnoremap <silent> <leader>cf <cmd>lua vim.lsp.buf.formatting()<CR>
endif
" -------------------

"=========================
"  Key Mappings
"=========================

" Surround
if PlugLoaded('vim_surround')
nnoremap <leader>0 :normal ysiw)<CR>i
nnoremap yss :normal ysiw"<CR>
nnoremap ysS :normal ysiw'<CR>
nnoremap ysa :normal ysiW"<CR>
nnoremap ysA :normal ysiW'<CR>
endif

" VimSpector
if PlugLoaded('vimspector')
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
endif

" Switch to Layout / Maximize Pane
if PlugLoaded('nvim_maximize_window_toggle')
nnoremap <leader>m :ToggleOnly<CR>
nnoremap <M-Enter> :ToggleOnly<CR>
endif

if PlugLoaded('sideways')
" Move Arguments left or right
noremap <M-<> :SidewaysLeft<CR>
noremap <M->> :SidewaysRight<CR>
endif

" Misc Plugins
execute 'nnoremap <M-g> :Git '
noremap <M-/> :Commentary<CR>
nnoremap <leader>u :UndotreeToggle \| UndotreeFocus<CR>
nnoremap <M-o> :GotoHeaderSwitch<CR>
nnoremap Q :Bdelete menu<CR>
noremap <leader><C-s> :WriteSession<CR>


" ==== Native Mappings ====
" Clear the highlighting of :set hlsearch
nnoremap <silent> <leader>H :nohlsearch<cr>

" Save  File
nnoremap <C-s> :w<CR>
inoremap <C-s> <ESC>:w<CR>

" File /Buffer Operations
nnoremap <C-c> :echo 'ctrl-c thrice to quit'<CR>
nnoremap <C-c><C-c><C-c> :qall!<CR>
map <C-w> :bd<CR>
map <C-q> :q<CR>

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

" Split Lines
nnoremap S :execute 's/\('.nr2char(getchar()).'\)\ */\1\r/g' \| :nohl<CR>
nnoremap S/ :execute 's/\/\ */\/\r/g' \| :nohl<CR>
nnoremap SS :execute 's/\('.input("String to Split on").'\)\ */\1\r/g' \| :nohl<CR>

" ==== Windows and Panes ====
" Remap window prefix
map <C-x> <C-w>

" Pane Selection
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

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
noremap <M-]> :bn<CR>
noremap <M-[> :bp<CR>
nnoremap <S-Tab> <C-^>

"" Tabs
noremap <M-}> :tabn<CR>
noremap <M-{> :tabp<CR>
nnoremap <C-x>t :tab split<CR>
noremap <C-x>k :tabn<CR>
noremap <C-x>j :tabp<CR>

" Vimrc
nnoremap <leader>ev :tab split ~/.vimrc<cr>
nnoremap <leader>ez :tab split ~/.zshrc<cr>
nnoremap <leader>et :tab split ~/.tmux.conf<cr>

" ==== Insert Mode ====
" Paste
inoremap <C-v> <C-r>"
" Move to End of line
inoremap <C-e> <Esc>A
nnoremap <expr>A getline('.') == '' ? "A\<C-f>" : "A"

" Open / Close tags
inoremap <M-[> [<CR><CR>]<UP><C-f>
inoremap <M-{> {<CR><CR>}<UP><C-f>
inoremap <M-(> (<CR><CR>)<UP><C-f>
inoremap <M-"> ""<Left>
inoremap <M-'> ''<Left>

" ==== Command Mode ===
cnoremap <C-v> <C-r>"
cnoremap <M-v> <C-f>

" ==== Terminal Mode ===
cnoremap <C-j> <C-W>s<C-w><C-k>
cnoremap <C-k> <C-w>s<C-w><C-k>
cnoremap <C-l> <C-w>v<C-w><C-l>
cnoremap <C-h> <C-w>v<C-w><C-h>

" ==== Vim Command Overrides ====
" Command Prompt
noremap ; :<Up>
" End visual mode at bottom
vmap y ygv<Esc>
" X Does not go to clipboard
vnoremap x "_d
vnoremap X "_D
vnoremap X "_D
" silent search if wrap-around
map <silent> n n

" Easy Macros / Replacing
vmap gs "my/<C-R>m<CR>
vmap <M-Q> gsNqq
nmap <M-Q> viw<M-Q>
nnoremap <M-q> nzz@q

" === NVIM specific ===
if has('nvim')
" Terminal Escape
tnoremap <C-e> <C-\><C-n>
autocmd TermOpen * setlocal nonumber norelativenumber
endif

" ==== Misc ====
" Run Line in Vim
nnoremap yr yy:<C-r>"<CR>
" run line in shell
nnoremap yR yy:!<C-r>"<CR>
" Run Last Command
noremap <leader>r @:<CR>
" Select All
noremap <M-a> 1GVG
" Paste line with in middle
nnoremap <leader>sp "_r<Enter>PkJJ
" run Clang
nnoremap <leader>F :Clang<CR>

" ===================
" Custom Commands
" ===================
" Copy The Path of the file
command! CP :let @" = expand('%')

" Format Commands file
command! FormatClang silent execute '%!clang-format %'
command! FormatJson silent execute '%!python -m json.tool'

" ======= Functions ========
function! Cwd() abort
    let l:path = getcwd()
    let l:pattern = getenv("HOME")
    let l:new_path = substitute(l:path, l:pattern, "~", "g")
    return l:new_path
endfunction

" ========= Auto Commands ==============
augroup Cmds
    au!
    " Remove spaces at end of line
    autocmd BufWritePre * :%s/\s\+$//e
    " Make C++ file doxygen
    autocmd BufNewFile,BufRead *.h,*.cc   set syntax=cpp.doxygen
    " Make Quick fix Preview By default
    autocmd WinEnter * if &buftype == 'quickfix' | nnoremap <buffer><nowait><silent> <Enter> <Enter>:wincmd j<CR> | endif
augroup END


" ========================================
"  Quick UI menu
" ========================================
if PlugLoaded('vim_quickui')
noremap <leader><CR> :call quickui#menu#open()<CR>
nnoremap <leader>' ' :call quickui#tools#clever_context('k', g:context_menu_k, {})<cr>
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

" Folding
call quickui#menu#install("F&olding", [
            \ ["&Syntax\t(foldmethod)", ':setlocal foldmethod=syntax'],
            \ ["&Manual\t(foldmethod)", ':setlocal foldmethod=manual'],
            \ ["&Indent\t(foldmethod)", ':setlocal foldmethod=indent'],
            \ ["&Close All", ':setlocal foldlevel=0'],
            \ ["&Open All", ':setlocal foldlevel=99']
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
endif

" TreeSitter
if PlugLoaded('nvim_treesitter')
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


