# Personal Keybinding Reference

Editor-agnostic reference for recreating keymaps in any editor.

**Leader key:** `Space`

---

## File Operations

| Action | Binding | Notes |
|--------|---------|-------|
| Save file | `Ctrl-s` | Works in normal and insert mode |
| Close buffer | `Ctrl-w` | Close current buffer without closing window |
| Quit | `Ctrl-q` | Close window/pane |
| Quit all | `ZZ` or `Zz` | Exit editor entirely |
| Copy file path | `<leader>yf` | Yank current file path to clipboard |

---

## Navigation

### Pane/Window Focus
| Action | Binding |
|--------|---------|
| Focus left pane | `Ctrl-h` |
| Focus down pane | `Ctrl-j` |
| Focus up pane | `Ctrl-k` |
| Focus right pane | `Ctrl-l` |

### Pane/Window Creation
| Action | Binding |
|--------|---------|
| Split left | `Ctrl-x Ctrl-h` |
| Split down | `Ctrl-x Ctrl-j` |
| Split up | `Ctrl-x Ctrl-k` |
| Split right | `Ctrl-x Ctrl-l` |

### Pane Resizing
| Action | Binding |
|--------|---------|
| Increase width | `<leader>=` |
| Decrease width | `<leader>-` |
| Increase height | `<leader>+` |
| Decrease height | `<leader>_` |

### Buffer Navigation
| Action | Binding |
|--------|---------|
| Previous buffer | `Ctrl-x h` or `Alt-Left` |
| Next buffer | `Ctrl-x l` or `Alt-Right` |
| Alternate buffer (last used) | `Shift-Tab` |

### Tab Navigation
| Action | Binding |
|--------|---------|
| Previous tab | `Ctrl-x j` or `Alt-Up` |
| Next tab | `Ctrl-x k` or `Alt-Down` |
| New tab | `Ctrl-x Ctrl-t` |
| Close tab | `Ctrl-x w` |
| Close buffer | `Ctrl-x d` |

---

## Editing

### Line Movement
| Action | Binding | Modes |
|--------|---------|-------|
| Move line up | `Alt-k` or `Alt-K` | Normal, Insert, Visual |
| Move line down | `Alt-j` or `Alt-J` | Normal, Insert, Visual |

### Indentation
| Action | Binding | Modes |
|--------|---------|-------|
| Indent | `Alt-l` or `Alt-L` | Normal, Insert, Visual |
| Outdent | `Alt-h` or `Alt-H` | Normal, Insert, Visual |

### Line Navigation (Overrides)
| Action | Binding | Notes |
|--------|---------|-------|
| Go to first non-whitespace | `H` (Shift-h) | Replaces default behavior |
| Go to end of line | `L` (Shift-l) | Replaces default behavior |

### Insert Mode Helpers
| Action | Binding |
|--------|---------|
| Paste from register | `Ctrl-v` |
| Move to end of line | `Ctrl-e` |
| New line (when completion open) | `Alt-Enter` |
| Escape to normal | `jk` or `kj` |

### Auto-Pairs (Insert Mode)
| Action | Binding |
|--------|---------|
| Insert `{}` block | `Alt-{` |
| Insert `[]` | `Alt-[` |
| Insert `()` | `Alt-(` |
| Insert `""` | `Alt-"` |
| Insert `''` | `Alt-'` |

### Visual Mode
| Action | Binding |
|--------|---------|
| Copy to system clipboard | `<leader>y` |
| Increment sequence | `Ctrl-g` |
| Block select (swapped) | `v` |
| Regular visual (swapped) | `Ctrl-v` |

### Misc Editing
| Action | Binding |
|--------|---------|
| Insert line above | `<leader>sk` |
| Insert line below | `<leader>sj` |
| Select all | `Alt-a` |
| Append semicolon | `Alt-;` |
| Remove trailing semicolon | `Alt-:` |
| Append comma | `Alt-,` |
| Increment number | `Alt-8` |
| Decrement number | `Alt-7` |

---

## Search & Replace

| Action | Binding |
|--------|---------|
| Clear search highlight | `<leader>H` |
| Search/replace prompt | `<leader>r` |
| Search word under cursor & replace | `<leader>R` |
| Find word under cursor (grep) | `gw` |
| Global search/replace | `Alt-5` (opens `:%s///g`) |

---

## Fuzzy Finder / Command Palette

