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

" Light Weight Config {{{3
if exists('$VIM_LITE')
    let g:GIT_TOOLS = 1
    let g:CPP_TOOLS = 0
    let g:GUI_TOOLS = 0
    let g:NVIM_TOOLS = 0
    let g:SNIPPETS = 1
    let g:STATUS_LINE = 0
endif

" Nvim VSCode Plugin Options {{{3
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
    for l:line in readfile(a:file)
        execute l:line
    endfor
endfunction

" ------------------------------------------------------------------
" Essentials {{{3
PlugDef 'easymotion/vim-easymotion'
PlugDef 'rhysd/clever-f.vim'
PlugDef 'bogado/file-line'
PlugDef 'machakann/vim-sandwich'

" GUI Essentials {{{3
PlugDef 'dstein64/nvim-scrollview'
PlugDef 'junegunn/fzf', { 'do': { -> fzf#install() } }
PlugDef 'junegunn/fzf.vim'

" Window Management {{{3
PlugDef 'caenrique/nvim-maximize-window-toggle'
PlugDef 'Asheq/close-buffers.vim'
PlugDef 'caenrique/nvim-toggle-terminal'

" Text Editing {{{3
PlugDef 'mg979/vim-visual-multi', {'branch': 'master'}
PlugDef 'AndrewRadev/sideways.vim'
PlugDef 'tpope/vim-commentary'
PlugDef 'tpope/vim-sensible'
PlugDef 'tpope/vim-eunuch' " Unix Commands
PlugDef 'meain/vim-printer'
PlugDef 'wellle/targets.vim'

" Misc {{{3
PlugDef 'tpope/vim-repeat'
PlugDef 'lfv89/vim-interestingwords'
PlugDef 'xolox/vim-misc'
PlugDef 'xolox/vim-session'

" Language Support {{{3
PlugDef 'MaxMEllon/vim-jsx-pretty'
PlugDef 'elixir-editors/vim-elixir'
PlugDef 'rust-lang/rust.vim'
PlugDef 'MTDL9/vim-log-highlighting'
PlugDef 'plasticboy/vim-markdown'
PlugDef 'cespare/vim-toml'
PlugDef 'manicmaniac/coconut.vim'

" Appearance
" PlugDef 'Yggdroot/indentLine' {{{3
PlugDef 'lukas-reineke/indent-blankline.nvim'
PlugDef 'ryanoasis/vim-devicons'
PlugDef 'kyazdani42/nvim-web-devicons' " for file icons

" Colorschemes {{{3
PlugDef 'EdenEast/nightfox.nvim'
silent call SourceByLine($DOTFILE_PATH."/.config/nvim/colors.vim")

" ------------------------------------------------------------------
if g:GUI_TOOLS " {{{3
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
if g:NVIM_TOOLS " {{{3
" TreeSitter
PlugDef 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
PlugDef 'p00f/nvim-ts-rainbow'

" cmp
PlugDef 'hrsh7th/cmp-nvim-lsp'
PlugDef 'hrsh7th/cmp-buffer'
PlugDef 'hrsh7th/cmp-path'
PlugDef 'hrsh7th/cmp-cmdline'
PlugDef 'hrsh7th/nvim-cmp'
PlugDef 'hrsh7th/cmp-vsnip'
PlugDef 'hrsh7th/vim-vsnip'
PlugDef 'tzachar/cmp-tabnine', { 'do': './install.sh' }

" Telescope
PlugDef 'nvim-lua/popup.nvim'
PlugDef 'nvim-lua/plenary.nvim'
PlugDef 'nvim-telescope/telescope.nvim'

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
" Hardcore C++ tools {{{3
if g:CPP_TOOLS
PlugDef 'puremourning/vimspector'
PlugDef 'gauteh/vim-cppman'
endif
" ------------------------------------------------------------------
" Tmux Integration {{{3
if g:TMUX
PlugDef 'christoomey/vim-tmux-navigator'
PlugDef 'roxma/vim-tmux-clipboard'
endif
" ------------------------------------------------------------------
" Snippets {{{3
if g:SNIPPETS
PlugDef 'SirVer/ultisnips'
PlugDef 'honza/vim-snippets'
endif
" ------------------------------------------------------------------
" " Status bar {{{3
if g:STATUS_LINE
PlugDef 'hoob3rt/lualine.nvim'
PlugDef 'pacha/vem-tabline'
endif

" ------------------------------------------------------------------
" Sandbox {{{3
PlugDef 'xolox/vim-notes'
PlugDef 'freitass/todo.txt-vim'

PlugDef 'kana/vim-textobj-user'
PlugDef 'sgur/vim-textobj-parameter'
PlugDef 'AckslD/nvim-revJ.lua'

call plug#end() "
" =========================
"  General Settings {{{1
" ----------------------

"  Appearance {{{2
" Available values: `'default'`, `'atlantis'`, `'andromeda'`, `'shusia'`, `'maia'`, `'espresso'`
let g:sonokai_style = 'andromeda'
let g:sonokai_enable_italic = 0
let g:sonokai_disable_italic_comment = 0

let g:arcadia_Sunset = 1
let g:arcadia_Pitch = 1

lua <<EOF
require'nightfox'.setup({
  fox = "nightfox", -- change the colorscheme to use nordfox
  styles = {
    comments = "italic",
    keywords = "bold",
  },
})
EOF

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
set iskeyword=@,48-57,_,192-255
set termguicolors
set fillchars=vert:\│,eob:\ " Space
set scrolloff=3 " Keep 3 lines below and above the cursor
set foldmethod=expr

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
let g:python3_host_prog = '/usr/bin/python3.8'
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
            \ "foldmethod": ['manual', 'expr', 'syntax', 'marker'],
            \ "mouse": ['a', ''],
            \ "colorcolumn": ['120', '']
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
noremap <leader>7c <cmd>call Cycle_setting("colorcolumn")<CR>
" ------------------------------------------------------------------

"=========================
"   Plugin Settings {{{1
"-------------------------
"  Visual Multi {{{2
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
let g:VM_maps['Increase']                  = 'C-g'
let g:VM_maps['Decrease']                  = 'C-x'
let g:VM_maps['Toggle Mappings']           = '<space><space>'

let g:VM_case_setting = 'sensitive'
let g:VM_theme = 'purplegray'
endif

"  Far {{{2
if PlugLoaded('far')
let g:far#source='rgnvim'
endif

"  Vim Printer {{{2
let g:vim_printer_print_below_keybinding = '<leader>xc'
let g:vim_printer_print_above_keybinding = '<leader>xC'
let g:vim_printer_items = {
            \ 'javascript': 'console.log("{$}:", {$})',
            \ 'python': 'print("{$}:", {$})',
            \ 'cpp': 'info(0) << "{$}:" << {$} << std::endl;',
            \ }


"  Nvim Tree {{{2
if PlugLoaded('nvim_tree_lua')
noremap <leader>\ :NvimTreeToggle<CR>
noremap <leader>\| :NvimTreeFindFile<CR>
noremap <leader>7p :call TogglePicker()<CR>


" let g:nvim_tree_hijack_netrw = 1
let g:nvim_tree_disable_window_picker = 1
let g:nvim_tree_highlight_opened_files = 1
let g:nvim_tree_git_hl = 1
" let g:nvim_tree_update_cwd = 1
lua require'nvim-tree'.setup()

function TogglePicker()
let g:nvim_tree_disable_window_picker =  1 - g:nvim_tree_disable_window_picker
endfunction

endif

"  Which Key {{{2
if PlugLoaded('which_key')
noremap <silent> <leader> :WhichKey ' '<CR>
let g:which_key_map =  {}
let g:which_key_map.p = { 'name' : '+fuzzy' }
let g:which_key_map.c = { 'name' : '+coc' }
let g:which_key_map.d = { 'name' : '+vimspector' }
let g:which_key_map.e = { 'name' : '+edit' }
let g:which_key_map.g = { 'name' : '+git' }
let g:which_key_map.x = { 'name' : '+extension' }
let g:which_key_map.W = { 'name' : '+WhichKey' }
let g:which_key_map['7'] = { 'name' : '+toggle' }

call which_key#register('<Space>', "g:which_key_map")

" Show Help for char
noremap <leader>W <cmd>execute 'WhichKey "'.nr2char(getchar()).'"'<CR>
endif

"  Startify {{{2
if PlugLoaded('startify')
let g:startify_change_to_dir = 1
let g:startify_session_dir = '~/.vim/sessions'
let g:startify_bookmarks = [
            \ "~/dot/.vimrc",
            \ "~/dot/",
            \ "~/.vimrc",
            \ ]

let g:startify_lists = [
            \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
            \ { 'type': 'sessions',  'header': ['   Sessions']       },
            \ { 'type': 'files',     'header': ['   Recent Files']            },
            \ { 'type': 'dir',       'header': ['   Recent from '. getcwd()] },
            \ { 'type': 'commands',  'header': ['   Commands']       },
            \ ]

" Faster startup
let g:startify_enable_unsafe = 1

nnoremap <leader>es <cmd>Startify<cr>
endif

"  Conflict Marker {{{2
if PlugLoaded('conflict_marker')
let g:conflict_marker_enable_mappings = 1
endif

"  Git Gutter {{{2
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

"  EasyMotion {{{2
if PlugLoaded('easymotion')
let g:EasyMotion_startofline = 0
let g:EasyMotion_keys='asdfgtrebvcwqxzyuionmpASDFGHlkjh'
map <leader>f <Plug>(easymotion-bd-f)
map <leader>S <Plug>(easymotion-bd-f2)
map <leader>s <Plug>(easymotion-bd-w)

map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)
endif

"  Terminal Toggle {{{2
if PlugLoaded('toggle_terminal')
noremap <silent> <M-`> :ToggleTerminal<CR>
tnoremap <silent> <M-`> <C-\><C-n>:ToggleTerminal<CR>
noremap <silent> <C-t> :ToggleTerminal<CR>
tnoremap <silent> <C-t> <C-\><C-n>:ToggleTerminal<CR>
endif


command! -nargs=+ Ivy Telescope <args> theme=ivy

"  Fuzzy Commands {{{2
command! Fuzzy         Ivy builtin
command! FuzzyFiles    Files
command! FuzzyFilesR   History
command! FuzzyCom      Ivy commands
command! FuzzyComR     Ivy command_history
command! FuzzyQF       Ivy quickfix
command! FuzzyTags     Clap tags
command! FuzzyFindFile Ivy quickfix
command! FuzzyInc      BLines
command! FuzzyBuffers  Buffers
command! FuzzyFindAll  Ivy live_grep

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

" Fuzzy Mappings {{{3
" Search Word
nnoremap gw <cmd>silent exe("grep! ".expand("<cword>")) \| FuzzyQF <CR>
xnoremap gw "my:silent exe("grep! ".@m) \| FuzzyQF <CR>

nnoremap <leader>xf <cmd>execute('silent grep "'.input('Search For: ').'" \| FuzzyQF ')<CR>

" ==== Telescope ========= {{{3
if PlugLoaded('telescope_nvim')

lua << EOF
require('telescope').setup{
    defaults = {
    results_title = false,
    preview_title = false,
    prompt_title = false,
    layout_strategy = "vertical",
    }
}
EOF

nnoremap <leader>p  <cmd>Ivy<cr>
nnoremap <leader>pp <cmd>Ivy find_files<cr>
nnoremap <leader>pc <cmd>Ivy commands<CR>
nnoremap <leader>pC <cmd>Ivy command_history<CR>
nnoremap <leader>ph <cmd>Ivy oldfiles<CR>
nnoremap <leader>pB <cmd>Ivy file_browser<CR>
nnoremap <leader>pb <cmd>Ivy buffers<CR>
nnoremap <leader>pa <cmd>Ivy current_buffer_tags<CR>
nnoremap <leader>pt <cmd>Ivy tags<CR>
nnoremap <leader>pg <cmd>Ivy current_buffer_fuzzy_find<CR>
nnoremap <leader>py <cmd>Ivy filetypes theme=ivy<CR>
nnoremap <leader>pu <cmd>Ivy lsp_document_symbols<CR>
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
let g:clap_layout = { 'relative': 'editor' }
let g:clap_preview_direction = 'UD'
let g:clap_theme = 'material_design_dark'
let g:clap_enable_background_shadow = v:false
endif

"  nvim-cmp {{{2
if PlugLoaded("nvim_cmp")
set completeopt=menu,menuone,noselect
let g:vsnip_snippet_dir = "/home/arowe/.vim/my_snippets/"

lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = {
      ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'c' }),
      ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'c' }),
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
      { name = 'nvim_lsp' },
      { name = 'cmp_tabnine' },
      { name = 'vsnip' },
      { name = 'buffer' },
      { name = 'path' },
    })
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
endif

