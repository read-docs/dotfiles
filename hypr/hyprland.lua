---------------
---variables---
---------------
local wallpaper = "~/.config/assets/backgrounds/the_earth_in_space.jpeg"
local main_mod = "SUPER"
local terminal = "ghostty"
local file_manager = "nautilus"
local menu = "tofi-drun -c ~/.config/tofi/configA --drun-launch=true"
local browser = "zen-browser"
local color_picker = "hyprpicker"

---env---
hl.env("XCURSOR_SIZE", 24)
-- hl.env("XCURSOR_THEME", "Bibata-Modern-Classic")
-- hl.env("XCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("HYPRCURSOR_SIZE", 24)
hl.env("OZONE_PLATFORM", "wayland")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

hl.env("MOZ_ENABLE_WAYLAND", 1)

hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")

hl.env("GDK_BACKEND", "wayland")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("GTK_USE_PORTAL", "1")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_SCREENSHOTS_DIR", os.getenv("HOME") .. "/screenshots/")
---autostart---
hl.on("hyprland.start", function()
	hl.exec_cmd("waybar ")
	hl.exec_cmd("awww-daemon ")
	hl.exec_cmd(
		"awww img ~/.config/assets/backgrounds/the_earth_in_space.jpeg --transition-fps 255 --transition-type outer --transition-duration 0.8"
	)
	hl.exec_cmd("wl-paste --type text --watch cliphist store ")
	hl.exec_cmd("wl-paste --type image --watch cliphist store")
	hl.exec_cmd('rm "$HOME/.cache/cliphist/db"   ')
	hl.exec_cmd("hypridle")
	hl.exec_cmd("systemctl --user start hyprpolkitagent")

	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
end)

-------------
---monitor---
-------------
hl.monitor({
	output = "DP-1",
	mode = "1920x1080@180",
	position = "0x0",
	scale = 1,
})

hl.config({
	misc = {
		font_family = "JetBrains Mono Nerd Font 12",
	},
})

hl.bind("CTRL + Escape", hl.dsp.exec_cmd("killall waybar || waybar"))
hl.bind(main_mod .. "+ T", hl.dsp.exec_cmd(terminal))
local close_window_bind = hl.bind(main_mod .. "+ Q", hl.dsp.window.close())
hl.bind(main_mod .. "+ A", hl.dsp.exec_cmd(menu))
hl.bind(main_mod .. "+ B", hl.dsp.exec_cmd(browser))
hl.bind(main_mod .. "+ F", hl.dsp.exec_cmd(file_manager))
hl.bind(main_mod .. "+ S", hl.dsp.exec_cmd("spotify"))
hl.bind(main_mod .. "+ ALT + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(
	main_mod .. "+ V",
	hl.dsp.exec_cmd("cliphist list | tofi -c ~/.config/tofi/configV | cliphist decode | wl-copy")
)
hl.bind("Print", hl.dsp.exec_cmd("grimblast --notify copysave screen # Entire screen + clipboard copy"))
hl.bind("ALT + Print", hl.dsp.exec_cmd("grimblast --notify copysave active"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("grimblast --notify copysave area"))

hl.bind(main_mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(main_mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(main_mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(main_mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

for i = 1, 5 do
	hl.workspace_rule({ workspace = tostring(i), persistent = true })
end

hl.config({
	general = {
		gaps_in = 0,
		gaps_out = 1,
		layout = "scrolling",
		allow_tearing = true,
		border_size = 1,

		col = {
			active_border = "#141415",
			inactive_border = "#252530",
		},
	},

	decoration = {
		rounding = 2,
		rounding_power = 4.0,
		active_opacity = 1.0,
		inactive_opacity = 0.9,

		blur = {

			enabled = true,
			size = 3,
			passes = 3,
			new_optimizations = true,
			vibrancy = 0.1696,
			ignore_opacity = true,
		},
	},
	input = {
		kb_layout = "us",
	},
	animations = {
		enabled = true,
	},
})

hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- Default springs
hl.curve("easy", { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })
hl.curve("rubber", { type = "spring", mass = 1, stiffness = 101, dampening = 18 })

hl.animation({ leaf = "global", enabled = true, speed = 2, spring = "rubber" })
-- hl.animation({ leaf = "border", enabled = true, speed = 2.7, bezier = "easeOutQuint" })
-- hl.animation({ leaf = "windows", enabled = true, speed = 2.4, spring = "easy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 1.5, spring = "rubber", style = "slide top 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 0.75, spring = "rubber", style = "slide bottom 87%" })
-- hl.animation({ leaf = "fadeIn", enabled = true, speed = 0.87, bezier = "almostLinear" })
-- hl.animation({ leaf = "fadeOut", enabled = true, speed = 0.73, bezier = "almostLinear" })
-- hl.animation({ leaf = "fade", enabled = true, speed = 1.5, bezier = "quick" })
-- hl.animation({ leaf = "layers", enabled = true, speed = 1.9, bezier = "easeOutQuint" })
-- hl.animation({ leaf = "layersIn", enabled = true, speed = 2, bezier = "easeOutQuint", style = "fade" })
-- hl.animation({ leaf = "layersOut", enabled = true, speed = 0.75, bezier = "linear", style = "fade" })
-- hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 0.9, bezier = "almostLinear" })
-- hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 0.7, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 0.952, spring = "rubber", style = "slide" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 0.6, spring = "rubber", style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 0.952, spring = "rubber", style = "slide" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 3.5, bezier = "quick" })

--# Zoom
local function zoomfunction(value)
	local zoomvalue = hl.get_config("cursor:zoom_factor")
	if (zoomvalue + value) > 3.0 then
		hl.config({ cursor = { zoom_factor = 3.0 } })
	elseif (zoomvalue + value) < 1.0 then
		hl.config({ cursor = { zoom_factor = 1.0 } })
	else
		hl.config({ cursor = { zoom_factor = zoomvalue + value } })
	end
end
hl.bind("SUPER + Minus", function()
	zoomfunction(-0.3)
end, { repeating = true, description = "Screen: Zoom out" })
hl.bind("SUPER + Equal", function()
	zoomfunction(0.3)
end, { repeating = true, description = "Screen: Zoom in" })

for i = 1, 4 do
	local arrowkey = { "h", "l", "k", "j" }
	local focusdir = { "l", "r", "u", "d" }
	hl.bind(
		"SUPER + " .. arrowkey[i],
		hl.dsp.focus({ direction = focusdir[i] }),
		{ description = "Window: Focus " .. arrowkey[i] }
	)
end
for i = 1, 2 do
	local arrowkey = { "BracketLeft", "BracketRight" }
	local focusdir = { "l", "r" }
	hl.bind("SUPER + " .. arrowkey[i], hl.dsp.focus({ direction = focusdir[i] }))
end
--#/# bind = SUPER + SHIFT, ←/↑/→/↓,, -- Move in direction
for i = 1, 4 do
	local arrowkey = { "h", "l", "k", "j" }
	local focusdir = { "l", "r", "u", "d" }
	hl.bind(
		"SUPER + SHIFT + " .. arrowkey[i],
		hl.dsp.window.move({ direction = focusdir[i] }),
		{ description = "Window: Move " .. arrowkey[i] }
	)
end

hl.bind("SUPER + X", function()
	hl.dispatch(hl.dsp.workspace.toggle_special("minimize"))
	hl.dispatch(hl.dsp.window.move({ workspace = "+0" }))
	hl.dispatch(hl.dsp.workspace.toggle_special("minimize"))
	hl.dispatch(hl.dsp.window.move({ workspace = "special:minimize" }))
	hl.dispatch(hl.dsp.workspace.toggle_special("minimize"))
end)

hl.animation({
	enabled = true,
	leaf = "specialWorkspace",
	spring = "rubber",
	speed = 2,
	style = "slide bottom",
})
hl.workspace_rule({ workspace = "special:minimize", animation = "specialWorkspace" })
