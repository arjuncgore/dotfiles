local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.initial_cols = 120
config.initial_rows = 58

config.font_size = 12
config.font = wezterm.font("MesloLGS Nerd Font")

config.color_scheme = "catppuccin-mocha"
config.window_padding = { left = 20, right = 20, top = 20, bottom = 20 }

config.default_cursor_style = "BlinkingBar"
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
config.cursor_blink_rate = 500

config.hide_mouse_cursor_when_typing = true
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true

config.window_background_opacity = 0.8
config.macos_window_background_blur = 26

config.window_close_confirmation = "NeverPrompt"
config.automatically_reload_config = true

if wezterm.target_triple:find("apple") then
  config.default_prog = { "/bin/zsh", "-l" }   -- macOS
elseif wezterm.target_triple:find("linux") then
  config.default_prog = { "/bin/bash", "-l" }  -- Linux
end

return config
