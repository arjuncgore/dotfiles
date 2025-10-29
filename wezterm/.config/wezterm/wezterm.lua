local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.initial_cols = 120
config.initial_rows = 58

config.font = wezterm.font_with_fallback({
    "MesloLGS Nerd Font",
    "JetBrainsMono Nerd Font",
    "FiraCode Nerd Font",
})

-- config.color_scheme = "Gruvbox Dark (Gogh)"
-- config.color_scheme = 'Everforest Dark (Gogh)'
config.color_scheme = 'rose-pine-moon'
config.window_padding = { left = 20, right = 20, top = 20, bottom = 20 }

config.default_cursor_style = "BlinkingBar"
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
config.cursor_blink_rate = 500

config.hide_mouse_cursor_when_typing = true
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true

config.window_background_opacity = 0.8
config.window_close_confirmation = "NeverPrompt"
config.automatically_reload_config = true

if wezterm.target_triple:find("apple") then    -- Mac
    config.font_size = 18
    config.default_prog = { "/bin/zsh", "-l" } -- Linux
    config.macos_window_background_blur = 26
    config.max_fps = 120
else
    config.font_size = 15
    config.default_prog = { "/bin/bash" }
    config.front_end = "WebGpu"
    config.webgpu_power_preference = "HighPerformance"
    config.prefer_egl = true
    config.max_fps = 190
end

return config
