local wezterm = require("wezterm")

-- Get current user's home directory dynamically
local __HOME_DIR__ = os.getenv("HOME")

-- Define theme paths using the user's home directory
local __THEME_DIR__ = __HOME_DIR__ .. "/.shell/wezterm/themes/"
local dark_theme_path = __THEME_DIR__ .. "nord-dark.lua"
local light_theme_path = __THEME_DIR__ .. "nord-light.lua"

-- Load theme files dynamically
package.path = package.path .. ";" .. __THEME_DIR__ .. "?.lua"
local dark_theme = require("nord-dark")
local light_theme = require("nord-light")

-- Theme selection based on WEZTERM_THEME environment variable
local is_dark_mode = os.getenv("WEZTERM_THEME") == "dark"

local config = wezterm.config_builder()
config.colors = dark_theme.colors

-- Apply other configurations
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = true
config.cursor_blink_rate = 300
config.default_cursor_style = "BlinkingBlock"
config.window_padding = { left = 0, right = 0, top = 2, bottom = 0 }
config.window_frame = {
  font = wezterm.font({ family = "Roboto", weight = "Bold" }),
  font_size = 12.0,
  active_titlebar_bg = is_dark_mode and "#3B4252" or "#E5E9F0",
  inactive_titlebar_bg = is_dark_mode and "#3B4252" or "#D8DEE9",
}
config.default_prog = { "/usr/bin/zsh", "-l" }
config.keys = {
  { key = "e", mods = "CTRL|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "o", mods = "CTRL|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
}

return config
