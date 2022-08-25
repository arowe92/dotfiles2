"""""""""""""""""""
"  Master Vim RC  "
"""""""""""""""""""
"  Configuration {{{1
"    RC Configuration {{{2
let g:GIT_TOOLS = get(g:, 'GIT_TOOLS', 1)
let g:GUI_TOOLS = get(g:, 'GUI_TOOLS', 1)
let g:NVIM_TOOLS = get(g:, 'NVIM_TOOLS', 1)
let g:STATUS_LINE = get(g:, 'STATUS_LINE', 1)
let g:TMUX = get(g:, 'TMUX', 1) && exists("$TMUX")
let g:NERD_FONT = get(g:, 'NERD_FONT', 1)

" Light Weight Config {{{3
if exists('$VIM_LITE')
    let g:GIT_TOOLS = 1
    let g:GUI_TOOLS = 0
    let g:NVIM_TOOLS = 0
    let g:STATUS_LINE = 0
endif

" Nvim VSCode Plugin Options {{{3
if exists('g:vscode')
    let g:GIT_TOOLS = 0
    let g:GUI_TOOLS = 0
    let g:NVIM_TOOLS = 0
    let g:STATUS_LINE = 0
endif

" Vim for servers
let g:VIM_RAW = v:false
if exists('$VIM_RAW')
    let g:VIM_RAW = v:true

    call plug#begin()
    Plug 'tiagovla/tokyodark.nvim'
    call plug#end()

    colorscheme tokyodark
    function! PlugLoaded(name) abort
        return 0
    endfunction
else

"    Vim-Plug {{{2
" Install vim-plug if it doesnt exist
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin()
" Plugin Helpers {{{3
function! s:FormatPlugName(name) abort
    let l:name = a:name
    let l:name = substitute(l:name, "[-.]", '_', 'g')
    let l:name = substitute(l:name, "[',]", '', 'g')
    let l:name = substitute(l:name, '\(_n\?vim\|n\?vim_\)', '', 'g')
    return l:name
endfunction
function! PlugLoaded(name) abort
    let l:name = s:FormatPlugName(a:name)
    if l:name =~ 'nvim' && !has('nvim')
        return 0
    endif
    return exists('g:plugin_'.l:name)
endfunction
function! PlugDef(...) abort
    let l:name = split(a:000[0], '/')[1]
    let l:name = s:FormatPlugName(l:name)
    if l:name =~ 'nvim' && !has('nvim')
        return
    endif
    execute 'Plug '.join(a:000)
    execute ('let g:plugin_'.l:name.' = 1')
endfunction
command! -nargs=+ PlugDef call PlugDef(<f-args>)
function SourceByLine(file)
    if filereadable(a:file)
        for l:line in readfile(a:file)
            execute l:line
        endfor
    endif
endfunction

" ------------------------------------------------------------------
" Essentials {{{3
PlugDef 'phaazon/hop.nvim'
PlugDef 'ggandor/lightspeed.nvim'
PlugDef 'bogado/file-line'
PlugDef 'machakann/vim-sandwich'

