"""""""""""""""""""
"  Master Vim RC  "
"""""""""""""""""""
"  Configuration {{{1
"  RC Configuration {{{2
let g:GIT_TOOLS = get(g:, 'GIT_TOOLS', 1)
let g:CPP_TOOLS = get(g:, 'CPP_TOOLS', 0)
let g:GUI_TOOLS = get(g:, 'GUI_TOOLS', 1)
let g:NVIM_TOOLS = get(g:, 'NVIM_TOOLS', 1)
let g:SNIPPETS = get(g:, 'SNIPPETS', 1)
let g:STATUS_LINE = get(g:, 'STATUS_LINE', 1)
let g:TMUX = get(g:, 'TMUX', 1) && exists("$TMUX")
let g:NERD_FONT = get(g:, 'NERD_FONT', 1)

" Light Weight Config
if exists('$VIM_LITE')
    let g:GIT_TOOLS = 1
    let g:CPP_TOOLS = 0
    let g:GUI_TOOLS = 0
    let g:NVIM_TOOLS = 0
    let g:SNIPPETS = 1
    let g:STATUS_LINE = 0
endif

" Nvim VSCode Plugin Options
if exists('g:vscode')
    let g:GIT_TOOLS = 0
    let g:CPP_TOOLS = 0
    let g:GUI_TOOLS = 0
    let g:NVIM_TOOLS = 0
    let g:SNIPPETS = 0
    let g:STATUS_LINE = 0
endif

"  Vim-Plug {{{2
" Install vim-plug if it doesnt exist
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin()
" Plugin Helpers
function! FormatPlugName(name) abort
    let l:name = a:name
    let l:name = substitute(l:name, "[-.]", '_', 'g')
    let l:name = substitute(l:name, "[',]", '', 'g')
    let l:name = substitute(l:name, "_nvim$", '', 'g')
    let l:name = substitute(l:name, "^nvim_", '', 'g')
    let l:name = substitute(l:name, "_vim$", '', 'g')
    let l:name = substitute(l:name, "^vim_", '', 'g')
    return l:name
endfunction
function! PlugLoaded(name) abort
    let l:name = FormatPlugName(a:name)
    return exists('g:plugin_'.l:name)
endfunction
function! PlugDef(...) abort
    let l:name = split(a:000[0], '/')[1]
    let l:name = FormatPlugName(l:name)
    if l:name =~ 'nvim' && !has('nvim')
        return
    endif

    execute 'Plug '.join(a:000)
    execute ('let g:plugin_'.l:name.' = 1')
endfunction
command! -nargs=+ PlugDef call PlugDef(<f-args>)

" ------------------------------------------------------------------
" Essentials
PlugDef 'easymotion/vim-easymotion'
PlugDef 'rhysd/clever-f.vim'
PlugDef 'bogado/file-line'
PlugDef 'machakann/vim-sandwich'