" Coq
if PlugLoaded('coq_nvim')
    let g:coq_settings = {}
    let g:coq_settings["clients.tabnine.enabled"] = v:true
    let g:coq_settings["clients.snippets.user_path"] = "~/.vim/my_snippets/"
    let g:coq_settings["keymap.recommended"] = v:false
    let g:coq_settings["keymap.jump_to_mark"] = '<S-Tab>'
    let g:coq_settings["keymap.pre_select"] = v:false
    let g:coq_settings["display.ghost_text.enabled"] = v:false
    let g:coq_settings["auto_start"] = 'shut-up'

    inoremap <expr> <Esc>   pumvisible() ? "\<C-e><Esc>" : "\<Esc>"
    inoremap <expr> <C-c>   pumvisible() ? "\<C-e><C-c>" : "\<C-c>"
    inoremap <expr> <BS>    pumvisible() ? "\<C-e><BS>"  : "\<BS>"
    inoremap <expr> <CR>    pumvisible() ? "\<CR>"  : "\<CR>"
    inoremap <expr> <Tab>   pumvisible() ? (complete_info().selected == -1 ? "\<C-n><C-y>" : "\<C-y>") : "\<Tab>"
    " inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<BS>"
endif
" ------------------------------------------------------------------

"  Nvim LSP {{{2
if PlugLoaded('nvim_lspconfig')
lua << EOF
local lsp = require "lspconfig"

