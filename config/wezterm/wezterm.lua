local wezterm = require 'wezterm';

return {
	color_scheme = "TokyoNight Storm",
	font = wezterm.font("JetBrainsMono Nerd Font"),
	term = "wezterm",
	keys = {
		{key="LeftArrow", mods="ALT", action=wezterm.action{SendString="\x1bb"}},
		{key="RightArrow", mods="ALT", action=wezterm.action{SendString="\x1bf"}},
		{key="LeftArrow", mods="SUPER", action=wezterm.action{SendString="\x01"}},
		{key="RightArrow", mods="SUPER", action=wezterm.action{SendString="\x05"}},
	},
}