" GUI Essentials
PlugDef 'kshenoy/vim-signature' " Show Marks in Sidebar
PlugDef 'dstein64/nvim-scrollview'
PlugDef 'junegunn/fzf', { 'do': { -> fzf#install() } }
PlugDef 'junegunn/fzf.vim'

" Window Management
PlugDef 'caenrique/nvim-maximize-window-toggle'
PlugDef 'Asheq/close-buffers.vim'
PlugDef 'caenrique/nvim-toggle-terminal'

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

" Language Support
PlugDef 'MaxMEllon/vim-jsx-pretty'
PlugDef 'pangloss/vim-javascript',  { 'for': 'javascript' }
PlugDef 'elixir-editors/vim-elixir'
PlugDef 'rust-lang/rust.vim'
PlugDef 'MTDL9/vim-log-highlighting'
PlugDef 'plasticboy/vim-markdown'
PlugDef 'cespare/vim-toml'

" Appearance
" PlugDef 'Yggdroot/indentLine'
PlugDef 'lukas-reineke/indent-blankline.nvim'
PlugDef 'ryanoasis/vim-devicons'
PlugDef 'kyazdani42/nvim-web-devicons' " for file icons

" Color schemes
PlugDef 'sainnhe/sonokai'
PlugDef 'AlessandroYorba/Sierra'
PlugDef 'AlessandroYorba/Arcadia'
PlugDef 'AlessandroYorba/Despacio'
PlugDef 'AlessandroYorba/Breve'
PlugDef 'AlessandroYorba/Alduin'
PlugDef 'morhetz/gruvbox'

" ------------------------------------------------------------------
if g:GUI_TOOLS
PlugDef 'mbbill/undotree'
PlugDef 'yegappan/taglist'
PlugDef 'brooth/far.vim' " Find & Replace
PlugDef 'skywind3000/vim-quickui'
PlugDef 'liuchengxu/vim-which-key'
PlugDef 'kyazdani42/nvim-tree.lua'
PlugDef 'simrat39/symbols-outline.nvim'
PlugDef 'mhinz/vim-startify'
endif

" ------------------------------------------------------------------
if g:NVIM_TOOLS
" TreeSitter
PlugDef 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
PlugDef 'p00f/nvim-ts-rainbow'

" compe
PlugDef 'hrsh7th/nvim-compe'
PlugDef 'tzachar/compe-tabnine', { 'do': './install.sh' }

" Telescope
PlugDef 'nvim-lua/popup.nvim'
PlugDef 'nvim-lua/plenary.nvim'
PlugDef 'nvim-telescope/telescope.nvim'

" Frecency
PlugDef 'tami5/sql.nvim'
PlugDef 'nvim-telescope/telescope-frecency.nvim'

" LSP Config
PlugDef 'RishabhRD/popfix'
PlugDef 'RishabhRD/nvim-lsputils'
PlugDef 'neovim/nvim-lspconfig'

" Clap
PlugDef 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }
PlugDef 'goolord/nvim-clap-lsp'
endif
" ------------------------------------------------------------------
if g:GIT_TOOLS
PlugDef 'tpope/vim-fugitive'
PlugDef 'airblade/vim-gitgutter'
PlugDef 'rhysd/conflict-marker.vim'
endif
" ------------------------------------------------------------------
" Hardcore C++ tools
if g:CPP_TOOLS
PlugDef 'puremoLheurning/vimspector'
PlugDef 'gauteh/vim-cppman'
endif
" ------------------------------------------------------------------
" Tmux Integration
if g:TMUX
PlugDef 'christoomey/vim-tmux-navigator'
PlugDef 'roxma/vim-tmux-clipboard'
endif
" ------------------------------------------------------------------
" Snippets
if g:SNIPPETS
PlugDef 'SirVer/ultisnips'
PlugDef 'honza/vim-snippets'
endif
" ------------------------------------------------------------------
" " Status bar
if g:STATUS_LINE
PlugDef 'hoob3rt/lualine.nvim'
PlugDef 'pacha/vem-tabline'

endif

" ------------------------------------------------------------------
" Sandbox
PlugDef 'xolox/vim-notes'
PlugDef 'rose-pine/neovim'
PlugDef 'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim'

" Colorschemes {{{3
PlugDef 'rafamadriz/neon'
PlugDef 'tomasiser/vim-code-dark'
PlugDef 'marko-cerovac/material.nvim'
PlugDef 'bluz71/vim-nightfly-guicolors'
PlugDef 'bluz71/vim-moonfly-colors'
PlugDef 'ChristianChiarulli/nvcode-color-schemes.vim'
PlugDef 'folke/tokyonight.nvim'
PlugDef 'sainnhe/sonokai'
PlugDef 'kyazdani42/blue-moon'
PlugDef 'mhartington/oceanic-next'
PlugDef 'Iron-E/nvim-highlite'
PlugDef 'glepnir/zephyr-nvim'
PlugDef 'rockerBOO/boo-colorscheme-nvim'
PlugDef 'jim-at-jibba/ariake-vim-colors'
PlugDef 'Th3Whit3Wolf/onebuddy'
PlugDef 'RishabhRD/nvim-rdark'
PlugDef 'ishan9299/modus-theme-vim'
PlugDef 'sainnhe/edge'
PlugDef 'theniceboy/nvim-deus'
PlugDef 'bkegley/gloombuddy'
PlugDef 'Th3Whit3Wolf/one-nvim'
PlugDef 'PHSix/nvim-hybrid'
PlugDef 'Th3Whit3Wolf/space-nvim'
PlugDef 'yonlu/omni.vim'
PlugDef 'ray-x/aurora'
PlugDef 'novakne/kosmikoa.nvim'
PlugDef 'tanvirtin/monokai.nvim'
PlugDef 'nekonako/xresources-nvim'
PlugDef 'savq/melange'
PlugDef 'RRethy/nvim-base16'
PlugDef 'fenetikm/falcon'
PlugDef 'maaslalani/nordbuddy'
PlugDef 'shaunsingh/nord.nvim'
PlugDef 'MordechaiHadad/nvim-papadark'
PlugDef 'ishan9299/nvim-solarized-lua'
PlugDef 'shaunsingh/moonlight.nvim'
PlugDef 'navarasu/onedark.nvim'
PlugDef 'lourenci/github-colors'
PlugDef 'sainnhe/gruvbox-material'
PlugDef 'sainnhe/everforest'
PlugDef 'NTBBloodbath/doom-one.nvim'
PlugDef 'dracula/vim'
PlugDef 'yashguptaz/calvera-dark.nvim'
PlugDef 'nxvu699134/vn-night.nvim'
PlugDef 'adisen99/codeschool.nvim'
PlugDef 'projekt0n/github-nvim-theme'
PlugDef 'kdheepak/monochrome.nvim'
PlugDef 'rose-pine/neovim'
PlugDef 'EdenEast/nightfox.nvim'
"
call plug#end() "

" =========================
"  General Settings {{{1
" ----------------------
"
"  Appearance {{{2
" Available values: `'default'`, `'atlantis'`, `'andromeda'`, `'shusia'`, `'maia'`, `'espresso'`
let g:sonokai_style = 'andromeda'
let g:sonokai_enable_italic = 0
let g:sonokai_disable_italic_comment = 0

let g:arcadia_Sunset = 1
let g:arcadia_Pitch = 1
let g:nightfox_style = 'nightfox'

" colorscheme sonokai
colorscheme nightfox
" colorscheme arcadia
" colorscheme fahrenheit
" colorscheme gruvbox

"  Vim Settings {{{2
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
set wildmode=full
set wildchar=<Tab>
set foldlevel=99
set cursorline
set hidden
set noshowmode
set iskeyword=@,48-57,_,192-255,=,~,*,!
set termguicolors
set fillchars=vert:\│,eob:\ " Space
set scrolloff=3 " Keep 3 lines below and above the cursor

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

" Map key
let mapleader=" "

"  Programs {{{2
" Use ag if it exists
if executable('rg')
    " Use rg over grep
    set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
elseif executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
endif

" Use 3.8 if exists
if executable('python3.8')
let g:python3_host_prog = 'python3.8'
endif

if exists(':GuiFont')
GuiFont FuraMono NF:h11
endif

"  Toggle Settings {{{2
function Toggle_setting(name)
exe "set ".a:name."!"
exe "echo '".a:name." =' &".a:name." ? 'on' : 'off'"
endfunction

let setting_cycles = {
            \ "foldmethod": ['manual', 'marker', 'expr', 'syntax']
            \ }

function Cycle_setting(name)
let next = g:setting_cycles[a:name][0]
let g:setting_cycles[a:name] = g:setting_cycles[a:name][1:] + [l:next]
exe "set ".a:name."=".l:next
echo a:name.' = '.l:next
endfunction

" Setting Toggles
noremap <leader>7w <cmd>call Toggle_setting("wrap")<CR>
noremap <leader>7n <cmd>call Toggle_setting("number")<CR>
noremap <leader>7f <cmd>call Cycle_setting("foldmethod")<CR>
" ------------------------------------------------------------------

"=========================
"   Plugin Settings {{{1
"-------------------------
" Far {{{2
if PlugLoaded('far')
let g:far#source='rgnvim'
endif

" Vim Printer {{{2
let g:vim_printer_print_below_keybinding = '<leader>xc'
let g:vim_printer_print_above_keybinding = '<leader>xC'
let g:vim_printer_items = {
            \ 'javascript': 'console.log("{$}:", {$})',
            \ 'python': 'print("{$}:", {$})',
            \ 'cpp': 'info(0) << "{$}:" << {$} << std::endl;',
            \ }
"

"====== Nvim Tree ======== {{{2
if PlugLoaded('nvim_tree_lua')
noremap <leader>\ :NvimTreeToggle<CR>
noremap <leader>\| :NvimTreeFindFile<CR>
noremap <leader>!p :call TogglePicker()<CR>

let g:nvim_tree_hijack_netrw = 1
let g:nvim_tree_disable_window_picker = 1
let g:nvim_tree_highlight_opened_files = 1
let g:nvim_tree_git_hl = 1
let g:nvim_tree_update_cwd = 1

function TogglePicker()
let g:nvim_tree_disable_window_picker =  1 - g:nvim_tree_disable_window_picker
endfunction

endif

" ====== Which Key ======= {{{2
if PlugLoaded('which_key')
noremap <silent> <leader> :WhichKey ' '<CR>
let g:which_key_map =  {}
let g:which_key_map.p = { 'name' : '+fuzzy' }
let g:which_key_map.c = { 'name' : '+coc' }
let g:which_key_map.d = { 'name' : '+vimspector' }
let g:which_key_map.e = { 'name' : '+edit' }
let g:which_key_map.g = { 'name' : '+git' }
let g:which_key_map.x = { 'name' : '+extension' }
let g:which_key_map['1'] = { 'name' : '+toggle' }
let g:which_key_map.W = { 'name' : '+WhichKey' }

call which_key#register('<Space>', "g:which_key_map")

" Show Help for char
noremap <leader>W <cmd>execute 'WhichKey "'.nr2char(getchar()).'"'<CR>
endif

"==== Startify ==== {{{2
if PlugLoaded('startify')
let g:startify_change_to_dir = 0
let g:startify_session_dir = '~/.vim/sessions'
let g:startify_bookmarks = ["~/repos/sims/pythia/src",
            \ "~/dot/.vimrc",
            \ "~/dot/",
            \ "~/repos/sims",
            \ "~/.vimrc",
            \ ]

let g:startify_lists = [
            \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
            \ { 'type': 'sessions',  'header': ['   Sessions']       },
            \ { 'type': 'files',     'header': ['   Recent Files']            },
            \ { 'type': 'dir',       'header': ['   Recent from '. getcwd()] },
            \ { 'type': 'commands',  'header': ['   Commands']       },
            \ ]

endif
" =================


"==== Conflict Marker ==== {{{2
if PlugLoaded('conflict_marker')
let g:conflict_marker_enable_mappings = 1
highlight ConflictMarkerBegin guibg=#2f7366
highlight ConflictMarkerOurs guibg=#2e5049
highlight ConflictMarkerTheirs guibg=#344f69
highlight ConflictMarkerEnd guibg=#2f628e
highlight ConflictMarkerCommonAncestorsHunk guibg=#754a81
endif

"==== Git Gutter ==== {{{2
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

" Cool symbols
if g:NERD_FONT
    let g:gitgutter_sign_removed_first_line = ''
    let g:gitgutter_sign_removed_above_and_below = ''
    let g:gitgutter_sign_modified_removed = ''
endif
endif

"===== EasyMotion ======== {{{2
if PlugLoaded('easymotion')
let g:EasyMotion_keys='asdfgtrebvcwqxzyuionmpASDFGHlkjh'
map <leader>f <Plug>(easymotion-bd-f)
map <leader>S <Plug>(easymotion-bd-f2)
map <leader>s <Plug>(easymotion-bd-w)

map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)
endif

