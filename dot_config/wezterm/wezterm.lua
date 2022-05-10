local wezterm = require 'wezterm';

local SOLID_LEFT_ARROW = utf8.char(0xe0ba)
local SOLID_LEFT_MOST = utf8.char(0x2588)
local SOLID_RIGHT_ARROW = utf8.char(0xe0bc)

local function basename(s)
  return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

wezterm.on("update-right-status", function(window, _)
  local leader = ""
  if window:leader_is_active() then
    leader = "LEADER"
  end
  window:set_right_status(leader)
end)

wezterm.on("format-window-title", function(tab, pane, tabs, panes, config)
  local zoomed = ""
  if tab.active_pane.is_zoomed then
    zoomed = "[Z] "
  end

  local index = ""
  if #tabs > 1 then
    index = string.format("[%d/%d] ", tab.tab_index + 1, #tabs)
  end

  return zoomed .. index .. tab.active_pane.title
end)

-- local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
local SOLID_RIGHT_ARROW = utf8.char(0xe0b0)

local Grey = "#0f1419"
local LightGrey = "#191f26"

local TAB_BAR_BG = "Black"
local ACTIVE_TAB_BG = "Yellow"
local ACTIVE_TAB_FG = "Black"
local HOVER_TAB_BG = Grey
local HOVER_TAB_FG = "White"
local NORMAL_TAB_BG = LightGrey
local NORMAL_TAB_FG = "White"

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  panes = panes
  config = config
  max_width = max_width

  local background = NORMAL_TAB_BG
  local foreground = NORMAL_TAB_FG

  local is_first = tab.tab_id == tabs[1].tab_id
  local is_last = tab.tab_id == tabs[#tabs].tab_id

  if tab.is_active then
    background = ACTIVE_TAB_BG
    foreground = ACTIVE_TAB_FG
  elseif hover then
    background = HOVER_TAB_BG
    foreground = HOVER_TAB_FG
  end

  local leading_fg = NORMAL_TAB_FG
  local leading_bg = background

  local trailing_fg = background
  local trailing_bg = NORMAL_TAB_BG

  if is_first then
    leading_fg = TAB_BAR_BG
  else
    leading_fg = NORMAL_TAB_BG
  end

  if is_last then
    trailing_bg = TAB_BAR_BG
  else
    trailing_bg = NORMAL_TAB_BG
  end

  local index = tab.tab_index+1
  local icons = { "①", "②", "③", "④", "⑤", "⑥", "⑦", "⑧", "⑨", "⑩", 
                  "⑪", "⑫", "⑬", "⑭", "⑮", "⑯", "⑰", "⑱", "⑲", "⑳", }

  local title = ""..icons[index].." "..tab.active_pane.title..""

  return {
    {Attribute={Italic=false}},
    {Attribute={Intensity=hover and "Bold" or "Normal"}},
    {Background={Color=leading_bg}},  {Foreground={Color=leading_fg}},
      {Text=SOLID_RIGHT_ARROW},
    {Background={Color=background}},  {Foreground={Color=foreground}},
      {Text=" "..title.." "},
    {Background={Color=trailing_bg}}, {Foreground={Color=trailing_fg}},
      {Text=SOLID_RIGHT_ARROW},
  }
end)

return {
  -- Spawn a fish shell in login mode
  default_prog = {"/usr/bin/fish", "-l"},
  tab_bar_at_bottom = true,
  use_fancy_tab_bar = false,

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
    { key = "f", mods="LEADER",         action=wezterm.action{Search={CaseInSensitiveString="hash"}}},

    { key = "RightArrow", mods = "LEADER", action = wezterm.action {ActivatePaneDirection = "Right"}},
    { key = "LeftArrow",  mods = "LEADER", action = wezterm.action {ActivatePaneDirection = "Left"}},
    { key = "UpArrow",    mods = "LEADER", action = wezterm.action {ActivatePaneDirection = "Up"}},
    { key = "DownArrow",  mods = "LEADER", action = wezterm.action {ActivatePaneDirection = "Down"}},

    { key = "1",  mods = "LEADER", action = wezterm.action {ActivateTab = 0}},
    { key = "2",  mods = "LEADER", action = wezterm.action {ActivateTab = 1}},
    { key = "3",  mods = "LEADER", action = wezterm.action {ActivateTab = 2}},
    { key = "4",  mods = "LEADER", action = wezterm.action {ActivateTab = 3}},
    { key = "5",  mods = "LEADER", action = wezterm.action {ActivateTab = 4}},
    { key = "6",  mods = "LEADER", action = wezterm.action {ActivateTab = 5}},
    { key = "7",  mods = "LEADER", action = wezterm.action {ActivateTab = 6}},
    { key = "8",  mods = "LEADER", action = wezterm.action {ActivateTab = 7}},
    { key = "9",  mods = "LEADER", action = wezterm.action {ActivateTab = 8}},
  },

  font = wezterm.font("JetBrains Mono"),
  font_size = 13.0,
  color_scheme = "Dracula",

  colors = {
    tab_bar = {
      background = TAB_BAR_BG,
    },

    cursor_border = "#da012d",
    cursor_bg = "#da012d",
    -- cursor_fg = "#da012d",
  },

  default_cursor_style = 'BlinkingBlock',
  cursor_blink_rate = 600,
  cursor_blink_ease_in = {CubicBezier={0.0, 0.0, 0.0, 0.0}},
  cursor_blink_ease_out = {CubicBezier={0.0, 0.0, 0.0, 0.0}},

  tab_bar_style = {
    new_tab = wezterm.format{
      {Background={Color=HOVER_TAB_BG}}, {Foreground={Color=TAB_BAR_BG}}, {Text=SOLID_RIGHT_ARROW}, {Background={Color=HOVER_TAB_BG}}, {Foreground={Color=HOVER_TAB_FG}},
      {Text=" + "},
      {Background={Color=TAB_BAR_BG}}, {Foreground={Color=HOVER_TAB_BG}}, {Text=SOLID_RIGHT_ARROW},
    },
    new_tab_hover = wezterm.format{
      {Attribute={Italic=false}},
      {Attribute={Intensity="Bold"}},
      {Background={Color=NORMAL_TAB_BG}}, {Foreground={Color=TAB_BAR_BG}}, {Text=SOLID_RIGHT_ARROW}, {Background={Color=NORMAL_TAB_BG}}, {Foreground={Color=NORMAL_TAB_FG}},
      {Text=" + "},
      {Background={Color=TAB_BAR_BG}}, {Foreground={Color=NORMAL_TAB_BG}}, {Text=SOLID_RIGHT_ARROW},
    },
  },

  window_padding = {
    left = "20px",
    right = "20px",
    top = "20px",
    bottom = "0px",
  },
  inactive_pane_hsb = {
    saturation = 0.5,
    brightness = 0.8,
  },
  window_background_opacity = 0.95,
}
