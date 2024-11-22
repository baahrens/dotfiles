local wezterm = require 'wezterm'

local is_work_machine = wezterm.hostname() == "work"

local config = {}

config.color_scheme = 'zenbones_dark'
config.enable_tab_bar = true
config.tab_bar_at_bottom = true
config.font = wezterm.font('Hack Nerd Font Mono', { weight = 'Regular' })
config.font_size = is_work_machine and 11.0 or 14.0
config.enable_kitty_keyboard = true
config.disable_default_key_bindings = true
config.enable_csi_u_key_encoding = false
config.cell_width = 1.0
config.line_height = 1.3
config.warn_about_missing_glyphs = false
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

local cmd_alt = is_work_machine and "ALT" or "CMD"

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
  {
    key = ",",
    mods = cmd_alt,
    action = wezterm.action.SplitPane {
      direction = 'Down',
      size = { Percent = 20 }
    }
  },
  {
    key = ".",
    mods = cmd_alt,
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

  { key = 't', mods = cmd_alt, action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
  { key = 'v', mods = cmd_alt, action = wezterm.action.PasteFrom 'Clipboard' },
  { key = '1', mods = cmd_alt, action = wezterm.action.ActivateTab(0) },
  { key = '2', mods = cmd_alt, action = wezterm.action.ActivateTab(1) },
  { key = '3', mods = cmd_alt, action = wezterm.action.ActivateTab(2) },
  { key = '4', mods = cmd_alt, action = wezterm.action.ActivateTab(3) },
  { key = '5', mods = cmd_alt, action = wezterm.action.ActivateTab(4) },
  { key = '6', mods = cmd_alt, action = wezterm.action.ActivateTab(5) },
  { key = '7', mods = cmd_alt, action = wezterm.action.ActivateTab(6) },
  { key = '8', mods = cmd_alt, action = wezterm.action.ActivateTab(7) },
  { key = '9', mods = cmd_alt, action = wezterm.action.ActivateTab(-1) },
  { key = 'r', mods = cmd_alt, action = wezterm.action.ReloadConfiguration },
}

if not is_work_machine then
  table.insert(config.keys, { key = "a", mods = cmd_alt, action = send_cmd_key(string.byte("a")) })
  table.insert(config.keys, { key = "b", mods = cmd_alt, action = send_cmd_key(string.byte("b")) })
  table.insert(config.keys, { key = "d", mods = cmd_alt, action = send_cmd_key(string.byte("d")) })
  table.insert(config.keys, { key = "e", mods = cmd_alt, action = send_cmd_key(string.byte("e")) })
  table.insert(config.keys, { key = "f", mods = cmd_alt, action = send_cmd_key(string.byte("f")) })
  table.insert(config.keys, { key = "g", mods = cmd_alt, action = send_cmd_key(string.byte("g")) })
  table.insert(config.keys, { key = "h", mods = cmd_alt, action = send_cmd_key(string.byte("h")) })
  table.insert(config.keys, { key = "i", mods = cmd_alt, action = send_cmd_key(string.byte("i")) })
  table.insert(config.keys, { key = "j", mods = cmd_alt, action = send_cmd_key(string.byte("j")) })
  table.insert(config.keys, { key = "k", mods = cmd_alt, action = send_cmd_key(string.byte("k")) })
  table.insert(config.keys, { key = "l", mods = cmd_alt, action = send_cmd_key(string.byte("l")) })
  table.insert(config.keys, { key = "m", mods = cmd_alt, action = send_cmd_key(string.byte("m")) })
  table.insert(config.keys, { key = "n", mods = cmd_alt, action = send_cmd_key(string.byte("n")) })
  table.insert(config.keys, { key = "o", mods = cmd_alt, action = send_cmd_key(string.byte("o")) })
  table.insert(config.keys, { key = "p", mods = cmd_alt, action = send_cmd_key(string.byte("p")) })
  table.insert(config.keys, { key = "q", mods = cmd_alt, action = send_cmd_key(string.byte("q")) })
  table.insert(config.keys, { key = "s", mods = cmd_alt, action = send_cmd_key(string.byte("s")) })
  table.insert(config.keys, { key = "u", mods = cmd_alt, action = send_cmd_key(string.byte("u")) })
  table.insert(config.keys, { key = "x", mods = cmd_alt, action = send_cmd_key(string.byte("x")) })
  table.insert(config.keys, { key = "y", mods = cmd_alt, action = send_cmd_key(string.byte("y")) })
  table.insert(config.keys, { key = "z", mods = cmd_alt, action = send_cmd_key(string.byte("z")) })
  table.insert(config.keys, { key = "Enter", mods = cmd_alt, action = send_cmd_key(13) })
end

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