" Vimux {{{2
if PlugLoaded('toggle_terminal')
noremap <silent> <M-`> :ToggleTerminal<CR>
tnoremap <silent> <M-`> <C-\><C-n>:ToggleTerminal<CR>
noremap <silent> <M-t> :ToggleTerminal<CR>
tnoremap <silent> <M-t> <C-\><C-n>:ToggleTerminal<CR>
endif


" Fuzzy Commands {{{2
command! Fuzzy         Clap
command! FuzzyFiles    Clap files .
command! FuzzyFilesR   Clap
command! FuzzyCom      Clap command
command! FuzzyComR     Clap command_history
command! FuzzyQF       Clap quickfix
command! FuzzyFindFile Clap quickfix
command! FuzzyFindAll  Telescope live_grep

" Fuzzy Mappings {{{3
" "Search Word
nnoremap gw <cmd>silent exe("grep! ".expand("<cword>")) \| FuzzyQF <CR>
vnoremap gw "my:silent exe("grep! ".@m) \| FuzzyQF <CR>
nnoremap <M-f> <cmd>execute('silent grep "'.input('Search For: ').'" \| FuzzyQF ')<CR>
nnoremap <M-F> <cmd>FuzzyFindAll<CR>

nnoremap <C-p> <cmd>FuzzyFiles<cr>
nnoremap <M-p> <cmd>FuzzyFilesR<cr>
nnoremap <M-r> <cmd>FuzzyComR<cr>
nnoremap <M-R> <cmd>FuzzyCom<cr>
nnoremap <M-e> <cmd>Fuzzy<cr>

