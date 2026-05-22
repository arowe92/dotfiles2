local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()

config.default_prog = { 'powershell.exe', '-NoLogo' }

-- tmux-like appearance
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = false
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 32
config.status_update_interval = 1000
config.window_decorations = 'RESIZE'

-- tmux green-ish palette for the tab bar
config.colors = config.colors or {}
config.colors.tab_bar = {
  background = '#0b0b0b',
  active_tab        = { bg_color = '#00875f', fg_color = '#0b0b0b', intensity = 'Bold' },
  inactive_tab      = { bg_color = '#1c1c1c', fg_color = '#9e9e9e' },
  inactive_tab_hover= { bg_color = '#262626', fg_color = '#d0d0d0' },
  new_tab           = { bg_color = '#1c1c1c', fg_color = '#9e9e9e' },
  new_tab_hover     = { bg_color = '#262626', fg_color = '#d0d0d0' },
}

-- tmux-style tab title: " 1:name* "
wezterm.on('format-tab-title', function(tab, tabs, _, _, hover, max_width)
  local idx = tab.tab_index + 1
  local title = tab.tab_title
  if title == nil or #title == 0 then
    title = tab.active_pane.title or ''
  end
  local zoomed = ''
  for _, p in ipairs(tab.panes) do
    if p.is_zoomed then zoomed = 'Z' end
  end
  local marker = tab.is_active and '*' or (hover and '-' or ' ')
  local text = string.format(' %d:%s%s%s ', idx, title, zoomed, marker)
  if #text > max_width then
    text = wezterm.truncate_right(text, max_width - 1) .. ' '
  end
  return text
end)

-- right status: [workspace] user@host  HH:MM dd-mmm
wezterm.on('update-right-status', function(window, pane)
  local ws = window:active_workspace()
  local cwd = ''
  local uri = pane:get_current_working_dir()
  if uri then
    cwd = uri.file_path or ''
    cwd = cwd:gsub('.*[\\/]', '')
  end
  local date = wezterm.strftime(' %H:%M %d-%b ')
  window:set_right_status(wezterm.format({
    { Foreground = { Color = '#0b0b0b' } },
    { Background = { Color = '#00875f' } },
    { Attribute = { Intensity = 'Bold' } },
    { Text = ' ' .. ws .. ' ' },
    { Background = { Color = '#1c1c1c' } },
    { Foreground = { Color = '#d0d0d0' } },
    { Text = ' ' .. cwd .. ' ' },
    { Background = { Color = '#00875f' } },
    { Foreground = { Color = '#0b0b0b' } },
    { Attribute = { Intensity = 'Bold' } },
    { Text = date },
  }))
end)

-- left status: session indicator like tmux's [session]
wezterm.on('update-status', function(window)
  window:set_left_status(wezterm.format({
    { Background = { Color = '#00875f' } },
    { Foreground = { Color = '#0b0b0b' } },
    { Attribute = { Intensity = 'Bold' } },
    { Text = ' [' .. window:active_workspace() .. '] ' },
    { Background = { Color = '#0b0b0b' } },
    { Text = ' ' },
  }))
end)

-- thin pane borders like tmux
config.inactive_pane_hsb = { saturation = 0.85, brightness = 0.75 }
config.window_padding = { left = 4, right = 4, top = 0, bottom = 0 }

-- smart-splits.nvim WezTerm plugin: edge-aware Ctrl-h/j/k/l across
-- nvim splits and WezTerm panes. Pairs with mrjones2014/smart-splits.nvim
-- in nvim. Requires `wezterm` on PATH (it ships with the installer).
-- NOTE: apply_to_config is called AFTER config.keys is assigned below,
-- otherwise the `config.keys = { ... }` reassignment wipes out its bindings.
local smart_splits = wezterm.plugin.require('https://github.com/mrjones2014/smart-splits.nvim')

-- tmux-style leader: Ctrl-a
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 2000 }

config.keys = {
  -- send a literal Ctrl-a
  { key = 'a', mods = 'LEADER|CTRL', action = act.SendKey { key = 'a', mods = 'CTRL' } },

  -- splits (mirror tmux: C-j/k vertical, C-l/h horizontal)
  { key = 'j', mods = 'LEADER|CTRL', action = act.SplitVertical   { domain = 'CurrentPaneDomain' } },
  { key = 'k', mods = 'LEADER|CTRL', action = act.SplitPane       { direction = 'Up',   size = { Percent = 50 } } },
  { key = 'l', mods = 'LEADER|CTRL', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'h', mods = 'LEADER|CTRL', action = act.SplitPane       { direction = 'Left', size = { Percent = 50 } } },

  -- tabs (tmux windows)
  { key = 'c',         mods = 'LEADER', action = act.SpawnTab 'CurrentPaneDomain' },
  { key = ']',         mods = 'LEADER', action = act.ActivateTabRelative(1)  },
  { key = '[',         mods = 'LEADER', action = act.ActivateTabRelative(-1) },
  { key = 'l',         mods = 'LEADER', action = act.ActivateTabRelative(1)  },
  { key = 'h',         mods = 'LEADER', action = act.ActivateTabRelative(-1) },
  { key = '\\',        mods = 'LEADER', action = act.ActivateLastTab },
  { key = 'Tab',       mods = 'LEADER', action = act.ActivateLastTab },

  -- swap tabs
  { key = 'H', mods = 'LEADER|SHIFT', action = act.MoveTabRelative(-1) },
  { key = 'L', mods = 'LEADER|SHIFT', action = act.MoveTabRelative(1)  },

  -- zoom / kill
  { key = 'm',     mods = 'LEADER|CTRL', action = act.TogglePaneZoomState },
  { key = 'Enter', mods = 'LEADER|ALT',  action = act.TogglePaneZoomState },
  { key = 'x',     mods = 'LEADER|CTRL', action = act.CloseCurrentPane { confirm = true } },
  { key = 'q',     mods = 'LEADER|CTRL', action = act.CloseCurrentTab  { confirm = true } },

  -- rename tab (tmux C-r)
  { key = 'r', mods = 'LEADER|CTRL', action = act.PromptInputLine {
      description = 'Rename tab',
      action = wezterm.action_callback(function(window, _, line)
        if line then window:active_tab():set_title(line) end
      end),
  } },

  -- copy mode / paste
  { key = 'v', mods = 'LEADER', action = act.ActivateCopyMode },
  { key = 'p', mods = 'LEADER', action = act.PasteFrom 'Clipboard' },

  -- C-h/j/k/l smart pane nav is added by smart_splits.apply_to_config below.

  -- layouts (rough mapping)
  { key = '5', mods = 'LEADER', action = act.PaneSelect { mode = 'SwapWithActive' } },

  -- fullscreen
  { key = 'F11', mods = 'NONE', action = act.ToggleFullScreen },
}

-- Apply smart-splits AFTER config.keys is set so it can append its bindings
-- (it merges into config.keys; an earlier `config.keys = {}` would discard them).
smart_splits.apply_to_config(config, {
  direction_keys = { 'h', 'j', 'k', 'l' },
  modifiers = {
    move = 'CTRL',
    resize = 'META', -- Alt+h/j/k/l to resize splits
  },
})

return config