" GUI Essentials {{{3
PlugDef 'dstein64/nvim-scrollview'
PlugDef 'junegunn/fzf', { 'do': { -> fzf#install() } }
PlugDef 'junegunn/fzf.vim'

" Window Management {{{3
PlugDef 'caenrique/nvim-maximize-window-toggle'
PlugDef 'Asheq/close-buffers.vim'

" Text Editing {{{3
PlugDef 'mg979/vim-visual-multi', {'branch': 'master'}
PlugDef 'AndrewRadev/sideways.vim'
PlugDef 'tpope/vim-commentary'
PlugDef 'tpope/vim-eunuch' " Unix Commands
PlugDef 'meain/vim-printer'
PlugDef 'wellle/targets.vim'

" Misc {{{3
PlugDef 'tpope/vim-repeat'
PlugDef 'lfv89/vim-interestingwords'
PlugDef 'xolox/vim-misc'
" PlugDef 'xolox/vim-session'

" Language Support {{{3
PlugDef 'tikhomirov/vim-glsl'
PlugDef 'pangloss/vim-javascript',  { 'for': 'javascript' }
PlugDef 'elixir-editors/vim-elixir'
PlugDef 'rust-lang/rust.vim'
PlugDef 'MTDL9/vim-log-highlighting'
PlugDef 'plasticboy/vim-markdown'
PlugDef 'cespare/vim-toml'
PlugDef 'manicmaniac/coconut.vim'
PlugDef 'google/vim-jsonnet'
PlugDef 'mechatroner/rainbow_csv'

" Appearance {{{3
PlugDef 'lukas-reineke/indent-blankline.nvim'
PlugDef 'ryanoasis/vim-devicons'
PlugDef 'kyazdani42/nvim-web-devicons' " for file icons

" Colorschemes {{{3
silent call SourceByLine($DOTFILE_PATH."/.config/nvim/colors.vim")

" ------------------------------------------------------------------
if g:GUI_TOOLS " {{{3
PlugDef 'mbbill/undotree'

if executable('ctags')
PlugDef 'yegappan/taglist'
endif

" PlugDef 'brooth/far.vim' " Find & Replace
PlugDef 'skywind3000/vim-quickui'
PlugDef 'liuchengxu/vim-which-key'
PlugDef 'kyazdani42/nvim-tree.lua'
" PlugDef 'simrat39/symbols-outline.nvim'
PlugDef 'mhinz/vim-startify'
endif

" ------------------------------------------------------------------
if g:NVIM_TOOLS " {{{3
" TreeSitter
PlugDef 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
PlugDef 'p00f/nvim-ts-rainbow'

" cmp
PlugDef 'hrsh7th/nvim-cmp'
PlugDef 'hrsh7th/cmp-nvim-lsp'
PlugDef 'hrsh7th/cmp-buffer'
PlugDef 'hrsh7th/cmp-path'
PlugDef 'hrsh7th/cmp-cmdline'
PlugDef 'hrsh7th/cmp-vsnip'
PlugDef 'hrsh7th/cmp-calc'
PlugDef 'tzachar/cmp-tabnine', { 'do': './install.sh' }
PlugDef 'andersevenrud/compe-tmux'

PlugDef 'hrsh7th/vim-vsnip'
PlugDef 'hrsh7th/vim-vsnip-integ'
PlugDef 'rafamadriz/friendly-snippets'
" Pictograms for cmp
PlugDef 'onsails/lspkind-nvim'

" Telescope
PlugDef 'nvim-lua/popup.nvim'
PlugDef 'nvim-lua/plenary.nvim'
PlugDef 'nvim-telescope/telescope.nvim'
PlugDef 'nvim-telescope/telescope-file-browser.nvim'


" LSP Config
PlugDef 'neovim/nvim-lspconfig'
PlugDef 'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim'
PlugDef 'ray-x/lsp_signature.nvim'
PlugDef 'glepnir/lspsaga.nvim'
PlugDef 'folke/trouble.nvim'

" Clap
PlugDef 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }
PlugDef 'goolord/nvim-clap-lsp'
PlugDef 'liuchengxu/vista.vim'
endif
" ------------------------------------------------------------------
if g:GIT_TOOLS " {{{3
PlugDef 'tpope/vim-fugitive'
PlugDef 'airblade/vim-gitgutter'
PlugDef 'rhysd/conflict-marker.vim'
endif
" ------------------------------------------------------------------
" Tmux Integration {{{3
if g:TMUX
PlugDef 'christoomey/vim-tmux-navigator'
PlugDef 'roxma/vim-tmux-clipboard'
endif
" ------------------------------------------------------------------
" " Status bar {{{3
if g:STATUS_LINE
PlugDef 'hoob3rt/lualine.nvim'
PlugDef 'pacha/vem-tabline'
PlugDef 'arkav/lualine-lsp-progress'
endif

" ------------------------------------------------------------------
" Sandbox {{{3
PlugDef 'mechatroner/rainbow_csv'
" PlugDef 'chentoast/marks.nvim'
PlugDef 'mattn/emmet-vim'
" PlugDef 'tell-k/vim-autopep8'
PlugDef 'nvim-telescope/telescope-live-grep-args.nvim'
" PlugDef 'Pocco81/TrueZen.nvim'
" PlugDef 'mfussenegger/nvim-dap'
" PlugDef 'kevinhwang91/nvim-bqf'
" PlugDef 'rcarriga/nvim-dap-ui'
" PlugDef 'anuvyklack/hydra.nvim'

call plug#end()

" Vim Raw
endif

" =========================
"  General Settings {{{1
" ----------------------
filetype plugin indent on
syntax enable

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
set iskeyword=@,48-57,_,192-255
set termguicolors
set fillchars=vert:\│,eob:\ " Space
set scrolloff=3 " Keep 3 lines below and above the cursor
set foldmethod=indent
set shortmess+=A
set signcolumn=number

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
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
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

" Map key
let mapleader=" "

"    Programs {{{2
" Use ag if it exists
if executable('rg')
    " Use rg over grep
    let g:_grepprg="rg\\ --vimgrep\\ --no-heading\\ --smart-case\\ --ignore-vcs"
    execute "set grepprg=".g:_grepprg
endif

" Set grep prg
function! SetGrepArg(args)
    let l:text = substitute(a:args, ' ', '\\ ', 'g')
    execute "set grepprg=".g:_grepprg.'\ '.l:text
    set grepprg
endfunction

" Set grep prg
function! SetGrepCurrentFile()
    call SetGrepArg("-t ".&filetype)
endfunction

" Use 3.8 if exists
if executable('python3.8')
let g:python3_host_prog = '/usr/bin/python3.8'
endif

if exists(':GuiFont')
GuiFont FuraMono NF:h11
endif

"    Cycle Settings {{{2
let setting_cycles = {
            \ "foldmethod": ['manual', 'expr', 'syntax', 'marker'],
            \ "mouse": ['a', ''],
            \ "colorcolumn": ['120', ''],
            \ "listchars": [
                \      'tab:⇢\ ,trail:-,extends:►,precedes:◄,nbsp:+,space:\ ',
                \ 'eol:¬,tab:⇢·,trail:-,extends:►,precedes:◄,nbsp:+,space:␣'
                \]
            \ }

function! Cycle_setting(name)
    let l:cycle = get(g:setting_cycles, a:name, [])
    if len(l:cycle) == 0
        exe "set ".a:name."!"
        exe "echo '".a:name." =' &".a:name." ? 'on' : 'off'"
        return
    endif

    let next = g:setting_cycles[a:name][0]
    let g:setting_cycles[a:name] = g:setting_cycles[a:name][1:] + [l:next]
    exe "set ".a:name."=".l:next
    echo a:name.' = '.l:next
endfunction

" Setting Toggles
noremap <leader>7w <cmd>call Cycle_setting("wrap")<CR>
noremap <leader>7n <cmd>call Cycle_setting("number")<CR>
noremap <leader>7N <cmd>call Cycle_setting("relativenumber")<CR>
noremap <leader>7m <cmd>call Cycle_setting("mouse")<CR>
noremap <leader>7f <cmd>call Cycle_setting("foldmethod")<CR>
noremap <leader>7c <cmd>call Cycle_setting("colorcolumn")<CR>
noremap <leader>7<space> <cmd>call Cycle_setting("listchars")<CR>
" ------------------------------------------------------------------

"=========================
"  Plugin Settings {{{1
"-------------------------
"    Visual Multi {{{2
if PlugLoaded('visual-multi')
let g:VM_default_mappings = 1
let g:VM_maps = {}
let g:VM_maps['Find Under']                  = '<M-d>'
let g:VM_maps['Find Subword Under']          = '<M-d>'
let g:VM_maps['Select All']                  = '<M-D>'
let g:VM_maps['Visual All']                  = '<M-D>'
let g:VM_maps["Add Cursor Down"]             = '<S-Down>'
let g:VM_maps["Add Cursor Up"]               = '<S-Up>'

let g:VM_maps['Visual Cursors']              = '<Tab>'
let g:VM_maps['Visual Add']                  = 'v'

" Increase numbers
let g:VM_maps['Increase']                  = '+'
let g:VM_maps['Decrease']                  = '-'
let g:VM_maps['Toggle Mappings']           = '<space><space>'
let g:VM_maps['Reselect Last']             = '\\gv'

let g:VM_case_setting = 'sensitive'
let g:VM_theme = 'purplegray'
endif

"    Far {{{2
if PlugLoaded('far')
let g:far#source='rg'
endif

"    Vim Printer {{{2
let g:vim_printer_print_below_keybinding = '<leader>xc'
let g:vim_printer_print_above_keybinding = '<leader>xC'
let g:vim_printer_items = {
            \ 'javascript': 'console.log("{$}:", {$})',
            \ 'python': 'print("{$}:", {$})',
            \ 'cpp': 'info(0) << "{$}:" << {$} << std::endl;',
            \ }


"    Nvim Tree {{{2
if PlugLoaded('nvim_tree_lua')
noremap <leader>\ :NvimTreeToggle<CR>
noremap <leader>\| :NvimTreeFindFile<CR>

lua << EOF
require'nvim-tree'.setup {
    disable_netrw = true,
    renderer = {
        highlight_opened_files = "all",
        highlight_git = true,
    },
    live_filter = {
        always_show_folders = false,
        prefix = "❯ "
    },
    actions = {
        open_file = {
            window_picker = {
                enable = false
                }
            }
        },
    view = { mappings = { list = {
        { key = { "<C-]>"},                       action = "cd" },
        { key = "C-[",                            action = "dir_up" },
        }
    }}
}
EOF


endif

"    Which Key {{{2
if PlugLoaded('which_key')
noremap <silent> <leader> :WhichKey ' '<CR>
let g:which_key_map =  {}
let g:which_key_map.p = { 'name' : '+fuzzy' }
let g:which_key_map.d = { 'name' : '+debugging' }
let g:which_key_map.e = { 'name' : '+edit' }
let g:which_key_map.g = { 'name' : '+git' }
let g:which_key_map.x = { 'name' : '+extension' }
let g:which_key_map.W = { 'name' : '+WhichKey' }
let g:which_key_map['7'] = { 'name' : '+toggle' }

call which_key#register('<Space>', "g:which_key_map")
endif

"    Startify {{{2
if PlugLoaded('startify')
let g:startify_custom_header = startify#center(split(system('figlet nvim'), '\n'))
let g:startify_change_to_dir = 0
let g:startify_session_dir = '~/.vim/sessions'
let g:startify_enable_unsafe = 1 " Faster startup
let g:startify_bookmarks = [
            \ "~/dot/.vimrc",
            \ "~/dot/",
            \ "~/.vimrc",
            \ ]

function s:git_info()
    let l:files = split(trim(system('git ls-files -m')))
    if v:shell_error != 0
        return []
    endif

    let l:list = []
    for f in l:files
        call add(l:list, {'line': f, 'cmd': 'e '.f})
    endfor
    return l:list
endfunction

let g:startify_lists = [
            \ { 'type': 'dir',       'header': ['   Directory: '. getcwd()] },
            \ { 'type': function('s:git_info'),  'header': ['   Git: '.trim(system('git rev-parse --abbrev-ref HEAD'))]},
            \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
            \ { 'type': 'sessions',  'header': ['   Sessions']       },
            \ { 'type': 'commands',  'header': ['   Commands']       },
            \ ]

nnoremap <leader>es <cmd>Startify<cr>
endif

if PlugLoaded('conflict_marker')
"    Conflict Marker {{{2
let g:conflict_marker_enable_mappings = 1

function! HighlightConflictMarker() abort
    highlight ConflictMarkerBegin guibg=#2f7366
    highlight ConflictMarkerOurs guibg=#2e5049
    highlight ConflictMarkerTheirs guibg=#344f69
    highlight ConflictMarkerEnd guibg=#2f628e
    highlight ConflictMarkerCommonAncestorsHunk guibg=#754a81
endfunction
autocmd VimEnter * call HighlightConflictMarker()
endif

"    Git Gutter {{{2
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

"    Indent Blankline {{{2
if PlugLoaded('indent_blankline')
lua << EOF
require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
}
EOF
let g:indent_blankline_char = '▏'
endif

"    Hop {{{2
if PlugLoaded('hop')
lua require'hop'.setup({keys = 'asdfgqwerthjklyuio'})

map <leader>j <cmd>HopLineStartAC<CR>
map <leader>k <cmd>HopLineStartBC<CR>
map <leader>l <cmd>HopWordCurrentLineAC<CR>
map <leader>h <cmd>HopWordCurrentLineBC<CR>
endif

"    Lightspeed {{{2
if PlugLoaded('lightspeed')
lua << EOF
require'lightspeed'.setup {
  -- These keys are captured directly by the plugin at runtime.
  special_keys = {
    next_match_group = '<Space>',
    prev_match_group = '<Tab>',
  },
}
EOF

nmap <leader>s <Plug>(Lightspeed_s)
nmap <leader>S <Plug>(Lightspeed_S)
endif

"    Marks {{{2
if PlugLoaded('marks')
lua << EOF
require'marks'.setup {
  bookmark_0 = {
    sign = "⚑",
    virt_text = "Bookmark1"
  },
  bookmark_1 = {
    sign = "⚑",
    virt_text = "Bookmark2"
  },
  mappings = {
      set_bookmark0 = "mA",
      set_bookmark1 = "mS",
      delete_bookmark = "mD",
      delete_bookmark0 = "mdA",
      delete_bookmark1 = "mdS",
      next_bookmark = "mm",
      prev_bookmark = "mM",
  }
}
EOF
endif

command! -nargs=+ Ivy Telescope <args> theme=ivy
"  Fuzzy Plugins {{{2
"    Fuzzy Commands {{{3
command! Fuzzy         Ivy builtin
command! FuzzyFiles    Files
command! FuzzyFilesR   Ivy oldfiles
command! FuzzyCom      Ivy commands
command! FuzzyComR     Ivy command_history
command! FuzzyQF       Ivy quickfix
command! FuzzyTags     Ivy current_buffer_tags
command! FuzzyFindFile Ivy quickfix
command! FuzzyInc      Ivy current_buffer_fuzzy_find
command! FuzzyBuffers  Ivy buffers
command! FuzzyFindAll  Rg
command! FuzzyResume   Ivy resume

" Mappings
nnoremap <C-p> <cmd>FuzzyFiles<cr>
nnoremap <M-P> <cmd>FuzzyFilesR<cr>
nnoremap <M-r> <cmd>FuzzyComR<cr>
nnoremap <M-R> <cmd>FuzzyCom<cr>
nnoremap <M-e> <cmd>Fuzzy<cr>
nnoremap <M-f> <cmd>FuzzyInc<cr>
nnoremap <M-F> <cmd>FuzzyFindAll<CR>
nnoremap <M-p> <cmd>FuzzyBuffers<CR>
nnoremap <M-t> <cmd>FuzzyTags<CR>
nnoremap <M-T> <cmd>FuzzyResume<CR>
nnoremap <leader>pm <cmd>execute 'BLines {'.'{{'<CR>
nnoremap <leader>pM <cmd>execute 'Lines {'.'{{'<CR>

"    Fuzzy Mappings {{{3
" Search Word
" nnoremap gw <cmd>silent exe("grep! ".expand("<cword>")) \| FuzzyQF <CR>
" xnoremap gw "my:silent exe("grep! ".@m) \| FuzzyQF <CR>
nnoremap gw <cmd>silent exe("Rg ".expand("<cword>"))<CR>

nnoremap <leader>xf <cmd>execute('silent grep "'.input('Search For: ').'" \| FuzzyQF ')<CR>

"    Telescope {{{3
if PlugLoaded('telescope_nvim')

lua << EOF
require('telescope').setup{
defaults = {
    results_title = false,
    preview_title = false,
    prompt_title = false,
    layout_strategy = "vertical",
    extensions = {
        live_grep_args = {
            auto_quoting = true, -- enable/disable auto-quoting
        }
    },
    mappings = {
        n = {
            ['<c-d>'] = require('telescope.actions').delete_buffer
            }, -- n
        i = {
            ['<c-d>'] = require('telescope.actions').delete_buffer
            } -- i
        }
    }
}
require("telescope").load_extension "file_browser"
require("telescope").load_extension "live_grep_args"
EOF

nnoremap <leader>p  <cmd>Ivy<cr>
nnoremap <leader>pp <cmd>Ivy find_files<cr>
nnoremap <leader>pc <cmd>Ivy commands<CR>
nnoremap <leader>pC <cmd>Ivy command_history<CR>
nnoremap <leader>p<M-c> <cmd>Clap colors<CR>
nnoremap <leader>ph <cmd>Ivy help_tags<CR>
nnoremap <leader>pf <cmd>Ivy live_grep_args<CR>
nnoremap <leader>pB <cmd>Ivy file_browser<CR>
nnoremap <leader>pb <cmd>Ivy buffers<CR>
nnoremap <leader>pa <cmd>Ivy current_buffer_tags<CR>
nnoremap <leader>pt <cmd>Ivy tags<CR>
nnoremap <leader>pg <cmd>Ivy current_buffer_fuzzy_find<CR>
nnoremap <leader>py <cmd>Ivy filetypes theme=ivy<CR>
nnoremap <leader>pu <cmd>Ivy lsp_document_symbols<CR>

noremap <leader><M-\> :Ivy file_browser cwd=%:h<CR>
endif

"    FZF {{{3
if PlugLoaded('fzf')
command! FindReplace Farr
command! Find Farf
" Use tmux FZF if tmux exists
if g:TMUX
    let g:fzf_layout = { 'tmux': '-p80%,60%' }
else
    let g:fzf_layout = { 'window': { 'width': '100%', 'height': 0.6, 'border': 'horizontal', 'relative':  v:true, 'yoffset': 0 } }
endif

" FZF Custom Scripts
nnoremap <leader>pi :Include<CR>
nnoremap <leader>pI :InsertInclude<CR>
nnoremap <leader>po :FasdFile<CR>
nnoremap <leader>pO :FasdDir<CR>
nnoremap <leader>pz :FzfCd<CR>
nnoremap <leader>pZ :FzfCdIter<CR>

" Search for marks
nnoremap <leader>pm <cmd>execute('BLines {'.'{{')<CR>


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

"    Clap {{{3
if PlugLoaded('clap')
let g:clap_layout = { 'relative': 'editor' }
let g:clap_preview_direction = 'UD'
let g:clap_theme = 'material_design_dark'
let g:clap_enable_background_shadow = v:false
endif

"    nvim-cmp {{{2
if PlugLoaded("nvim_cmp")
set completeopt=menu,menuone,noselect

"    VSnippets {{{3
let g:vsnip_snippet_dirs = [
            \ $HOME."/.vim/my_snippets/",
            \ $HOME."/.vim/plugged/friendly-snippets/snippets"
            \ ]

"    Cmp Setup {{{3
lua <<EOF
-- Setup nvim-cmp.
local cmp = require'cmp'
local lspkind = require('lspkind')

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = {
        ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'c', 'i' }),
        ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'c', 'i' }),
        ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<M-Enter>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-y>'] = cmp.config.disable,
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ['<Tab>'] = cmp.mapping({
            i = cmp.mapping.confirm({ select = true }),
            c = cmp.mapping.select_next_item(),
        }),
        ['<Enter>'] = cmp.mapping(cmp.mapping.confirm({ select = false })),
        ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item()),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp'},
        { name = 'buffer' },
        { name = 'path' },
        { name = 'vsnip' },
    }, {
        { name = 'calc' },
        { name = 'tmux' },
        { name = 'cmp_tabnine' },
    }),
    formatting = {
        format = lspkind.cmp_format({with_text = false, maxwidth = 50})
    }
})