" ==== Telescope ========= {{{3
if PlugLoaded('telescope_nvim')

lua << EOF
require('telescope').setup{
    defaults = {
        borderchars = {"─", "│", "─", "│", "┌", "┐", "┘", "└"},
        layout_strategy = "vertical",
    }
}
EOF

nnoremap <leader>p  <cmd>Telescope<cr>
nnoremap <leader>pp <cmd>Telescope find_files<cr>
nnoremap <leader>pc :Telescope commands<CR>
nnoremap <leader>pC :Telescope command_history<CR>
nnoremap <leader>ph :Telescope oldfiles<CR>
nnoremap <leader>pH :Telescope frecency<CR>
nnoremap <leader>pB :Telescope file_browser<CR>
nnoremap <leader>pb :Telescope buffers<CR>
nnoremap <leader>pa :Telescope current_buffer_tags<CR>
nnoremap <leader>pt :Telescope tags<CR>
nnoremap <leader>pg :Telescope current_buffer_fuzzy_find<CR>
nnoremap <leader>py :Telescope filetypes<CR>
nnoremap <leader>pu :Telescope lsp_document_symbols<CR>

if PlugLoaded('telescope_frecency')
lua require "telescope".load_extension("frecency")
endif
endif

" Fzf {{{3
if PlugLoaded('fzf')
" Use tmux FZF if tmux exists
if g:TMUX
    let g:fzf_layout = { 'tmux': '-p80%,60%' }
else
    let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
endif

" FZF Custom Scripts
nnoremap <leader>pi :Include<CR>
nnoremap <leader>po :FasdFile<CR>
nnoremap <leader>pO :FasdDir<CR>
nnoremap <leader>pz :FzfCd<CR>
nnoremap <leader>pZ :FzfCdIter<CR>

" FZF QuickFix
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
endif

" Clap {{{3
if PlugLoaded('clap')
" let g:clap_layout={ 'width': '80%', 'height': '33%', 'row': '33%', 'col': '0%' }
let g:clap_layout = { 'relative': 'editor' }
let g:clap_preview_direction = 'UD'

if PlugLoaded('compe')
autocmd FileType clap_input call compe#setup({ 'enabled': v:false }, 0)
endif

lua << EOF
vim.lsp.handlers['textDocument/codeAction']     = require'clap-lsp.codeAction'.code_action_handler
vim.lsp.handlers['textDocument/definition']     = require'clap-lsp.locations'.definition_handler
vim.lsp.handlers['textDocument/documentSymbol'] = require'clap-lsp.symbols'.document_handler
vim.lsp.handlers['textDocument/references']     = require'clap-lsp.locations'.references_handler
vim.lsp.handlers['workspace/symbol']            = require'clap-lsp.symbols'.workspace_handler
EOF
endif

" ==== Compe ===== {{{2
if PlugLoaded('compe')
set completeopt=menuone,noselect
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 150
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
let g:compe.source.tabnine = v:true

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>     compe#confirm({'keys': '<CR>', 'select': 1})
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })
inoremap <silent> <M-CR> <CR>
endif
" ------------------------------------------------------------------

" Nvim LSP {{{2
if PlugLoaded('nvim_lspconfig')
lua << EOF
require'lspconfig'.rust_analyzer.setup{}
require'lspconfig'.clangd.setup{}
require'lspconfig'.pyright.setup{}
EOF

nnoremap <silent> gD <Cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gk <Cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gh <Cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gH <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> gt <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gy <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gY <cmd>lua vim.lsp.buf.workspace_symbol()<CR>


nnoremap <silent> <leader>cwa <cmd>lua vim.lsp.buf.add_workspace_folder()<CR>
nnoremap <silent> <leader>cwr <cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>
nnoremap <silent> <leader>cwl <cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>
nnoremap <silent> <leader>cr <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <leader>ca <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> <leader>ce <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
nnoremap <silent> <leader>c[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> <leader>c] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <silent> [c <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> ]c <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <silent> <leader>cd <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
nnoremap <silent> <leader>cf <cmd>lua vim.lsp.buf.formatting()<CR>


nmap <leader>1cu <Plug>(toggle-lsp-diag-underline)
nmap <leader>1cs <Plug>(toggle-lsp-diag-signs)
nmap <leader>1cv <Plug>(toggle-lsp-diag-vtext)
nmap <leader>1cp <Plug>(toggle-lsp-diag-update_in_insert)
nmap <leader>1ca  <Plug>(toggle-lsp-diag)
endif

" ===== LSPUtil ===== {{{2
if PlugLoaded('lsputils')
" lua <<EOF
" vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
" vim.lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler
" vim.lsp.handlers['textDocument/definition'] = require'lsputil.locations'.definition_handler
" vim.lsp.handlers['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
" vim.lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
" vim.lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
" vim.lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
" vim.lsp.handlers['workspace/symbol'] = require'lsputil.symbols'.workspace_handler
" EOF
endif

" ===== Lua Line =====
if PlugLoaded('lualine')