lsp.html.setup{}
lsp.rust_analyzer.setup{}
lsp.clangd.setup{}
lsp.pyright.setup{}
lsp.tsserver.setup{}
lsp.jsonls.setup {
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
        end
      }
    }
}
EOF

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
saga.init_lsp_saga()
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
nnoremap <leader>bw <cmd>TroubleToggle lsp_workspace_diagnostics<cr>
nnoremap <leader>bd <cmd>TroubleToggle lsp_document_diagnostics<cr>
nnoremap <leader>bq <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>bl <cmd>TroubleToggle loclist<cr>
nnoremap gR <cmd>TroubleToggle lsp_references<cr>
endif

if PlugLoaded('lsp_signature')
lua << EOF
require "lsp_signature".setup({
bind = true, -- This is mandatory, otherwise border config won't get registered.
floating_window = false
})
EOF
endif

endif " end LSP

"  Lua Line {{{2
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

require'lualine'.setup{
    options = {
        theme = 'nightfox',
    },
    sections = {
        lualine_a = {get_mode},
        lualine_b = {'filename'},
        lualine_c = {},

        lualine_x = {'Cwd'},
        lualine_y = {'branch', 'GetDate'},
        lualine_z = {'GetTime', 'NumL', 'diagnostics'},
    }
}
EOF
endif
" ==== Lua Line End ====

