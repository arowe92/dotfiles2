local DOTFILE_PATH = require('nvim_config.env').DOTFILE_PATH;

return {
  'saghen/blink.cmp',
  version = 'v0.*',
  enabled = not vim.g.vscode,
  dependencies = {
    "fang2hou/blink-copilot" ,
  },
  opts = {
    completion = {
        documentation = {
            auto_show = true,
        },
    },
    keymap = {
      preset = 'super-tab',
      ["<M-Space>"] = { "hide", "show" },
      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback"  },
    },

    cmdline = {
        keymap = {
            ["<Up>"] = { "select_prev", "fallback" },
            ["<Down>"] = { "select_next", "fallback"  },
        },
    },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono',
      kind_icons = {
          Copilot = "",
          Text = '󰉿',
          Method = '󰊕',
          Function = '󰊕',
          Constructor = '󰒓',

          Field = '󰜢',
          Variable = '󰆦',
          Property = '󰖷',

          Class = '󱡠',
          Interface = '󱡠',
          Struct = '󱡠',
          Module = '󰅩',

          Unit = '󰪚',
          Value = '󰦨',
          Enum = '󰦨',
          EnumMember = '󰦨',

          Keyword = '󰻾',
          Constant = '󰏿',

          Snippet = '󱄽',
          Color = '󰏘',
          File = '󰈔',
          Reference = '󰬲',
          Folder = '󰉋',
          Event = '󱐋',
          Operator = '󰪚',
          TypeParameter = '󰬛',
      },
  },

    sources = {
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-copilot",
            score_offset = 100,
            async = true,
            transform_items = function(_, items)
                local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
                local kind_idx = #CompletionItemKind + 1
                CompletionItemKind[kind_idx] = "Copilot"
                for _, item in ipairs(items) do
                    item.kind = kind_idx
                end
                return items
            end,
          },
          snippets = { 
            opts = {
              search_paths = { DOTFILE_PATH .. "/config/snippets" }
            }
          },
        },
        default = { "lsp", "path", "snippets", "buffer", "copilot" },
      },

    signature = { enabled = true }
  },

  opts_extend = { "sources.default" }
}


