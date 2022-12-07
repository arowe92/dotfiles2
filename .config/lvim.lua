vim.log.level = "warn"
lvim.format_on_save = false
lvim.colorscheme = "onedarker"
lvim.builtin.which_key.active = false

lvim.builtin.lualine.sections.lualine_a = { {
    'filename',
    file_status = true, -- displays file status (readonly status, modified status)
    path = 2 -- 0 = just filename, 1 = relative path, 2 = absolute path
} }

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
-- }

lvim.builtin.telescope.defaults.mappings = {
    i = {
        ["<c-d>"] = "delete_buffer",
    }
}
-- lvim.builtin.telescope.defaults.path_display = { shorten = 4 }
lvim.builtin.telescope.defaults.path_display = { "absolute" }
lvim.builtin.telescope.defaults.file_ignore_patterns = {
    "node_modules",
    ".git"
}
lvim.builtin.telescope.defaults.vimgrep_arguments = {
    'rg',
    '--color=never',
    '--no-heading',
    '--with-filename',
    '--line-number',
    '--column',
    '--smart-case',
    '-u'
}

lvim.builtin.telescope.defaults.layout_config.width = 0.9

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "startify"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.gitsigns.active = false
lvim.builtin.autopairs.active = true

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
    "bash",
    "c",
    "javascript",
    "json",
    "lua",
    "python",
    "typescript",
    "tsx",
    "css",
    "rust",
    "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true
lvim.lsp.automatic_configuration.skipped_filetypes = { "proto" }
lvim.builtin.cmp.mapping["<M-Enter>"] = require 'cmp'.mapping.complete()

-- generic LSP settings

-- -- make sure server will always be installed even if the server is in skipped_servers list
-- lvim.lsp.installer.setup.ensure_installed = {
--     "sumeko_lua",
--     "jsonls",
-- }
-- -- change UI setting of `LspInstallInfo`
-- -- see <https://github.com/williamboman/nvim-lsp-installer#default-configuration>
-- lvim.lsp.installer.setup.ui.check_outdated_servers_on_open = false
-- lvim.lsp.installer.setup.ui.border = "rounded"
-- lvim.lsp.installer.setup.ui.keymaps = {
--     uninstall_server = "d",
--     toggle_server_expand = "o",
-- }