"  TreeSitter {{{2
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
set foldexpr=nvim_treesitter#foldexpr()

" Incremental Selection
nmap <A-s> gnn
xmap <A-s> grn
xmap <A-S> grm
endif " nvim_treesitter

"  Interesting Words {{{2
let g:interestingWordsDefaultMappings = 0
let g:interestingWordsRandomiseColors = 1
nnoremap <silent> <leader>xi :call InterestingWords('n')<cr>
xnoremap <silent> <leader>xi :call InterestingWords('v')<cr>
nnoremap <silent> <leader>xI :call UncolorAllWords()<cr>

"  Sandwich {{{2
if PlugLoaded('vim_sandwich')
nnoremap ssf :normal saiwf<CR>
nnoremap ssF :normal saiWf<CR>
nnoremap ss' :normal saiw'<CR>
nnoremap ss" :normal saiw"<CR>
nnoremap ss( :normal saiw(<CR>
nnoremap ss< :normal saiw<<CR>
nnoremap ss[ :normal saiw[<CR>
nnoremap ss{ :normal saiw{<CR>

let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)

nnoremap sdc :normal srb(sdf<CR>
nnoremap src :normal srb(srff<CR>:normal srb<<CR>
nnoremap sac :normal saiwf<CR>:normal srb<<CR>
nnoremap saC :normal saiWf<CR>:normal srb<<CR>
endif

"  VimSpector {{{2
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

"  Switch to Layout / Maximize Pane {{{2
if PlugLoaded('nvim_maximize_window_toggle')
nnoremap <leader>m :ToggleOnly<CR>
nnoremap <M-Enter> :ToggleOnly<CR>
endif

"  Sideways {{{2
if PlugLoaded('sideways')
" Move Arguments left or right
noremap <M-<> :SidewaysLeft<CR>
noremap <M->> :SidewaysRight<CR>
endif

"  Custom 'Plugins' {{{2
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

" Persistent Color Scheme {{{ 3
if 1
source ~/.vim/colorscheme.vim
function! WriteColor()
    let l:name = trim(execute('colorscheme'))
    call system('echo colorscheme '.l:name.' > ~/.vim/colorscheme.vim')
endfunction
augroup MyColors
    au!
    "Write Colorscheme
    autocmd ColorScheme * call WriteColor()
augroup END
endif

" clever-f {{{ 3
if PlugLoaded('clever_f')
    let g:clever_f_across_no_line = 1

    nnoremap <Esc> <cmd>call clever_f#reset()<CR>
    nnoremap <leader>7C <cmd>ToggleMultiLine<CR>

    command! ToggleMultiLine exe "let g:clever_f_across_no_line = ".(1 - g:clever_f_across_no_line)."\| echo 'Across Lines: '.(1 - g:clever_f_across_no_line)"
endif

" ------------------------------------------------------------------
"  Misc PLugins {{{2
let g:session_autosave='yes'
let g:session_autosave_periodic=3
let g:session_autoload='no'
let g:interestingWordsDefaultMappings = 0
if g:NERD_FONT
let g:indentLine_char = ''
else
let g:indentLine_char = '|'
endif
let g:autoload_session = 0
let g:UltiSnipsExpandTrigger="<s-tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsSnippetDirectories=['my_snippets', $DOTFILE_PATH.'/.config/snippets', $HOME.'/.vim/plugged/vim-snippets/UltiSnips']


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
nnoremap <leader>qq <cmd>TroubleToggle quickfix<cr>
endif

" Vimrc
nnoremap <leader>ev :tab split ~/.vimrc<cr>
nnoremap <leader>ez :tab split ~/.zshrc<cr>
nnoremap <leader>et :tab split ~/.tmux.conf<cr>

augroup ec_cmds
  autocmd!
  autocmd FileType javascript nnoremap <leader>ec <cmd>e package.json<cr>
augroup END

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
autocmd FileType vim xnoremap <buffer> yr y:@"<CR>
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
" Dont yank on replace
vnoremap p "_dP
" New line when completion open
inoremap <M-CR> <Esc>o
" Easy New lines
nnoremap sj mmo<esc>`mmm
nnoremap sk mmO<esc>`mmm

" ------------------------------------------------------------------
" ===================
"  Commands {{{1
" ===================
" Copy The Path of the file
command! CP :let @" = expand('%')
command! CdFile cd %:p:h
command! CdGit exe 'cd '.finddir('.git', '.;').'/../'

nnoremap <leader>ef <cmd>CdFile<CR>
nnoremap <leader>eg <cmd>CdGit<CR>

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
    autocmd BufRead * if &filetype == 'vim' |
                \ nmap <buffer> gh :exe 'help '.expand('<cword>')<CR> |
                \ set foldmethod=marker |
                \ endif
augroup END

" ==== Fzf Functions ==== {{{2
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

function! Replace(search) abort
    if a:search == ''
        let l:search = input("Text to Replace: ")
    else
        let l:search = a:search
    endif

    let l:text = input("Text to Insert: ")
    let l:text = substitute(l:text, '/','\\/', 'g')
    execute ('%s/'.l:search.'/'.l:text.'/g')
endfunction
command! Replace call Replace('')
command! ReplaceReg call Replace(@")

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

" ---------------------------------------------------
"  SandBox {{{1
let g:notes_directories = ['~/.vim/notes']
let g:notes_suffix = '.md'

command! FindReplace Farr
command! Find Farf

lua << EOF
require("revj").setup{
    keymaps = {
        operator = '<leader>J', -- for operator (+motion)
        line = '<Leader><M-j>', -- for formatting current line
        visual = '<Leader><M-j>', -- for formatting visual selection
    },
}
EOF

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