cmp.setup.cmdline('/', {
    sources = {
        { name = 'buffer' }
    }
})
cmp.setup.cmdline('?', {
    sources = {
        { name = 'buffer' }
    }
})
cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
require('lspconfig')['clangd'].setup {
    capabilities = capabilities
}
EOF

" Jump forward or backward
imap <expr> <C-l> vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<C-l>'
smap <expr> <C-l> vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<C-l>'
imap <expr> <C-h> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-h>'
smap <expr> <C-h> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-h>'

" Cmp Extensions
if PlugLoaded('cmp-tabnine')
lua << EOF
local tabnine = require('cmp_tabnine.config')
tabnine:setup({
        max_lines = 1000;
        max_num_results = 20;
        sort = true;
    run_on_every_keystroke = true;
    snippet_placeholder = '..';
})
EOF
endif
endif

" ------------------------------------------------------------------

"    Nvim LSP {{{2
if PlugLoaded('nvim_lspconfig')
lua << EOF
local lsp = require "lspconfig"

lsp.html.setup{}
lsp.cssls.setup{}
lsp.rust_analyzer.setup{}
lsp.clangd.setup{}
lsp.pyright.setup{}
lsp.tsserver.setup{}
EOF
" lsp.jsonls.setup {
"     commands = {
"       Format = {
"         function()
"           vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
"         end
"       }
"     }
" }

