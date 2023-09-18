local wezterm = require 'wezterm'
local config = {}

config.color_scheme = 'Tokyo Night'
config.enable_tab_bar = true
config.tab_bar_at_bottom = true
config.font = wezterm.font('Hack Nerd Font Mono', { weight = 'Regular' })
config.font_size = 14.0
config.enable_kitty_keyboard = true
config.enable_csi_u_key_encoding = false
config.cell_width = 1.0
config.line_height = 1.3
config.window_padding = {
  left = 12,
  right = 12,
  top = 12,
  bottom = 0,
}

config.window_frame = {
  border_left_width = 1,
  border_right_width = 1,
  border_bottom_height = 1,
  border_top_height = 1,
  border_left_color = 'purple',
  border_right_color = 'purple',
  border_bottom_color = 'purple',
  border_top_color = 'purple',
}

local function send_cmd_key(key_code)
  return wezterm.action.SendString('\027[' .. key_code .. ';9u')
end

wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

local function is_vim(pane)
  return pane:get_user_vars().IS_NVIM == 'true'
end
local direction_keys = {
  h = 'Left',
  j = 'Down',
  k = 'Up',
  l = 'Right',
}
local function pane_navigation(key)
  return {
    key = key,
    mods = 'CTRL',
    action = wezterm.action_callback(function(win, pane)
      if is_vim(pane) then
        win:perform_action({ SendKey = { key = key, mods = 'CTRL' } }, pane)
      else
        win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
      end
    end),
  }
end

wezterm.on('update-right-status', function(window, pane)
  local name = window:active_key_table()
  if name then
    name = 'TABLE: ' .. name
  end
  window:set_right_status(name or '')
end)

config.leader = { key = 'Enter', mods = 'CTRL' }
config.keys = {
  {
    key = 'r',
    mods = 'LEADER',
    action = wezterm.action.ActivateKeyTable {
      name = 'resize_pane',
      one_shot = false,
    },
  },
  { key = "a",     mods = "CMD", action = send_cmd_key(string.byte("a")) },
  { key = "b",     mods = "CMD", action = send_cmd_key(string.byte("b")) },
  { key = "d",     mods = "CMD", action = send_cmd_key(string.byte("d")) },
  { key = "e",     mods = "CMD", action = send_cmd_key(string.byte("e")) },
  { key = "f",     mods = "CMD", action = send_cmd_key(string.byte("f")) },
  { key = "g",     mods = "CMD", action = send_cmd_key(string.byte("g")) },
  { key = "h",     mods = "CMD", action = send_cmd_key(string.byte("h")) },
  { key = "i",     mods = "CMD", action = send_cmd_key(string.byte("i")) },
  { key = "j",     mods = "CMD", action = send_cmd_key(string.byte("j")) },
  { key = "k",     mods = "CMD", action = send_cmd_key(string.byte("k")) },
  { key = "l",     mods = "CMD", action = send_cmd_key(string.byte("l")) },
  { key = "m",     mods = "CMD", action = send_cmd_key(string.byte("m")) },
  { key = "n",     mods = "CMD", action = send_cmd_key(string.byte("n")) },
  { key = "o",     mods = "CMD", action = send_cmd_key(string.byte("o")) },
  { key = "p",     mods = "CMD", action = send_cmd_key(string.byte("p")) },
  { key = "q",     mods = "CMD", action = send_cmd_key(string.byte("q")) },
  { key = "s",     mods = "CMD", action = send_cmd_key(string.byte("s")) },
  { key = "u",     mods = "CMD", action = send_cmd_key(string.byte("u")) },
  { key = "x",     mods = "CMD", action = send_cmd_key(string.byte("x")) },
  { key = "y",     mods = "CMD", action = send_cmd_key(string.byte("y")) },
  { key = "z",     mods = "CMD", action = send_cmd_key(string.byte("z")) },
  { key = "Enter", mods = "CMD", action = send_cmd_key(13) },
  {
    key = ",",
    mods = "CMD",
    action = wezterm.action.SplitPane {
      direction = 'Down',
      size = { Percent = 20 }
    }
  },
  {
    key = ".",
    mods = "CMD",
    action = wezterm.action.SplitPane {
      direction = 'Right',
      size = { Percent = 50 }

    }
  },
  pane_navigation('h'),
  pane_navigation('j'),
  pane_navigation('k'),
  pane_navigation('l'),

  {
    key = 'f',
    mods = 'LEADER',
    action = wezterm.action.TogglePaneZoomState,
  },

  {
    key = 'x',
    mods = 'LEADER',
    action = wezterm.action.CloseCurrentPane { confirm = false }
  },
}

config.key_tables = {
  resize_pane = {
    { key = 'h',      action = wezterm.action.AdjustPaneSize { 'Left', 3 } },
    { key = 'l',      action = wezterm.action.AdjustPaneSize { 'Right', 3 } },
    { key = 'k',      action = wezterm.action.AdjustPaneSize { 'Up', 3 } },
    { key = 'j',      action = wezterm.action.AdjustPaneSize { 'Down', 3 } },
    { key = 'Escape', action = 'PopKeyTable' },
  },
}


return config