-- ---@usage disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "black", filetypes = { "python" } },
--   { command = "isort", filetypes = { "python" } },
--   {
--     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

function map(k, v)
    lvim.keys.normal_mode[k] = v
    lvim.keys.visual_mode[k] = v
    lvim.keys.insert_mode[k] = v
end

function nvmap(k, v)
    lvim.keys.normal_mode[k] = v
    lvim.keys.visual_mode[k] = v
end

function nmap(k, v)
    lvim.keys.normal_mode[k] = v
end

function nvmapc(k, v)
    lvim.keys.normal_mode[k] = '<cmd>' .. v .. '<cr>'
    lvim.keys.visual_mode[k] = '<cmd>' .. v .. '<cr>'
end

function nmapc(k, v)
    lvim.keys.normal_mode[k] = '<cmd>' .. v .. '<cr>'
end

-- vim.g.fzf_layout = { tmux = '-p80%,60%' }

-- Additional Plugins
lvim.plugins = {
    { 'junegunn/fzf' },
    { 'junegunn/fzf.vim' },
    { 'RishabhRD/popfix' },
    {
        'weilbith/nvim-code-action-menu',
        config = function()
            vim.g.code_action_menu_show_details = false
            vim.g.code_action_menu_show_diff = true
            vim.keymap.set({ "n", "v" }, "<M-.>", "<cmd>CodeActionMenu<CR>")
        end
    },
    {
        'RishabhRD/nvim-lsputils',
        requires = { { 'RishabhRD/popfix' } },
        config = function()
            vim.lsp.handlers['textDocument/references'] = require 'lsputil.locations'.references_handler
            vim.lsp.handlers['textDocument/definition'] = require 'lsputil.locations'.definition_handler
            vim.lsp.handlers['textDocument/declaration'] = require 'lsputil.locations'.declaration_handler
            vim.lsp.handlers['textDocument/typeDefinition'] = require 'lsputil.locations'.typeDefinition_handler
            vim.lsp.handlers['textDocument/implementation'] = require 'lsputil.locations'.implementation_handler
            vim.lsp.handlers['textDocument/documentSymbol'] = require 'lsputil.symbols'.document_handler
            vim.lsp.handlers['workspace/symbol'] = require 'lsputil.symbols'.workspace_handler
        end
    },
    { 'tpope/vim-fugitive' },
    { 'christoomey/vim-tmux-navigator' },
    { 'lukas-reineke/indent-blankline.nvim' },
    { 'mg979/vim-visual-multi' },
    {
        'phaazon/hop.nvim',
        branch = 'v2',
        config = function()
            require 'hop'.setup({
                keys = 'asdfgqwerthjklyuio',
                current_line_only = true,
            })

            vim.keymap.set({ "n", "v" }, "<leader>j", "<cmd>HopLineStartAC<CR>")
            vim.keymap.set({ "n", "v" }, "<leader>k", "<cmd>HopLineStartBC<CR>")
            vim.keymap.set({ "n", "v" }, "<leader>l", "<cmd>HopWordCurrentLineAC<CR>")
            vim.keymap.set({ "n", "v" }, "<leader>h", "<cmd>HopWordCurrentLineBC<CR>")
        end
    },
    { 'machakann/vim-sandwich' },
    { 'airblade/vim-gitgutter' },
    { 'AndrewRadev/sideways.vim' },
    { 'rhysd/clever-f.vim' },
    {
        'glepnir/lspsaga.nvim',
        disable = true,
        config = function()
            require 'lspsaga'.init_lsp_saga {}

            vim.keymap.set('n', '[c', '<cmd>Lspsaga diagnostic_jump_next<CR>')
            vim.keymap.set('n', ']c', '<cmd>Lspsaga diagnostic_jump_prev<CR>')

            vim.keymap.set('n', '<M-.>', '<cmd>Lspsaga code_action<cr>')
            vim.keymap.set('n', '<leader>ca', '<cmd>Lspsaga code_action<cr>')
            vim.keymap.set('n', '<leader>ce', '<cmd>Lspsaga show_line_diagnostics<cr>')
            vim.keymap.set('n', 'gi', '<cmd>Lspsaga lsp_finder<cr>')
            vim.keymap.set('n', 'gh', '<cmd>Lspsaga hover_doc<cr>')
            vim.keymap.set('n', 'gH', '<cmd>Lspsaga signature_help<cr>')
            vim.keymap.set('n', 'gd', '<cmd>Lspsaga preview_definition<cr>')
        end
    },
    { 'tpope/vim-commentary' },
    {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("trouble").setup {}
        end
    },
    {
        "p00f/nvim-ts-rainbow"
    },
    { "tamton-aquib/duck.nvim",

        config = function()
            vim.keymap.set('n', '<leader>dd', function() require("duck").hatch() end, {})
            vim.keymap.set('n', '<leader>dk', function() require("duck").cook() end, {})
        end
    }
}
lvim.builtin.comment.toggler.line = '<M-/>'
lvim.builtin.comment.opleader.line = '<M-/>'

lvim.builtin.treesitter.rainbow.enable = true;

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.json", "*.jsonc" },
--   -- enable wrap mode for json files only
--   command = "setlocal wrap",
-- })
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })

lvim.leader = "space"

lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<leader>\\"] = {
    "<cmd>NvimTreeToggle<CR>"
}

lvim.keys.normal_mode["<leader><S-\\>"] = {
    "<cmd>NvimTreeFindFile<CR>"
}

lvim.keys.normal_mode["<S-H>"] = "^"
lvim.keys.normal_mode["<S-L>"] = "$"