" Goto Actions {{{ 3
nnoremap <silent> gD <Cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gk <Cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gh <Cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gH <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> gt <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gy <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gY <cmd>lua vim.lsp.buf.workspace_symbol()<CR>


" LSP Actions {{{ 3
nnoremap <silent> <leader>cr <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <leader>cR <cmd>LspRestart<CR>
nnoremap <silent> <leader>ca <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> <leader>ce <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
nnoremap <silent> [c <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> ]c <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <silent> <leader>cd <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
nnoremap <silent> <leader>cf <cmd>lua vim.lsp.buf.formatting()<CR>

" LSP Saga {{{ 3
if PlugLoaded("lspsaga")
lua << EOF
local saga = require 'lspsaga'
saga.init_lsp_saga {
    --diagnostic_header = { " ", " ", " ", "ﴞ " },
}
EOF

" Lsp Actions
nnoremap <silent><leader>ca :Lspsaga code_action<CR>
vnoremap <silent><leader>ca :<C-U>Lspsaga range_code_action<CR>
nnoremap <silent><leader>cr :Lspsaga rename<CR>
nnoremap <silent> <leader>ce :Lspsaga show_line_diagnostics<CR>

" Goto
nnoremap <silent> gi :Lspsaga lsp_finder<CR>
nnoremap <silent> gh :Lspsaga hover_doc<CR>
nnoremap <silent> gH :Lspsaga signature_help<CR>
nnoremap <silent> gd :Lspsaga preview_definition<CR>

