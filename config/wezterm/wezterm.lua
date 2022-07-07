local wezterm = require 'wezterm';

local theme = 'dark'

local function theme_switcher (schemes)
	if type(schemes) == "table" then
		return schemes[theme]
	end
	return schemes
end

local function getModule (name) 
	ok, result = pcall(require, name)
	if ok then
		return result
	end
	return {}
end

local function basename(s, group)
    return string.gsub(s, "(.*[/\\])(.*)", "%" .. group)
end

wezterm.on("format-tab-title", function(tab)
    local cwd = tab.active_pane.title
    local fg = basename(tab.active_pane.foreground_process_name, 2)
    return tab.tab_index + 1 .. ": " .. cwd .. " — " .. fg
end)

return {
	ssh_domains = getModule('ssh-domains'),
	color_scheme = theme_switcher({
		dark = "tokyonight-storm",
		light = "tokyonight-day",
	}),
	use_ime = true,
	font = wezterm.font_with_fallback({
	   "JetBrains Mono",
	   "Noto Sans Mono CJK JP",
	}),
	font_size = 12,
	term = "wezterm",
	keys = {
		{key="LeftArrow", mods="ALT", action=wezterm.action{SendString="\x1bb"}},
		{key="RightArrow", mods="ALT", action=wezterm.action{SendString="\x1bf"}},
		{key="LeftArrow", mods="SUPER", action=wezterm.action{SendString="\x01"}},
		{key="RightArrow", mods="SUPER", action=wezterm.action{SendString="\x05"}},
	},
}