-- Easy Indenting
lvim.keys.normal_mode["<S-M-H>"] = "<<"
lvim.keys.normal_mode["<S-M-L>"] = ">>"
lvim.keys.insert_mode["<S-M-H>"] = "<cmd>normal <<<CR>"
lvim.keys.insert_mode["<S-M-L>"] = "<cmd>normal >><CR>"
lvim.keys.visual_mode["<S-M-H>"] = "<gv"
lvim.keys.visual_mode["<S-M-L>"] = ">gv"

-- " Easy Line Moving
lvim.keys.normal_mode["<S-M-K>"] = "<cmd>m .-2<CR>"
lvim.keys.insert_mode["<S-M-K>"] = "<cmd>m .-2<CR>"
lvim.keys.normal_mode["<S-M-J>"] = "<cmd>m .+1<CR>"
lvim.keys.insert_mode["<S-M-J>"] = "<cmd>m .+1<CR>"
lvim.keys.visual_mode["<S-M-J>"] = ":m '>+1<CR>gv"
lvim.keys.visual_mode["<S-M-K>"] = ":m '<-2<CR>gv"

-- End visual mode at bottom
lvim.keys.visual_mode["y"] = "ygv<Esc>"
lvim.keys.normal_mode["<C-p>"] = "<cmd>Telescope find_files<CR>"
lvim.keys.normal_mode["<S-A-p>"] = "<cmd>Telescope commands<CR>"

-- Settings
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.wrap = true
vim.o.undofile = false

-- Pane Selection
map("<C-j>", "<C-w>j")
map("<C-k>", "<C-w>k")
map("<C-l>", "<C-w>l")
map("<C-h>", "<C-w>h")
map("<C-w>", "<cmd>bp|bd #<cr>")
map("<C-q>", "<cmd>q<cr>")

-- Pane Creation
map("<C-x><C-k>", "<C-w>s<C-w><C-k>")
map("<C-x><C-j>", "<C-W>s<C-w><C-j>")
map("<C-x><C-l>", "<C-w>v<C-w><C-l>")
map("<C-x><C-h>", "<C-w>v<C-w><C-h>")

nmap("v", "<C-v>")
nmap("<C-v>", "v")

--  Buffers
vim.keymap.set({ "n" }, "<C-x>l", "<cmd>BufferLineCycleNext<CR>")
vim.keymap.set({ "n" }, "<C-x>h", "<cmd>BufferLineCyclePrev<CR>")
vim.keymap.set({ "n" }, "<M-]>", "<cmd>BufferLineCycleNext<CR>")
vim.keymap.set({ "n" }, "<M-[>", "<cmd>BufferLineCyclePrev<CR>")
vim.keymap.set({ "n" }, "<M-Right>", "<cmd>BufferLineCycleNext<CR>")
vim.keymap.set({ "n" }, "<M-Left>", "<cmd>BufferLineCyclePrev<CR>")

-- Vim Visual Multi
vim.g.VM_default_mappings = 1
vim.g.VM_maps = {
    ['Find Under']         = "<M-d>",
    ['Find Subword Under'] = '<M-d>',
    ['Select All']         = '<M-D>',
    ['Visual All']         = '<M-D>',
    ["Add Cursor Down"]    = '<S-Down>',
    ["Add Cursor Up"]      = '<S-Up>',
    ['Visual Cursors']     = '<Tab>',
    ['Visual Add']         = 'v',
    ['Increase']           = '+',
    ['Decrease']           = '-',
    ['Toggle Mappings']    = '<space><space>',
    ['Reselect Last']      = '\\gv',
}
vim.g.VM_case_setting = 'sensitive'
vim.g.VM_theme = 'purplegray'

nmapc('<M-<>', 'SidewaysLeft')
nmapc('<M->>', 'SidewaysRight')