nnoremap <silent> [c :Lspsaga diagnostic_jump_next<CR>
nnoremap <silent> ]c :Lspsaga diagnostic_jump_prev<CR>
endif

" Toggle LSP on off
nmap <leader>7lu <Plug>(toggle-lsp-diag-underline)
nmap <leader>7ls <Plug>(toggle-lsp-diag-signs)
nmap <leader>7lv <Plug>(toggle-lsp-diag-vtext)
nmap <leader>7lp <Plug>(toggle-lsp-diag-update_in_insert)
nmap <leader>7la <Plug>(toggle-lsp-diag)

" Trouble
if PlugLoaded('trouble')
lua require("trouble").setup({})

nnoremap <leader>bb <cmd>TroubleToggle<cr>
nnoremap <leader>bw <cmd>TroubleToggle workspace_diagnostics<cr>
nnoremap <leader>bd <cmd>TroubleToggle document_diagnostics<cr>
nnoremap <leader>bq <cmd>cclose \| TroubleToggle quickfix<cr>
nnoremap <leader>bl <cmd>TroubleToggle loclist<cr>
nnoremap gR <cmd>TroubleToggle lsp_references<cr>
endif

if PlugLoaded('lsp_signature')
lua << EOF
cfg = {
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    floating_window = false,
    always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58;
    toggle_key = '<M-s>',
    select_signature_key = nil,
}
require "lsp_signature".setup(cfg);
require'lsp_signature'.on_attach(cfg, bufnr)
EOF
endif

endif " end LSP

"    Lua Line {{{2
if PlugLoaded('lualine')

function! GetDate ()
    if exists("$TMUX")
        return ''
    else
        return trim(system('date +"%I:%m%P %a %m/%d" | sed -e "s/ 0/ /" -e "s/^0//"'))
    endif
endfunction

function! TSStatus()
    let l:status = nvim_treesitter#statusline({})
    if l:status == v:null
        return ''
    endif
    return l:status
endfunction

lua  << EOF
local ModeMap = {}
if vim.g.NERD_FONT then
ModeMap = {
  ['n']    = '',
  ['v']    = '',
  ['V']    = '',
  ['']   = '',
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
ModeMap = {
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
  if ModeMap[m] ~= nil then return ModeMap[m] end
  if ModeMap[f] ~= nil then return ModeMap[f] end
  return m
end

-- Color for highlights
local colors = {
  yellow = '#ECBE7B',
  cyan = '#008080',
  darkblue = '#081633',
  green = '#98be65',
  orange = '#FF8800',
  violet = '#a9a1e1',
  magenta = '#c678dd',
  blue = '#51afef',
  red = '#ec5f67'
}

local _progress = {
	'lsp_progress',
	colors = {
	  percentage  = colors.cyan,
	  title  = colors.cyan,
	  message  = colors.orange,
	  spinner = colors.cyan,
	  lsp_client_name = colors.magenta,
	  use = true,
	},
	separators = {
		component = ' ',
		progress = ' | ',
		message = { pre = ' ', post = ' '},
		percentage = { pre = '', post = '% ' },
		title = { pre = '', post = ' ' },
		lsp_client_name = { pre = '', post = '' },
		spinner = { pre = '', post = '' },
		message = { commenced = 'In Progress', completed = 'Completed' },
	},
	display_components = { 'lsp_client_name', 'spinner', { 'title', 'percentage', 'message' } },
	timer = { progress_enddelay = 500, spinner = 1000, lsp_client_name_enddelay = 1000 },
	spinner_symbols = { '🌑 ', '🌒 ', '🌓 ', '🌔 ', '🌕 ', '🌖 ', '🌗 ', '🌘 ' },
}

require'lualine'.setup{
    options = {
        theme = 'catppuccin',
        symbols = {modified = ' ', readonly = ' ', unnamed = 'ﳠ'},
        globalstatus = true
    },
    sections = {
        lualine_a = {get_mode},
        lualine_b = {'filename'},
        lualine_c = {_progress},
        lualine_x = {'Cwd'},
        lualine_y = {'branch', 'GetDate'},
        lualine_z = {'diagnostics'},
    },
}
EOF
endif
" ==== Lua Line End ====

"    TreeSitter {{{2
if PlugLoaded('nvim_treesitter')
lua <<EOF
require'nvim-treesitter.configs'.setup {
    ensure_installed = {},
    ignore_install = { "json" }, -- List of parsers to ignore installing
    highlight = {
        enable = true,
        disable = function(lang, bufnr)
            return vim.api.nvim_buf_line_count(bufnr) > 10000
        end
    },
    indent = {
        enable = { "typescript" },
        disable = { "cpp" },
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
    },
}
EOF
set foldexpr=nvim_treesitter#foldexpr()

" Incremental Selection
nmap <A-s> gnn
xmap <A-s> grn
xmap <A-S> grm
endif " nvim_treesitter

"    Interesting Words {{{2
let g:interestingWordsDefaultMappings = 0
let g:interestingWordsRandomiseColors = 1
nnoremap <silent> <leader>xi :call InterestingWords('n')<cr>
xnoremap <silent> <leader>xi :call InterestingWords('v')<cr>
nnoremap <silent> <leader>xI :call UncolorAllWords()<cr>

"    Sandwich {{{2
if PlugLoaded('vim_sandwich')
let g:sandwich_no_default_key_mappings = 1
let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)

" add
nmap sa <Plug>(sandwich-add)
xmap sa <Plug>(sandwich-add)
omap sa <Plug>(sandwich-add)

" delete
nmap sd <Plug>(sandwich-delete)
xmap sd <Plug>(sandwich-delete)
nmap sdb <Plug>(sandwich-delete-auto)

" replace
nmap sr <Plug>(sandwich-replace)
xmap sr <Plug>(sandwich-replace)
nmap srb <Plug>(sandwich-replace-auto)

endif

"    nvim-dap {{{2
if PlugLoaded('dap')
lua << EOF
local dap = require('dap')
dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = '/home/arowe/.vscode-server/extensions/ms-vscode.cpptools-1.10.8/debugAdapters/bin/OpenDebugAD7'
}