function! NumL ()
    return system:"('$')
endfunction
function! GetTime ()
    return trim(system('date +"%I:%m"'))
endfunction

function! GetDate ()
    if exists("$TMUX")
        return ''
    else
        return trim(system('date +"%I:%m%P %a %m/%d" | sed -e "s/ 0/ /" -e "s/^0//"'))
    endif
endfunction

lua  << EOF
local Map = {}
if vim.g.NERD_FONT then
Map = {
  ['n']    = '',
  ['v']    = '濾',
  ['V']    = '濾',
  ['']   = '礪',
  ['s']    = 's',
  ['S']    = 'S',
  ['']   = 'S',
  ['i']    = '',
  ['R']    = 'r',
  ['c']    = '',
  ['cv']   = 'X',
  ['ce']   = 'X',
  ['r']    = 'r',
  ['rm']   = 'more',
  ['r?']   = '',
  ['!']    = '',
  ['t']    = '',
}
else
Map = {
  ['']   = 'v',
  ['']   = 's',
  ['i']    = 'i',
  ['R']    = 'r',
  ['c']    = ':',
  ['cv']   = 'X',
  ['ce']   = 'X',
  ['r']    = 'r',
  ['rm']   = 'more',
  ['r?']   = '?',
  ['t']    = '>',
}
end

function get_mode()
  local m = vim.api.nvim_get_mode().mode
  local f = m.sub(m, 1, 1)
  if Map[m] ~= nil then return Map[m] end
  if Map[f] ~= nil then return Map[f] end
  return m
end

require'lualine'.setup{
    options = {
        theme = 'auto',
    },
    sections = {
        lualine_a = {get_mode},
        lualine_b = {''},
        lualine_c = {'filename'},

        lualine_x = {'Cwd'},
        lualine_y = {'branch', 'GetDate'},
        lualine_z = {'GetTime', 'NumL', 'diagnostics'},
    }
}
EOF
endif
" ==== Lua Line End ====


" ==== CleverF ===== {{{2
if PlugLoaded('clever_f')
let g:clever_f_not_overwrites_standard_mappings = 1
function! MapCleverF()
    nmap f <Plug>(clever-f-f)
    xmap f <Plug>(clever-f-f)
    omap f <Plug>(clever-f-f)
    nmap F <Plug>(clever-f-F)
    xmap F <Plug>(clever-f-F)
    omap F <Plug>(clever-f-F)
    nmap t <Plug>(clever-f-t)
    xmap t <Plug>(clever-f-t)
    omap t <Plug>(clever-f-t)
    nmap T <Plug>(clever-f-T)
    xmap T <Plug>(clever-f-T)
    omap T <Plug>(clever-f-T)
endfunction
call MapCleverF()
endif

" ==== Multiple Cursors ==== {{{2
if PlugLoaded("vim_multiple_cursors")
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_start_word_key      = '<A-d>'
let g:multi_cursor_select_all_word_key = '<A-D>'
let g:multi_cursor_next_key            = '<A-d>'
let g:multi_cursor_prev_key            = '<A-n>'
let g:multi_cursor_skip_key            = '<A-m>'
let g:multi_cursor_quit_key            = '<Esc>'

function! Multiple_cursors_before()
    if PlugLoaded('clever_f')
        nunmap f
        xunmap f
        ounmap f
        nunmap F
        xunmap F
        ounmap F
        nunmap t
        xunmap t
        ounmap t
        nunmap T
        xunmap T
        ounmap T
    endif
endfunction

function! Multiple_cursors_after()
    if PlugLoaded('clever_f')
        call MapCleverF()
    endif
endfunction
endif

" ==== Smoothie ==== {{{2
if PlugLoaded("smoothie")
" let g:smoothie_speed_exponentiation_factor = 1.3
let g:smoothie_speed_constant_factor = 20
let g:smoothie_no_default_mappings = 1
nmap <unique> <c-d>      <Plug>(SmoothieDownwards)
nmap <unique> <c-u>      <Plug>(SmoothieUpwards)
nmap <unique> <C-f>      <Plug>(SmoothieForwards)
nmap <unique> <C-b>      <Plug>(SmoothieBackwards)
endif


" ==== TreeSitter ==== {{{2
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
        enable = true,
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "gnm",
    },
    rainbow = {
        enable = true,
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
        colors = {
            "#cc241d",
            "#a89984",
            "#b16286",
            "#d79921",
            "#689d6a",
            "#d65d0e",
            "#458588",
            }, -- table of hex strings
        termcolors = {
            'Red',
            'Green',
            'Yellow',
            'Blue',
            'Magenta',
            'Cyan',
            'White',
            } -- table of colour name strings
        }
    }
EOF
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

" Incremental Selection
nmap <A-s> gnn
vmap <A-s> grn
vmap <A-S> grm
endif

" Interesting Words {{{2
let g:interestingWordsDefaultMappings = 0
let g:interestingWordsRandomiseColors = 1
nnoremap <silent> <leader>xi :call InterestingWords('n')<cr>
vnoremap <silent> <leader>xi :call InterestingWords('v')<cr>
nnoremap <silent> <leader>xI :call UncolorAllWords()<cr>

