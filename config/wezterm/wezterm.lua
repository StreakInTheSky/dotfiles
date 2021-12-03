local wezterm = require 'wezterm';

local theme = 'dark'

local function theme_switcher (wezterm_config)
	if type(wezterm_config.color_scheme) == "table" then
		wezterm_config.color_scheme = wezterm_config.color_scheme[theme]
	end
	return wezterm_config
end

return theme_switcher({
	color_scheme = {
		dark = "TokyoNight Night",
		light = "TokyoNight Day",
	},
	font = wezterm.font("JetBrainsMono Nerd Font"),
	term = "wezterm",
	keys = {
		{key="LeftArrow", mods="ALT", action=wezterm.action{SendString="\x1bb"}},
		{key="RightArrow", mods="ALT", action=wezterm.action{SendString="\x1bf"}},
		{key="LeftArrow", mods="SUPER", action=wezterm.action{SendString="\x01"}},
		{key="RightArrow", mods="SUPER", action=wezterm.action{SendString="\x05"}},
	},
})