local dap = require('dap')
dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    arguments = vim.g.dap_args,
    program = function()
         if vim.g.dap_prg ~= nil then
             return vim.g.dap_prg
         else
             return vim.fn.input('Path: ', vim.fn.getcwd() .. '/bazel-bin/core/src/unit_tests/' .. vim.fn.expand('%:t:r'), 'file')
         end
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}

vim.fn.sign_define('DapBreakpoint', {text='', texthl='WildMenu', linehl='Visual', numhl=''});
EOF

nnoremap <silent> <leader>dc <Cmd>lua require'dap'.continue()<CR>
nnoremap <silent> <leader>dC <Cmd>lua require'dap'.run_last()<CR>
nnoremap <silent> <leader>dj <Cmd>lua require'dap'.step_over()<CR>
nnoremap <silent> <leader>dl <Cmd>lua require'dap'.step_into()<CR>
nnoremap <silent> <leader>dh <Cmd>lua require'dap'.step_out()<CR>
nnoremap <silent> <leader>dd <Cmd>lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <leader>dC <Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <leader>dr <Cmd>lua require'dap'.repl.open()<CR>
nnoremap <silent> <leader>dL <Cmd>lua require'dap'.run_last()<CR>
nnoremap <silent> <leader>ds <Cmd>lua require'dap'.terminate()<CR>

nnoremap <silent> <leader>du <Cmd>lua require'dapui'.toggle()<CR>
lua require("dapui").setup()
endif

"    Switch to Layout / Maximize Pane {{{2
if PlugLoaded('nvim_maximize_window_toggle')
nnoremap <leader>m :ToggleOnly<CR>
nnoremap <M-Enter> :ToggleOnly<CR>
endif

"    Sideways {{{2
if PlugLoaded('sideways')
" Move Arguments left or right
noremap <M-<> :SidewaysLeft<CR>
noremap <M->> :SidewaysRight<CR>
endif

"    Custom 'Plugins' {{{2
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

" Go up level and history
if 1
let g:_hist = []
nnoremap <leader>c- <cmd>call add(g:_hist, getcwd()) \| cd ..<CR>
nnoremap <leader>c= <cmd>exe "cd ".remove(g:_hist, -1)<CR>
endif

" Persistent Color Scheme {{{ 3
if !$VIM_RAW
source ~/.vim/colorscheme.vim
function! WriteColor()
    let l:name = trim(execute('colorscheme'))
    echo "WRITING COLORS ".l:name
    call system('echo colorscheme '.l:name.' > ~/.vim/colorscheme.vim')
endfunction
"augroup MyColors
"    au!
"    "Write Colorscheme
"    " autocmd ColorScheme * call WriteColor()
"augroup END
endif

" ------------------------------------------------------------------
"    Misc PLugins {{{2
let g:session_autosave='yes'
let g:session_autosave_periodic=3
let g:session_autoload=0
let g:interestingWordsDefaultMappings = 0
let g:autoload_session = 0
let g:autopep8_disable_show_diff=1

execute 'nnoremap <M-g> :Git '
nnoremap <M-o> :ClangdSwitchSourceHeader<CR>
nnoremap <M-u> :FuzzyTags<CR>
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
" command! Buffdelete  silent! ScrollViewDisable  \| bdelete \| silent! ScrollViewEnable
command! Buffdelete ScrollViewDisable | call vem_tabline#tabline.delete_buffer() | ScrollViewEnable
noremap <C-w> <cmd>Buffdelete<CR>
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

" vnoremap <A-K> :m '<-2<CR>gv
vnoremap <leader>xe dO<C-r>"<Esc>
vnoremap <leader>xE do<C-r>"<Esc>


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
nnoremap <up> <cmd>tabnext<cr>
nnoremap <down> <cmd>tabprev<cr>

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

" Use Troubles quickfix if
if PlugLoaded('trouble')
nnoremap <leader>qQ <cmd>cclose \| TroubleToggle quickfix<cr>
endif

" 'Edit' Keys
" Vimrc
nnoremap <leader>ev :tab split ~/.vimrc<cr>
nnoremap <leader>ez :tab split ~/.zshrc<cr>
nnoremap <leader>et :tab split ~/.tmux.conf<cr>
nnoremap <leader>en :tab split ~/.vim/notes.md<cr>

" Note Taking
nnoremap <leader>ej <cmd>execute "e ~/.vim/notes/".system("date +'%m-%d-%y.md'")<CR>
nnoremap <leader>e<M-j> <cmd>execute "e ~/.vim/notes/".input("Name:").".md"<CR>
nnoremap <leader>eJ <cmd>call system("bash ~/.vim/notes/gen_index.sh") \| e ~/.vim/notes/Index.md<CR>

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

" silent search if wrap-around enabled
map <silent> n n

" Asterisk is hard
nnoremap gs *
xnoremap gs *

