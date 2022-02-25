local wezterm = require 'wezterm';

local theme = 'light'

local function theme_switcher (schemes)
	if type(schemes) == "table" then
		return schemes[theme]
	end
	return schemes
end

return {
	color_scheme = theme_switcher({
		dark = "TokyoNight Storm",
		light = "TokyoNight Day",
		night = "TokyoNight Night",
	}),
	font = wezterm.font('JetBrainsMono Nerd Font'),
	font_size = 12,
	line_height = 1.1,
	term = "wezterm",
	keys = {
		{key="LeftArrow", mods="ALT", action=wezterm.action{SendString="\x1bb"}},
		{key="RightArrow", mods="ALT", action=wezterm.action{SendString="\x1bf"}},
		{key="LeftArrow", mods="SUPER", action=wezterm.action{SendString="\x01"}},
		{key="RightArrow", mods="SUPER", action=wezterm.action{SendString="\x05"}},
	},
}
