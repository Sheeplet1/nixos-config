local mod = "SUPER"

hl.on("hyprland.start", function()
	hl.exec_cmd("swww-daemon --format xrgb")
	hl.exec_cmd("firefox")
	hl.exec_cmd("ghostty")
	hl.exec_cmd("spotify")
	hl.exec_cmd("hyprlock")
end)

hl.config({
	general = {
		gaps_in = 8,
		gaps_out = 8,
		border_size = 2,
		resize_on_border = true,
		layout = "master",
	},
	decoration = {
		rounding = 10,
		active_opacity = 1,
		inactive_opacity = 0.8,
		fullscreen_opacity = 1,
		dim_inactive = true,
		dim_strength = 0.1,
		dim_special = 0.8,
		blur = {
			enabled = true,
			size = 6,
			passes = 2,
			ignore_opacity = true,
			new_optimizations = true,
			special = true,
		},
	},
	cursor = {
		no_hardware_cursors = true,
	},
	input = {
		repeat_rate = 33,
		repeat_delay = 225,
	},
	animations = {
		enabled = true,
	},
})

hl.curve("wind", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
hl.curve("winIn", { type = "bezier", points = { { 0.1, 1.1 }, { 0.1, 1.1 } } })
hl.curve("winOut", { type = "bezier", points = { { 0.3, -0.3 }, { 0, 1 } } })
hl.curve("liner", { type = "bezier", points = { { 1, 1 }, { 1, 1 } } })

hl.animation({ leaf = "windows", enabled = true, speed = 6, bezier = "wind", style = "slide" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 6, bezier = "winIn", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 5, bezier = "winOut", style = "slide" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 5, bezier = "wind", style = "slide" })
hl.animation({ leaf = "border", enabled = true, speed = 1, bezier = "liner" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 30, bezier = "liner", style = "loop" })
hl.animation({ leaf = "fade", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "wind" })

hl.monitor({ output = "DP-1", mode = "3440x1440@175", position = "0x0", scale = 1 })

-- To disable the secondary outputs, replace the active DP-2 rule with these rules.
-- hl.monitor({ output = "DP-2", disabled = true })
-- hl.monitor({ output = "DP-3", disabled = true })
-- To place DP-2 to the right of DP-1, use this rule instead of the active DP-2 rule.
-- hl.monitor({ output = "DP-2", mode = "1920x1080@60", position = "3440x0", scale = 1 })
hl.monitor({ output = "DP-2", mode = "1920x1080@60", position = "-1920x0", scale = 1 })

hl.workspace_rule({ workspace = "1", monitor = "DP-1" })
hl.workspace_rule({ workspace = "2", monitor = "DP-1" })
hl.workspace_rule({ workspace = "3", monitor = "DP-1" })
hl.workspace_rule({ workspace = "7", monitor = "DP-1" })
hl.workspace_rule({ workspace = "8", monitor = "DP-1" })
hl.workspace_rule({ workspace = "9", monitor = "DP-1" })

hl.workspace_rule({ workspace = "4", monitor = "DP-2" })
hl.workspace_rule({ workspace = "5", monitor = "DP-2" })
hl.workspace_rule({ workspace = "6", monitor = "DP-2" })

hl.window_rule({ match = { class = "^([Aa]lacritty)$" }, workspace = "1" })
hl.window_rule({ match = { class = "^(com.mitchellh.ghostty)$" }, workspace = "1" })
hl.window_rule({ match = { class = "^([Vv]ivaldi-stable)$" }, workspace = "2" })
hl.window_rule({ match = { class = "^([Ff]irefox)$" }, workspace = "2" })
hl.window_rule({ match = { initial_title = "^([Zz]en Browser)$" }, workspace = "2" })
hl.window_rule({ match = { class = "^([Oo]bsidian)$" }, workspace = "3" })
hl.window_rule({ match = { initial_title = "^([Ss]potify)$" }, workspace = "4" })
hl.window_rule({ match = { initial_title = "^([Ss]potify Premium)$" }, workspace = "4" })
hl.window_rule({ match = { class = "^([Dd]iscord)$" }, workspace = "5" })
hl.window_rule({ match = { class = "^([Ww]ebCord)$" }, workspace = "5" })
hl.window_rule({ match = { class = "^([Vv]esktop)$" }, workspace = "5" })
hl.window_rule({ match = { title = "^([Jj]ellyfin Media Player)$" }, workspace = "7" })
hl.window_rule({ match = { class = "^(1[Pp]assword)$" }, workspace = "8" })
hl.window_rule({ match = { class = "^([Tt]odoist)$" }, workspace = "9" })
hl.window_rule({ match = { initial_class = "^([Tt]icktick)$" }, workspace = "9" })
hl.window_rule({ match = { class = "^(org.kde.polkit-kde-authentication-agent-1)$" }, float = true })
hl.window_rule({ match = { class = "([Zz]oom|onedriver|onedriver-launcher)" }, float = true })
hl.window_rule({
	match = { class = "([Tt]hunar)", title = "(File Operation Progress)" },
	float = true,
	center = true,
})
hl.window_rule({
	match = { class = "([Tt]hunar)", title = "(Confirm to replace files)" },
	float = true,
	center = true,
})
hl.window_rule({ match = { class = "(xdg-desktop-portal-gtk)" }, float = true })
hl.window_rule({ match = { class = "(org.gnome.Calculator)", title = "(Calculator)" }, float = true })

local function bindExec(keys, command)
	hl.bind(keys, hl.dsp.exec_cmd(command))
end

-- Move or resize windows with the main modifier and the left or right mouse button.
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

bindExec(mod .. " + RETURN", "alacritty")
hl.bind(mod .. " + Q", hl.dsp.window.close())
bindExec(mod .. " + D", "pkill wofi || wofi --show drun")
-- bindExec(mod .. " + D", "pkill rofi || rofi -show drun -modi drun,filebrowser,run,window")
bindExec(mod .. " + T", "thunar")
hl.bind(mod .. " + M", hl.dsp.exit())
hl.bind(mod .. " + F", hl.dsp.window.fullscreen())

hl.bind(mod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + down", hl.dsp.focus({ direction = "down" }))

hl.bind(mod .. " + SHIFT + left", hl.dsp.window.resize({ x = -10, y = 0, relative = true }))
hl.bind(mod .. " + SHIFT + right", hl.dsp.window.resize({ x = 10, y = 0, relative = true }))
hl.bind(mod .. " + SHIFT + up", hl.dsp.window.resize({ x = 0, y = -10, relative = true }))
hl.bind(mod .. " + SHIFT + down", hl.dsp.window.resize({ x = 0, y = 10, relative = true }))

hl.bind(mod .. " + CTRL + left", hl.dsp.window.move({ direction = "left" }))
hl.bind(mod .. " + CTRL + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mod .. " + CTRL + up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mod .. " + CTRL + down", hl.dsp.window.move({ direction = "down" }))

hl.bind(mod .. " + SHIFT + f", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + SHIFT + Tab", hl.dsp.focus({ workspace = "m-1" }))
hl.bind(mod .. " + Tab", hl.dsp.focus({ workspace = "m+1" }))

--
-- Wallpapers
--
bindExec(mod .. " + W", "bash $HOME/.scripts/wallpaper_select.sh")
bindExec("CTRL + ALT + W", "bash $HOME/.scripts/wallpaper_random.sh")

--
-- Hyprshot
--
bindExec("PRINT", "hyprshot -m output --clipboard-only --freeze") -- Whole monitor.
bindExec(mod .. " + PRINT", "hyprshot -m window --clipboard-only --freeze") -- Window.
bindExec(mod .. " + S", "hyprshot -m region --clipboard-only --freeze") -- Region selection.

--
-- Hyprpicker
--
bindExec(mod .. " + p", "hyprpicker -a -f hex")

--
-- Media playback controls.
--
bindExec("XF86AudioPlay", "playerctl play-pause")
bindExec("XF86AudioPause", "playerctl play-pause")
bindExec("XF86AudioNext", "playerctl next")
bindExec("XF86AudioPrev", "playerctl previous")

--
-- Media volume controls.
--
bindExec("XF86AudioRaiseVolume", "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+")
bindExec("XF86AudioLowerVolume", "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")
bindExec("XF86AudioMute", "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")

--
-- Scripts
--
bindExec(mod .. " + L", "bash $HOME/.scripts/lock_screen.sh")
bindExec("CTRL + ALT + P", "bash $HOME/.scripts/wlogout.sh")
bindExec(mod .. " + C", "bash $HOME/.scripts/change_audio_device.sh")

for workspace = 1, 10 do
	local keycode = workspace + 9
	local key = "code:" .. keycode

	hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = workspace }))
	hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = workspace }))
	hl.bind(mod .. " + CTRL + " .. key, hl.dsp.window.move({ workspace = workspace, follow = false }))
end

bindExec(mod .. " + b", "zen" or "firefox")