" Easier block mode
nnoremap v <C-v>
nnoremap <C-v> v

" Easy Macros / Replacing
xmap <M-Q> gsNqq
nmap <M-Q> viw<M-Q>
nnoremap <M-q> nzz@q

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
" run line in shell
nnoremap yR yy:!<C-r>"<CR>
" Yank link
nmap yg <cmd>exe "normal ".v:count."Gyy``"<cr>
nmap yG ygp
" Run Last Command
noremap <leader>r @:<CR>
" Select All
noremap <M-a> 1GVG
" Paste line with in middle
nnoremap <leader>P "_r<Enter>PkJJ
" run Clang
nnoremap <leader>F :FormatClang<CR>
" Easy Semicolon
nnoremap <silent> <M-;> mmA;<esc>`mmm
nnoremap <silent> <M-:> mm$x`mmm
nnoremap <silent> <M-,> mmA,<esc>`mmm
" Dont yank on replace
vnoremap p "_dP
" New line when completion open
inoremap <M-CR> <Esc>o
" Insert Blank line before // After
nnoremap <leader>sk mpO<esc>`pdmp
nnoremap <leader>sj mpo<esc>`pdmp
" Make Prg
nnoremap R <cmd>make<CR>
nnoremap <leader>R <cmd>execute("setlocal makeprg=".input("Set run command: "))<CR>

" ------------------------------------------------------------------
" ===================
"  Commands {{{1
" ===================
" Copy The Path of the file
command! CP :let @" = expand('%')
command! CdFile cd %:p:h
command! CdGit exe 'cd '.finddir('.git', '.;').'/../'
command! Install source ~/.vimrc | PlugInstall

" Change Dir
nnoremap <leader>Cf <cmd>CdFile<CR>
nnoremap <leader>eg <cmd>CdGit<CR>

" Format Commands file
command! FormatClang silent execute '%!clang-format %'
command! FormatJson silent execute '%!python -m json.tool'

" Find Replace Commands
command! FindReplace Farr
command! Find Farf

" Substitute
nnoremap gR :%s//

" FZF / Fasd Commands
if PlugLoaded('fzf')

" Run FZF With Defaults
function! Fzf(dict)
call fzf#run(extend(copy({
            \ 'tmux': '-p80%,80%',
            \ 'options': '--preview="prev {}"'
            \ }), a:dict))
endfunction

command! FasdFile call Fzf({'source': 'fasd -lf', 'sink': 'e'})
command! FasdDir call Fzf({'source': 'fasd -ld', 'sink': 'cd', 'options': '--preview="exa --tree -L 2 {}"'})
command! Include call Fzf({'source': 'fd "\.h$"', 'sink': function('Include')}))
command! InsertInclude call Fzf({'source': 'fd', 'sink': function('InsertInclude')}))
endif

"  functions {{{1
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

    " Make Quick fix Preview By default
    autocmd WinEnter * if &buftype == 'quickfix' | nnoremap <buffer><nowait><silent> <Tab> <Enter>:wincmd j<CR> | endif
    autocmd BufRead * nnoremap <buffer> <nowait> <c-w> <cmd>Buffdelete<CR>

    " C++
    autocmd BufNewFile,BufRead *.h,*.cc set syntax=cpp.doxygen |
                \ setlocal bufhidden=delete |
                \ setlocal iskeyword=@,48-57,_,192-255
    autocmd BufModifiedSet,BufWrite *.cc,*.h setlocal bufhidden=hide
    autocmd BufEnter *.h,*.cc setlocal iskeyword=@,48-57,_,192-255

    " Vim
    autocmd FileType vim
                \ nmap <buffer> gh :exe 'help '.expand('<cword>')<CR>
                \ | nnoremap <buffer> yr yy:<C-r>"<CR>
                \ | xnoremap <buffer> yr y:@"<CR>
                \ | set foldmethod=marker
                \ | nnoremap <buffer> R :source ~/.vimrc<CR>

    " TypeScript
    autocmd FileType typescript
                \ nmap <leader>ec <cmd>e package.json<cr>
                \ nmap <buffer> <leader>dd :normal! odebugger;<ESC><CR>

    " Python
    autocmd FileType python
                \ nnoremap <buffer> <leader>cf :Autopep8<CR>
                \ | set makeprg=python\ %
augroup END

" ==== Fzf functions ==== {{{2
" Easy way to Include c++ files
function! Include(file, ...) abort
    let l:file = a:file

    if l:file == ""
        return
    endif

    let l:root = trim(system("git rev-parse --show-toplevel"))
    let l:fullpath = trim(system("realpath --relative-to=".l:root." ".l:file))
    let l:include = '#include "'.l:fullpath.'"'
    exe "normal! o" . l:include . "\<Esc>"
endfunction

function! InsertInclude(file, ...) abort
    let l:file = a:file

    if l:file == ""
        return
    endif

    let l:root = trim(system("git rev-parse --show-toplevel"))
    let l:fullpath = trim(system("realpath --relative-to=".expand('%:h')." ".l:file))

    let l:include = "'./".l:fullpath."'"
    exe "normal! i" . l:include. "\<Esc>"
endfunction

" Grep
command! -nargs=1 QFindGlobal let g:_last_grep = <q-args> | silent grep <q-args> | copen
command! -nargs=1 QFindFile let g:_last_grep = <q-args> | silent grep <q-args> % | copen
command! -nargs=1 QReplace execute "cdo s/".g:_last_grep."/".<q-args>."/g"
command! -nargs=1 QReplaceW execute "cdo s/".g:_last_grep."/".<q-args>."/g | w"

nnoremap <leader>xf <cmd>execute("QFindFile ".input("Search Current File: "))<CR>
nnoremap <leader>xF <cmd>execute("QFindGlobal ".input("Search Global: "))<CR>
nnoremap <leader>xr <cmd>execute("QReplace ".input("Replace '".g:_last_grep."' in ".len(getqflist())." places with: "))<CR>
nnoremap <leader>xR <cmd>execute("QReplaceW ".input("Replace and WRITE '".g:_last_grep."' in ".len(getqflist())." places with: "))<CR>
nnoremap <leader>xs :%s///g<Left><Left><Left>

nnoremap <leader>f /
nnoremap <leader>F ?
nnoremap <leader>/ :execute 'QFindGlobal '.input("Search Global For: ")<CR>
nnoremap <leader>? :execute 'QReplaceW '.input("Replace <".g:_last_grep."> With: ")<CR>

" Dump a  command
function! Dump(cmd) abort
    vsplit | enew | " open a new split (with 10% height (?))
    setlocal bufhidden=wipe buftype=nofile nobuflisted nolist noswapfile norelativenumber nonumber
    put =execute(a:cmd)
    norm gg2dd
    setlocal readonly nomodifiable nomodified
    nnoremap <buffer><silent> <Esc> :bd<CR>
endfunction
command! -nargs=1 Dump execute "call Dump(" string(<q-args>) ")"

" QuickFix Utils {{{ 3
" When using `dd` in the quickfix list, remove the item from the quickfix list.
function! RemoveQFItem()
  let curqfidx = line('.') - 1
  let qfall = getqflist()
  call remove(qfall, curqfidx)
  call setqflist(qfall, 'r')
  execute curqfidx + 1 . "cfirst"
  :copen
endfunction
:command! RemoveQFItem :call RemoveQFItem()
" Use map <buffer> to only map dd in the quickfix window. Requires +localmap
autocmd FileType qf map <buffer> dd <cmd>RemoveQFItem<cr>

function! GrepQuickFix(pat)
  let all = getqflist()
  for d in all
    if bufname(d['bufnr']) !~ a:pat && d['text'] !~ a:pat
        call remove(all, index(all,d))
    endif
  endfor
  call setqflist(all)
endfunction

function! GrepQuickFixRemove(pat)
  let all = getqflist()
  for d in all
    if bufname(d['bufnr']) =~ a:pat || d['text'] =~ a:pat
        call remove(all, index(all,d))
    endif
  endfor
  call setqflist(all)
endfunction
command! -nargs=* GrepQF call GrepQuickFix(<q-args>)
command! -nargs=* GrepQFRemove call GrepQuickFixRemove(<q-args>)
nnoremap <silent> <leader>q/ <cmd>exe "GrepQF ".input("Select Items /")<CR>
nnoremap <silent> <leader>q? <cmd>exe "GrepQFRemove ".input("Remove Items /")<CR>

if g:VIM_RAW || !has('nvim')
    finish
endif

" ---------------------------------------------------
"  SandBox {{{1
let g:user_emmet_leader_key='<c-n>'
nnoremap <leader>xm 2F"r{astyles.<esc>f"r}
vnoremap <leader>xm =gv:s/"\(.*\)"/{styles.\1}/g<CR>
let g:fzf_colors =
            \ {'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Error'],
            \ 'fg+':     ['fg', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Error'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'border':  ['fg', 'Ignore'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }


" lua << EOF
" local Hydra = require('hydra')

" Hydra({
"    name = 'View Mode2',
"    mode = 'n',
"    body = '<M-h>',
"    heads = {
"       { 'k', '5kzz', },
"       { 'h', '20kzz', },
"       { 'j', '5jzz', },
"       { 'l', '20jzz', },
"    }
" })

" local function cmd(command)
"    return table.concat({ '<Cmd>', command, '<CR>' })
" end

" local hint = [[
"   _f_: files       _m_: marks
"   _o_: old files   _g_: live grep
"   _p_: projects    _/_: search in file

"   _r_: resume      _u_: undotree
"   _h_: vim help    _c_: execute command
"   _k_: keymaps     _;_: commands history
"   _O_: options     _?_: search history

"   _<Enter>_: Telescope           _<Esc>_
" ]]

" Hydra({
"    name = 'Telescope',
"    hint = hint,
"    config = {
"       color = 'teal',
"       invoke_on_body = true,
"       hint = {
"          position = 'middle',
"          border = 'rounded',
"       },
"    },
"    mode = 'n',
"    body = '<m-h>t',
"    heads = {
"       { 'f', cmd 'Ivy find_files' },
"       { 'g', cmd 'Ivy live_grep' },
"       { 'o', cmd 'Ivy oldfiles', { desc = 'recently opened files' } },
"       { 'h', cmd 'Ivy help_tags', { desc = 'vim help' } },
"       { 'm', cmd 'MarksListBuf', { desc = 'marks' } },
"       { 'k', cmd 'Ivy keymaps' },
"       { 'O', cmd 'Ivy vim_options' },
"       { 'r', cmd 'Ivy resume' },
"       { 'p', cmd 'Ivy projects', { desc = 'projects' } },
"       { '/', cmd 'Ivy current_buffer_fuzzy_find', { desc = 'search in file' } },
"       { '?', cmd 'Ivy search_history',  { desc = 'search history' } },
"       { ';', cmd 'Ivy command_history', { desc = 'command-line history' } },
"       { 'c', cmd 'Ivy commands', { desc = 'execute command' } },
"       { 'u', cmd 'silent! %foldopen! | UndotreeToggle', { desc = 'undotree' }},
"       { '<Enter>', cmd 'Ivy', { exit = true, desc = 'list all pickers' } },
"       { '<Esc>', nil, { exit = true, nowait = true } },
"    }
" })
" EOF
colorscheme kosmikoa

let g:user_emmet_expandabbr_key = '<C-n><C-n>'
" let g:user_emmet_expandword_key = '<C-y>;'
" let g:user_emmet_update_tag = '<C-y>u'
" let g:user_emmet_balancetaginward_key = '<C-y>d'
" let g:user_emmet_balancetagoutward_key = '<C-y>D'
" let g:user_emmet_next_key = '<C-y>n'
" let g:user_emmet_prev_key = '<C-y>N'
" let g:user_emmet_imagesize_key = '<C-y>i'
" let g:user_emmet_togglecomment_key = '<C-y>/'
" let g:user_emmet_splitjointag_key = '<C-y>j'
" let g:user_emmet_removetag_key = '<C-y>k'
" let g:user_emmet_anchorizeurl_key = '<C-y>a'
" let g:user_emmet_anchorizesummary_key = '<C-y>A'
" let g:user_emmet_mergelines_key = '<C-y>m'
" let g:user_emmet_codepretty_key = '<C-y>c'
"
nnoremap X "_dd

lua << EOF
local signs = {
  Error = ' ',
  Warn = ' ',
  Info = ' ',
  Hint = 'ﴞ ',
}
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  virtual_text = {
    source = true,
  },
})
EOF

