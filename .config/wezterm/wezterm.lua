local wezterm = require("wezterm")
local config = {}

config.color_scheme = "Night Owl (Gogh)"
config.font = wezterm.font("Monaspace Neon", { italic = false })
config.font_size = 11
config.line_height = 1.4
config.enable_tab_bar = false
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

return config
