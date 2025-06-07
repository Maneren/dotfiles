local wezterm = require("wezterm")

local mux = wezterm.mux
local cache_dir = os.getenv("XDG_CACHE_HOME") .. "/wezterm" or os.getenv("HOME") .. "/.cache/wezterm"
local window_size_cache_path = cache_dir .. "/window_size"

wezterm.on("gui-startup", function()
	os.execute("mkdir -p -- " .. cache_dir)

	local window_size_cache_file = io.open(window_size_cache_path, "r")
	local window
	if window_size_cache_file ~= nil then
		_, _, width, height = string.find(window_size_cache_file:read(), "(%d+),(%d+)")
		_, _, window = mux.spawn_window({ width = tonumber(width), height = tonumber(height) })
		window_size_cache_file:close()
	else
		_, _, window = mux.spawn_window({})
		window:gui_window():maximize()
	end
end)

wezterm.on("window-resized", function(_, pane)
	local tab_size = pane:tab():get_size()
	local cols = tab_size["cols"]
	local rows = tab_size["rows"] + 2 -- Without adding the 2 here, the window doesn't maximize
	local contents = string.format("%d,%d", cols, rows)

	local window_size_cache_file = io.open(window_size_cache_path, "w")
	-- Check if the file was successfully opened
	if window_size_cache_file then
		window_size_cache_file:write(contents)
		window_size_cache_file:close()
	else
		print("Error: Could not open file for writing: " .. window_size_cache_path)
	end
end)

local function tab_title(tab_info)
	local title = tab_info.tab_title
	if title and #title > 0 then
		return title
	end
	return tab_info.active_pane.title
end

wezterm.on("format-tab-title", function(tab, _tabs, _panes, _config, _hover, _max_width)
	local title = tab_title(tab)
	if tab.is_active then
		return {
			{ Text = "▓▒░ " .. title .. " ░▒▓" },
		}
	else
		return {
			{ Text = " " .. title .. " " },
		}
	end
end)

local opts = {
	font_size = 13,
	font = wezterm.font({ family = "Iosevka Nerd Font", weight = "Medium" }),
	warn_about_missing_glyphs = false,
	allow_square_glyphs_to_overflow_width = "Always",

	color_scheme = "Catppuccin Mocha",
	window_background_opacity = 0.95,

	max_fps = 144,

	underline_thickness = "1.5pt",
	underline_position = "-3pt",

	enable_scroll_bar = true,

	enable_tab_bar = true,
	hide_tab_bar_if_only_one_tab = true,
	tab_bar_at_bottom = true,
	use_fancy_tab_bar = false,
	tab_max_width = 80,
	show_tab_index_in_tab_bar = true,
	switch_to_last_active_tab_when_closing_tab = true,

	pane_focus_follows_mouse = true,

	window_padding = {
		left = 4,
		right = 4,
		top = 4,
		bottom = 0,
	},

	scrollback_lines = 100000,

	tiling_desktop_environments = {
		"Wayland",
	},
}

local config = wezterm.config_builder()

local function merge(base, t)
	if type(t) == "function" then
		t = t()
	end
	for key, value in pairs(t) do
		if base[key] ~= nil then
			print("key already exists in config: " .. key)
		else
			base[key] = value
		end
	end
end

merge(config, opts)
merge(config, require("bindings"))
merge(config, require("cursor"))

return config
