local wezterm = require 'wezterm';

wezterm.on("update-right-status", function(window, _)
	local leader = ""
	if window:leader_is_active() then
		leader = "LEADER"
	end
	window:set_right_status(leader)
end)

return {
  -- Spawn a fish shell in login mode
  default_prog = {"/usr/bin/fish", "-l"},
  font = wezterm.font("JetBrains Mono"),
  font_size = 13.0,
  color_scheme = "Dracula",
  window_padding = {
    left = 10,
    right = 10,
    top = 10,
    bottom = 0,
  },
  inactive_pane_hsb = {
    saturation = 0.5,
    brightness = 0.8,
  },
  window_background_opacity = 0.95,
  default_cursor_style = 'BlinkingBar',
  tab_bar_at_bottom = true,
  leader = { key="a", mods="CTRL" },
  disable_default_key_bindings = true,
  keys = {
    -- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
    { key = "a", mods = "LEADER|CTRL",  action=wezterm.action{SendString="\x01"}},
    { key = "-", mods = "LEADER",       action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
    { key = "\\",mods = "LEADER",       action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
    { key = "z", mods = "LEADER",       action="TogglePaneZoomState" },
    { key = "c", mods = "LEADER",       action=wezterm.action{SpawnTab="CurrentPaneDomain"}},
    { key = "x", mods = "LEADER",       action=wezterm.action{CloseCurrentPane={confirm=true}}},

    { key = "n", mods="SHIFT|CTRL",     action="ToggleFullScreen" },
    { key = "v", mods="SHIFT|CTRL",     action="Paste"},
    { key = "c", mods="SHIFT|CTRL",     action="Copy"},

    {key = "RightArrow", mods = "LEADER", action = wezterm.action {ActivatePaneDirection = "Right"}},
    {key = "LeftArrow",  mods = "LEADER", action = wezterm.action {ActivatePaneDirection = "Left"}},
    {key = "UpArrow",    mods = "LEADER", action = wezterm.action {ActivatePaneDirection = "Up"}},
    {key = "DownArrow",  mods = "LEADER", action = wezterm.action {ActivatePaneDirection = "Down"}},

    {key = "1", mods = "LEADER", action = wezterm.action {ActivateTab = 0}},
    {key = "2", mods = "LEADER", action = wezterm.action {ActivateTab = 1}},
    {key = "3", mods = "LEADER", action = wezterm.action {ActivateTab = 2}},
    {key = "4", mods = "LEADER", action = wezterm.action {ActivateTab = 3}},
    {key = "5", mods = "LEADER", action = wezterm.action {ActivateTab = 4}},
  }
}