" Sandwich {{{2
if PlugLoaded('vim_sandwich')
nnoremap sf :normal saiwf<CR>
nnoremap sF :normal saiWf<CR>
nnoremap sw' :normal saiw'<CR>
nnoremap sw" :normal saiw"<CR>
nnoremap sw( :normal saiw(<CR>
nnoremap sw< :normal saiw<<CR>
nnoremap sw[ :normal saiw[<CR>
nnoremap sw{ :normal saiw{<CR>

let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)

nnoremap sdc :normal srb(sdf<CR>
nnoremap src :normal srb(srff<CR>:normal srb<<CR>
nnoremap sac :normal saiwf<CR>:normal srb<<CR>
nnoremap saC :normal saiWf<CR>:normal srb<<CR>
endif

" VimSpector {{{2
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

" Switch to Layout / Maximize Pane {{{2
if PlugLoaded('nvim_maximize_window_toggle')
nnoremap <leader>m :ToggleOnly<CR>
nnoremap <M-Enter> :ToggleOnly<CR>
endif

if PlugLoaded('sideways') " {{{2
" Move Arguments left or right
noremap <M-<> :SidewaysLeft<CR>
noremap <M->> :SidewaysRight<CR>
endif

" ==== Custom 'Plugins' ===== {{{2
" Copy To Other Window {{{3
if 1
function! CopyOther() abort
    let l:buffer = bufnr()
    let l:line = line('.')
    let l:col = col('.')
    call win_gotoid(win_getid(max([3 - winnr(), 1])))
    exe 'buffer '.l:buffer
    call cursor(l:line, l:col)
endfunction
command! CopyOther :call CopyOther()

noremap <C-x>c <cmd>CopyOther<CR>
nnoremap gF :call CopyOther() \| norm gf<CR>
nnoremap gK :call CopyOther() \| norm gk<cr>
endif

if executable('how2') " {{{3
nnoremap <leader>xh :execute("vsplit \| term how2 -l ".&filetype." ".expand("<cword>"))<CR>
nnoremap <leader>xH :execute("vsplit \| term how2 -l ".&filetype." ".input("Search Stack Overflow: "))<CR>
nnoremap <leader>x<m-h> :call system("tmux popup how2 -l ".&filetype." ".expand("<cword>"))<CR>
nnoremap <leader>x<m-H> :call system("tmux popup how2 -l ".&filetype." ".input("Search Stack Overflow: "))<CR>

command! -nargs=+ StackOverflow exe "term how2 -l ".&filetype." ".<q-args>
endif

" Git Patch {{{3
if 1
function! CommitQF()
    " Get the result of git show in a list
    let flist = system('git diff --name-only HEAD | tail -n +7')
    let flist = split(flist, '\n')

    " Create the dictionnaries used to populate the quickfix list
    let list = []
    for f in flist
        let dic = {'filename': f, "lnum": 1}
        call add(list, dic)
    endfor

    " Populate the qf list
    call setqflist(list)
endfunction

nnoremap <leader>xg <cmd>GitPatch<CR>
nnoremap <leader>xG <cmd>call CommitQF()<CR>
endif

" Next Fold {{{3
if 1
function! NextClosedFold(dir)
    let cmd = 'norm!z' . a:dir
    let view = winsaveview()
    let [l0, l, open] = [0, view.lnum, 1]
    while l != l0 && open
        exe cmd
        let [l0, l] = [l, line('.')]
        let open = foldclosed(l) < 0
    endwhile
    if open
        call winrestview(view)
    endif
endfunction

nnoremap <silent> [Z :call NextClosedFold('k')<cr>
nnoremap <silent> ]Z :call NextClosedFold('j')<cr>
endif

" ------------------------------------------------------------------
" Misc PLugins {{{2
let g:session_autosave='yes'
let g:session_autosave_periodic=3
let g:session_autoload='no'
let g:interestingWordsDefaultMappings = 0
let g:indentLine_char = '▏'
let g:autoload_session = 0
let g:UltiSnipsExpandTrigger="<M-u>"

execute 'nnoremap <M-g> :Git '
nnoremap <M-o> :ClangdSwitchSourceHeader<CR>
nnoremap <M-u> :SymbolsOutline<CR>
nnoremap <leader>u :UndotreeToggle \| UndotreeFocus<CR>
nnoremap Q :Bdelete menu<CR>
noremap <M-/> :Commentary<CR>

" ------------------------------------------------------------------
"  Mappings {{{1
" Clear the highlighting of :set hlsearch
nnoremap <silent> <leader>H :nohlsearch<cr>

" Save  File
nnoremap <C-s> <cmd>w<CR>
inoremap <C-s> <ESC><cmd>w<CR>

" File /Buffer Operations
nnoremap <C-c> <cmd>echo 'ctrl-c thrice to quit'<CR>
nnoremap <C-c><C-c><C-c> <cmd>qall!<CR>
noremap <nowait> <C-w> <cmd>bd<CR>
noremap <M-w> <cmd>close<CR>
noremap <C-q> <cmd>q<CR>

if PlugLoaded('scrollview')
command! Buffdelete  silent! ScrollViewDisable  \| bdelete  \| silent! ScrollViewEnable
noremap <silent> <C-w> <cmd>Buffdelete<CR>
endif

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

" Split Lines
nnoremap S :execute 's/\('.nr2char(getchar()).'\)\ */\1\r/g' \| :nohl<CR>
nnoremap S/ :execute 's/\/\ */\/\r/g' \| :nohl<CR>
nnoremap SS :execute 's/\('.input("String to Split on").'\)\ */\1\r/g' \| :nohl<CR>

" ==== Windows and Panes ==== {{{2
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

" Arrow Keys for B movement
nnoremap <left> <cmd>bprev<cr>
nnoremap <right> <cmd>bnext<cr>
nnoremap <up> <cmd>tabprev<cr>
nnoremap <down> <cmd>tabnext<cr>

" Better Buffers
if PlugLoaded('vem_tabline')
nmap <M-Left> <Plug>vem_move_buffer_left-
nmap <M-Right> <Plug>vem_move_buffer_right-
nmap <Left> <Plug>vem_prev_buffer-
nmap <Right> <Plug>vem_next_buffer-
endif

"" Tabs
noremap <M-}> :tabn<CR>
noremap <M-{> :tabp<CR>
nnoremap <C-x>t :tab split<CR>
noremap <C-x>k :tabn<CR>
noremap <C-x>j :tabp<CR>

" QuickFix Managing
nnoremap <silent> <leader>qo <cmd>copen<CR>
nnoremap <silent> <leader>qc <cmd>cclose<CR>
nnoremap <silent> <leader>qq <cmd>copen<CR>
nnoremap <silent> <leader>qx <cmd>call setqflist([], 'r')<CR>

" Vimrc
nnoremap <leader>ev :tab split ~/.vimrc<cr>
nnoremap <leader>ez :tab split ~/.zshrc<cr>
nnoremap <leader>et :tab split ~/.tmux.conf<cr>

" Incrementing
vnoremap <C-g> g<C-a>
nnoremap <A-8> <C-a>
nnoremap <A-7> <C-x>

" ==== Insert Mode ====
" Paste
inoremap <C-v> <C-r>"
" Move to End of line
inoremap <C-e> <Esc>A
nnoremap <expr>A getline('.') == '' ? "A<C-f>" : "A"

" Open / Close tags
inoremap <M-{> {<CR><CR>}<UP><C-f>
inoremap <M-[> []<Left>
inoremap <M-(> ()<Left>
inoremap <M-"> ""<Left>
inoremap <M-'> ''<Left>

" ==== Command Mode ==== {{{2
cnoremap <C-v> <C-r>"
cnoremap <M-v> <C-f>

cnoremap <C-j> <C-W>s<C-w><C-k>
cnoremap <C-k> <C-w>s<C-w><C-k>
cnoremap <C-l> <C-w>v<C-w><C-l>
cnoremap <C-h> <C-w>v<C-w><C-h>

" ==== Vim Command Overrides ==== {{{2
" Move to end of line easy
nnoremap H ^
nnoremap L $

" Command Prompt
noremap ; :<Up>

" End visual mode at bottom
vmap y ygv<Esc>

" X Does not go to clipboard
vnoremap x "_d
vnoremap X "_D
vnoremap X "_D

" silent search if wrap-around enabled
map <silent> n n

" Asterisk is hard
nnoremap gs *
vnoremap gs *

" Easy Macros / Replacing
vmap <M-Q> gsNqq
nmap <M-Q> viw<M-Q>
nnoremap <M-q> nzz@q

" === Terminal Maps === {{{2
if has('nvim')
tnoremap <C-e> <C-\><C-n>
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-l> <C-\><C-n><C-w>l
tnoremap <C-h> <C-\><C-n><C-w>h

nnoremap <silent> <leader>t <cmd>vsplit \| wincmd l \| term<CR>
nnoremap <silent> <leader>T <cmd>split \| wincmd j \| resize 10 \|term<CR>
tnoremap <silent> <M-CR> <C-\><C-n>:ToggleOnly<CR>A

augroup TerminalCmd
au!
autocmd TermOpen * setlocal nonumber norelativenumber
autocmd TermOpen * normal i
autocmd BufEnter * if bufname() =~ '^term://' | exe 'normal A' | endif
augroup END
endif

" ==== Misc ==== {{{2
" Run Line in Vim
autocmd FileType vim nnoremap <buffer> yr yy:<C-r>"<CR>
" run line in shell
nnoremap yR yy:!<C-r>"<CR>
" Run Last Command
noremap <leader>r @:<CR>
" Select All
noremap <M-a> 1GVG
" Paste line with in middle
nnoremap <leader>xp "_r<Enter>PkJJ
" run Clang
nnoremap <leader>F :FormatClang<CR>
" Easy Semicolon
nnoremap <silent> <M-;> mmA;<esc>`mmm

" ------------------------------------------------------------------
" ===================
"  Commands {{{1
" ===================
" Copy The Path of the file
command! CP :let @" = expand('%')
command! CdFile cd %:p:h
command! CdGit exe 'cd '.finddir('.git', '.;').'/../'

" Change Dir
nnoremap <leader>Cf <cmd>CdFile<CR>
nnoremap <leader>Cg <cmd>CdGit<CR>

" Grep
command! -nargs=1 Grep silent grep <q-args> | copen
command! -nargs=+ Find silent grep <q-args> | copen

" Format Commands file
command! FormatClang silent execute '%!clang-format %'
command! FormatJson silent execute '%!python -m json.tool'

" FZF / Fasd Commands
if PlugLoaded('fzf')

" Run FZF With Defaults
function! Fzf(dict)
call fzf#run(extend(copy({
            \ 'tmux': '-p80%,80%',
            \ 'options': '--preview="bat -p --color=always {}"'
            \ }), a:dict))
endfunction

command! FasdFile call Fzf({'source': 'fasd -lf', 'sink': 'e'})
command! FasdDir call Fzf({'source': 'fasd -ld', 'sink': 'cd', 'options': '--preview="exa --tree -L 2 {}"'})
command! Include call Fzf({'source': 'fd "\.h$"', 'sink': function('Include')}))
command! FzfCd call FzfCd()
command! FzfCdIter call FzfCdIter()
endif

"  Functions {{{1
function! Cwd() abort
    let l:path = getcwd()
    let l:pattern = getenv("HOME")
    let l:new_path = substitute(l:path, l:pattern, "~", "g")
    return l:new_path
endfunction

"  Auto Commands {{{1
augroup Cmds
    au!
    " Remove spaces at end of line
    autocmd BufWritePre * :%s/\s\+$//e
    " Make C++ file doxygen
    autocmd BufNewFile,BufRead *.h,*.cc   set syntax=cpp.doxygen | set colorcolumn=120
    " Make Quick fix Preview By default
    autocmd WinEnter * if &buftype == 'quickfix' | nnoremap <buffer><nowait><silent> <Tab> <Enter>:wincmd j<CR> | endif
    autocmd BufRead *.cc,*.h setlocal bufhidden=delete
    autocmd BufModifiedSet,BufWrite *.cc,*.h setlocal bufhidden=hide
    autocmd BufRead * setlocal iskeyword-=<
    autocmd BufRead * setlocal iskeyword-=>
    autocmd BufRead * setlocal iskeyword-=:
    autocmd BufRead * setlocal iskeyword-=]
    autocmd BufRead * setlocal iskeyword-=[
    autocmd BufRead * nnoremap <buffer> <nowait> <c-w> <cmd>Buffdelete<CR>
    autocmd BufRead * if &filetype == 'vim' | nmap <buffer> gh :exe 'help '.expand('<cword>')<CR> | endif
augroup END

" ==== Fzf Functions ==== {{{2
" Easy way to Include c++ files
function! Include(file, ...) abort
    let l:file = a:file
    " let l:file = trim(system("fd '\.h$' | fzf-tmux -p --preview='prev {}'"))

    if l:file == ""
        return
    endif

    let l:root = trim(system("git rev-parse --show-toplevel"))
    let l:fullpath = trim(system("realpath --relative-to=".l:root." ".l:file))
    let l:include = '#include "'.l:fullpath.'"'
    exe "normal! o" . l:include . "\<Esc>"
endfunction

" Nerd Tree into Folder {{{3
function! FzfCd() abort
    let l:options = "../\n".trim(system("fd -t d"))
    let l:file = trim(system("echo '".l:options."' | fzf-tmux -p --reverse --preview='prev {}'"))
    if l:file == ""
        return
    endif

    let l:root = trim(system("git rev-parse --show-toplevel"))
    let l:fullpath = trim(system("realpath ".l:file))

    execute "cd ".l:fullpath
    execute "NvimTreeRefresh"
endfunction

function! FzfCdIter() abort " {{{3
    let l:path = './'
    while 1
        let l:cmd = "fd --prune --base-directory=".l:path." -t d ."

        let l:choices = ''
        let l:choices .= '../\n'
        let l:choices .= '<open>\n'
        let l:choices .= trim(system(cmd))

        if l:choices == ''
            break
        endif
        let l:result = trim(system("echo '".l:choices."' | fzf-tmux -p --reverse --preview='prev ".l:path."/{}'"))

        if l:result == '<open>'
            break
        endif

        if l:result == ''
            return
        endif

        let l:path = l:path.l:result.'/'
    endwhile

    if l:path == './'
        return
    endif

    execute "cd ".l:path
    execute "NvimTreeRefresh"
endfunction

function! Replace() abort
    let l:text = input("Text to Insert: ")
    let l:text = substitute(l:text, '/','\\/', 'g')
    execute ('%s/'.@".'/'.l:text.'/g')
endfunction

" ---------------------------------------------------

"  SandBox {{{1
let g:notes_directories = ['~/.vim/notes']

nnoremap <left> <cmd>bprev<cr>
nnoremap <right> <cmd>bnext<cr>
nnoremap <up> <cmd>tabprev<cr>
nnoremap <down> <cmd>tabnext<cr>

" let g:gitgutter_sign_added = 'xx'
" let g:gitgutter_sign_modified = 'yy'
" let g:gitgutter_sign_removed = 'zz'
let g:gitgutter_sign_removed_first_line = ''
let g:gitgutter_sign_removed_above_and_below = ''
let g:gitgutter_sign_modified_removed = ''

function! NumL ()
    return system:"('$')
endfunction
function! GetTime ()
    return trim(system('date +"%I:%m"'))
endfunction

function! GetDate ()
    if exists("$TMUX")
        return ''
    else
        return trim(system('date +"%I:%m%P %a %m/%d" | sed -e "s/ 0/ /" -e "s/^0//"'))
    endif
endfunction

lua  << EOF
local Mode = {}
Mode.map = {
  ['n']    = '',
  ['no']   = '',
  ['nov']  = '',
  ['noV']  = '',
  ['no']   = '',
  ['niI']  = '',
  ['niR']  = '',
  ['niV']  = '',
  ['v']    = '濾',
  ['V']    = '濾',
  ['']   = '礪',
  ['s']    = 's',
  ['S']    = 'S',
  ['']   = 'S',
  ['i']    = '',
  ['ic']   = '',
  ['ix']   = '',
  ['R']    = 'r',
  ['Rc']   = 'r',
  ['Rv']   = 'R',
  ['Rx']   = 'R',
  ['c']    = '',
  ['cv']   = 'X',
  ['ce']   = 'X',
  ['r']    = 'r',
  ['rm']   = 'more',
  ['r?']   = '',
  ['!']    = '',
  ['t']    = '',
}
-- LuaFormatter on
function Mode.get_mode()
  local mode_code = vim.api.nvim_get_mode().mode
  if Mode.map[mode_code] == nil then return mode_code end
  return Mode.map[mode_code]
end

require'lualine'.setup{
    options = {
        theme = 'nightfox',
    },
    sections = {
        lualine_a = {Mode.get_mode},
        lualine_b = {''},
        lualine_c = {'filename'},

        lualine_x = {'Cwd'},
        lualine_y = {'branch', 'GetDate'},
        lualine_z = {'GetTime', 'NumL', 'diagnostics'},
    }
}
EOF