-- LSP Actions
nmapc('gk', 'lua vim.lsp.buf.definition()')
nmapc('gD', 'lua vim.lsp.buf.declaration()')
nmapc('gk', 'lua vim.lsp.buf.definition()')
nmapc('gi', 'lua vim.lsp.buf.implementation()')
nmapc('gt', 'lua vim.lsp.buf.type_definition()')
nmapc('gr', 'lua vim.lsp.buf.references()')
nmapc('gs', 'lua vim.lsp.buf.document_symbol()')
nmapc('gS', 'lua vim.lsp.buf.workspace_symbol()')
nmapc('gh', 'lua vim.lsp.buf.hover()')

nmapc('ge', 'lua vim.diagnostic.open_float()')
nmapc(']e', 'lua vim.diagnostic.goto_next()')
nmapc('[e', 'lua vim.diagnostic.goto_prev()')

nmapc('<S-m-f>', 'lua vim.lsp.buf.formatting()')
nmapc("<M-.>", "lua vim.lsp.buf.code_action()")
-- Window REsizing
nmapc('<leader>=', 'vertical resize  +10')
nmapc('<leader>-', 'vertical resize  -10')
nmapc('<leader>+', 'resize  +10')
nmapc('<leader>_', 'resize  -10')

nmapc('<m-p>', 'Telescope buffers')
nmapc('<s-m-p>', 'Telescope commands')
nmapc('<m-f>', 'Telescope live_grep')
nmapc('<m-r>', 'Telescope command_history')
nmapc('<m-t>', 'Telescope lsp_document_symbols')
nmapc('<S-m-t>', 'Telescope resume')

-- Select all
nmap('<m-a>', 'ggvG')

-- Undo Highlighting
nmapc("<leader>H", "nohl")

-- Fugitive
nmap("<M-g>", ":Git ")
nmapc("]g", "GitGutterNextHunk")
nmapc("<leader>gu", "GitGutterUndoHunk")
nmapc("[g", "GitGutterPrevHunk")

vim.keymap.del("n", "<m-j>")
vim.keymap.del("n", "<m-k>")

nmapc('<M-o>', 'ClangdSwitchSourceHeader')

require "luasnip/loaders/from_vscode".load {
    paths = {
        "~/dot/.config/snippets/",
        "~/.config/snippets/",
    }
}

-- Toggle auto pair
function Toggle_pairs()
    if require('nvim-autopairs').state.disabled then
        require 'nvim-autopairs'.enable()
    else
        require 'nvim-autopairs'.disable()
    end
end

nmapc('<leader>xp', 'lua Toggle_pairs()')


-- Smart Append
function AIndent(mode)
    local lineChars = vim.fn.getline('.')
    if lineChars:gsub("%s+", ""):len() == 0 then
        return '"_cc'
    else
        return mode
    end
end

vim.api.nvim_set_keymap('n', 'A', "v:lua.AIndent('A')", { expr = true })

-- Dont Yank on Paste
vim.keymap.set({ "v" }, "p", '"_dP')

-- Edit Files
vim.keymap.set('n', '<leader>ec', '<cmd>e ~/dot/.config/lvim.lua<CR>')
vim.keymap.set('n', '<leader>el', '<cmd>e ~/.config/lvim/config.lua<CR>')


-- Smart Append
function ToggleTail(char)
    local lineChars = vim.fn.getline('.')
    if lineChars:sub(-1) == char then
        return '$x'
    else
        return vim.api.nvim_replace_termcodes('A' .. char .. '<esc>', true, false, true)
    end
end

vim.api.nvim_set_keymap('n', '<M-,>', "v:lua.ToggleTail(',')", { expr = true })
vim.api.nvim_set_keymap('n', '<M-;>', "v:lua.ToggleTail(';')", { expr = true })

-- vim.keymap.set('n', 'n', 'h')
-- vim.keymap.set('n', 'e', 'j')
-- vim.keymap.set('n', 'i', 'k')
-- vim.keymap.set('n', 'o', 'l')

-- vim.keymap.set('n', 'h','i')
-- vim.keymap.set('n', 'j','e')
-- vim.keymap.set('n', 'k','i')
-- vim.keymap.set('n', 'l','o')