### Quick Access
| Action | Binding |
|--------|---------|
| Find files | `Ctrl-p` |
| Live grep (search in files) | `Alt-f` |
| Open buffers | `Alt-p` |
| Recent files | `Shift-Alt-p` |
| Command palette | `Alt-r` |
| Command history | `Shift-Alt-r` |
| Document symbols | `Alt-t` |
| Search in current file | `<leader>/` |

### Leader-p Finder Menu
| Action | Binding |
|--------|---------|
| Find files | `<leader>pp` |
| Git files | `<leader>pg` |
| Recent/old files | `<leader>po` |
| Live grep | `<leader>pF` |
| Search current file | `<leader>pf` |
| Help tags | `<leader>ph` |
| Commands | `<leader>pc` |
| Resume last search | `<leader>pr` |
| Marks | `<leader>pm` |
| Keymaps | `<leader>pk` |

---

## LSP / Code Intelligence

### Leader-p LSP
| Action | Binding |
|--------|---------|
| Document diagnostics | `<leader>pd` |
| Workspace diagnostics | `<leader>pw` |
| References | `<leader>pR` |
| Declarations | `<leader>pD` |
| Definitions/Go to | `<leader>pi` |
| Code actions | `<leader>pA` |

### Quick LSP (Zed style)
| Action | Binding |
|--------|---------|
| Show diagnostics | `<leader>pd` |
| Find references | `<leader>pr` |
| Go to definition | `<leader>pi` |
| Code actions | `<leader>pa` |

---

## File Tree / Project Panel

| Action | Binding |
|--------|---------|
| Toggle file tree focus | `<leader>\` |
| Reveal current file in tree | `<leader>\|` |

### Within File Tree
| Action | Binding |
|--------|---------|
| Open file/expand | `l` or `Enter` |
| Collapse folder | `h` |
| Collapse all | `Shift-h` |
| Expand all | `Shift-l` |
| New file | `a` |
| New directory | `Shift-a` |
| Rename | `r` |
| Delete | `d` |
| Copy | `y` |
| Cut | `x` |
| Paste | `p` |
| Exit to editor | `Escape` or `Ctrl-l` |

---

## QuickFix / Diagnostics

| Action | Binding |
|--------|---------|
| Open quickfix | `<leader>qo` or `<leader>qq` |
| Close quickfix | `<leader>qc` |
| Clear quickfix | `<leader>qx` |

---

## Toggles

| Action | Binding |
|--------|---------|
| Toggle word wrap | `<leader>tw` |
| Disable auto-comments | `<leader>tc` |
| Enable auto-comments | `<leader>tC` |
| Disable mouse | `<leader>tm` |
| Enable mouse | `<leader>tM` |
| Show whitespace (basic) | `<leader>ti` |
| Show whitespace (all spaces) | `<leader>tI` |

---

## Quick Edit Files (Neovim specific)

| Action | Binding |
|--------|---------|
| Edit notes | `<leader>en` |
| Edit todo | `<leader>et` |
| Edit dotfiles | `<leader>ed` |
| Edit plugins config | `<leader>ep` |
| Edit keymap | `<leader>ek` |
| Edit init | `<leader>ei` |
| Edit vimrc | `<leader>ev` |
| CD to current file dir | `<leader>ef` |
| Reload nvim config | `<leader>xr` |
| Run current lua file | `<leader>xf` |

---

## Context Menu (Neovim)

| Binding | Opens popup with LSP actions |
|---------|------------------------------|
| `Alt-Enter` | Declaration, Definition, Implementation, Type Definition, Search, References, Signature, Rename |

---

## Language-Specific (Rust)

| Action | Binding |
|--------|---------|
| Insert `.unwrap()` | `Alt-u` |
| Insert `.clone()` | `Alt-c` |

---

## Philosophy Notes

- **Pane focus:** Always `Ctrl-hjkl`
- **Pane creation:** Always `Ctrl-x Ctrl-hjkl`
- **Line movement:** Always `Alt-jk`
- **Indentation:** Always `Alt-hl`
- **H/L overrides:** Start/end of line (not default vim behavior)
- **v/Ctrl-v swapped:** `v` is block select, `Ctrl-v` is regular visual
- **jk/kj:** Escape from insert mode
- **Leader:** Space key
- **Fuzzy finder access:** `Ctrl-p` for files, `Alt-` modifiers for variants
