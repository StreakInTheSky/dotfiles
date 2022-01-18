local wezterm = require 'wezterm';

local theme = 'light'

local function theme_switcher (schemes)
	if type(schemes) == "table" then
		return schemes[theme]
	end
	return schemes
end

local function font_with_fallback(fonts)
	return wezterm.font_with_fallback(fonts)
end

return {
	ssh_domains = require 'ssh_domains';
	color_scheme = theme_switcher({
		dark = "TokyoNight Storm",
		light = "TokyoNight Day",
		night = "TokyoNight Night",
	}),
	font = font_with_fallback({"JetBrains Mono", "JetBrainsMono Nerd Font"}),
	term = "wezterm",
	keys = {
		{key="LeftArrow", mods="ALT", action=wezterm.action{SendString="\x1bb"}},
		{key="RightArrow", mods="ALT", action=wezterm.action{SendString="\x1bf"}},
		{key="LeftArrow", mods="SUPER", action=wezterm.action{SendString="\x01"}},
		{key="RightArrow", mods="SUPER", action=wezterm.action{SendString="\x05"}},
	},
}
