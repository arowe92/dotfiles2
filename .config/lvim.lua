-- general
lvim.log.level = "warn"
lvim.format_on_save = false
lvim.colorscheme = "onedarker"

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

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "startify"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.gitsigns.active = true

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
    { 'tpope/vim-fugitive' },
    { 'christoomey/vim-tmux-navigator' },
    -- {'roxma/vim-tmux-clipboard'}j
    { 'lukas-reineke/indent-blankline.nvim' },
    { 'mg979/vim-visual-multi' },
    {
        'phaazon/hop.nvim',
        config = function()
            require 'hop'.setup({ keys = 'asdfgqwerthjklyuio' })

            vim.keymap.set({ "n", "v" }, "<leader>j", "<cmd>HopLineStartAC<CR>")
            vim.keymap.set({ "n", "v" }, "<leader>k", "<cmd>HopLineStartBC<CR>")
            vim.keymap.set({ "n", "v" }, "<leader>l", "<cmd>HopWordCurrentLineAC<CR>")
            vim.keymap.set({ "n", "v" }, "<leader>h", "<cmd>HopWordCurrentLineBC<CR>")
        end
    },
    { 'machakann/vim-sandwich' },
    { 'AndrewRadev/sideways.vim' },
    { 'rhysd/clever-f.vim' },
    -- {
    --     'glepnir/lspsaga.nvim',
    --     config = function()
    --         require 'lspsaga'.init_lsp_saga {}
    --     end
    -- },
    { 'tpope/vim-commentary' }
}
lvim.builtin.comment.toggler.line = '<M-/>'
lvim.builtin.comment.opleader.line = '<M-/>'

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
lvim.keys.normal_mode["<C-p>"] = "<cmd>Telescope git_files<CR>"
lvim.keys.normal_mode["<S-A-p>"] = "<cmd>Telescope commands<CR>"

-- Settings
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.wrap = true

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
vim.keymap.set({ "n" }, "<Right>", "<cmd>BufferLineCycleNext<CR>")
vim.keymap.set({ "n" }, "<Left>", "<cmd>BufferLineCyclePrev<CR>")

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
-- nmapc("<M-.>", "Lspsaga code_action")
-- nmapc("<leader>ca", "Lspsaga code_action")
-- nmapc("<leader>ce", "Lspsaga show_line_diagnostics")
-- nmapc('gi', 'Lspsaga lsp_finder')
-- nmapc('gh', 'Lspsaga hover_doc')
-- nmapc('gH', 'Lspsaga signature_help')
-- nmapc('gd', 'Lspsaga preview_definition')

nmapc('gk', 'lua vim.lsp.buf.definition()')
nmapc('gD', 'lua vim.lsp.buf.declaration()')
nmapc('gk', 'lua vim.lsp.buf.definition()')
nmapc('gi', 'lua vim.lsp.buf.implementation()')
nmapc('gt', 'lua vim.lsp.buf.type_definition()')
nmapc('gr', 'lua vim.lsp.buf.references()')
nmapc('gy', 'lua vim.lsp.buf.document_symbol()')
nmapc('gY', 'lua vim.lsp.buf.workspace_symbol()')
nmapc('<S-m-f>', 'lua vim.lsp.buf.formatting()')
nmapc("<M-.>", "lua vim.lsp.buf.code_action()")

nmapc('[c', 'Lspsaga diagnostic_jump_next')
nmapc(']c', 'Lspsaga diagnostic_jump_prev')

-- Window REsizing
nmapc('<leader>=', 'vertical resize  +10')
nmapc('<leader>-', 'vertical resize  -10')
nmapc('<leader>+', 'resize  +10')
nmapc('<leader>_', 'resize  -10')

nmapc('<m-p>', 'Telescope buffers')
nmapc('<m-f>', 'Telescope live_grep')

-- Select all
nmap('<m-a>', 'ggvG')

-- Undo Highlighting
nmapc("<leader>H", "nohl")

-- Fugitive
nmap("<M-g>", ":Git ")

vim.keymap.del("n", "<m-j>")
vim.keymap.del("n", "<m-k>")

nmapc('<M-o>', 'ClangdSwitchSourceHeader')

require "luasnip/loaders/from_vscode".load {
    paths = {
        "~/dot/.config/snippets/",
        "~/.config/snippets/",
    }
}
