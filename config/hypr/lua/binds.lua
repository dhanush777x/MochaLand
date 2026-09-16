-- Keybindings
local vars        = require("lua/variables")

local terminal    = vars.terminal
local fileManager = vars.fileManager
local scriptsDir  = vars.scriptsDir

-- |||----- Applications -----|||#

-- Spotify
hl.bind("CTRL + ALT + I", hl.dsp.exec_cmd("pypr toggle spotify"))
-- Super Productivity
hl.bind("CTRL + ALT + M", hl.dsp.exec_cmd("pypr toggle sp"))

-- Terminal
hl.bind("CTRL + Return", hl.dsp.exec_cmd(terminal), { repeating = true })

-- Application menu
hl.bind("CTRL + Space", hl.dsp.exec_cmd(scriptsDir .. "/open-apps --menu"))

-- Browser
hl.bind("SUPER + w", hl.dsp.exec_cmd("brave-origin-beta"))

-- File manager
hl.bind("SUPER + e", hl.dsp.exec_cmd(fileManager))

-- Pavucontrol
hl.bind("ALT + SHIFT + P", hl.dsp.exec_cmd("pavucontrol"))

-- Focus last window
hl.bind("ALT + SHIFT + Y", hl.dsp.focus({ last = true }))

-- Poweroff
hl.bind("CTRL + SUPER + ALT + P", hl.dsp.exec_cmd("hyprshutdown --vt 7 -p 'systemctl poweroff'"))
-- Reboot
hl.bind("CTRL + SUPER + ALT + R", hl.dsp.exec_cmd("hyprshutdown --vt 7 -p 'systemctl reboot'"))
-- Logout
hl.bind("CTRL + SUPER + ALT + Q", hl.dsp.exec_cmd("hyprshutdown --vt 7"))
-- Kill window
hl.bind("CTRL + SUPER + ALT + K", hl.dsp.exec_cmd("hyprctl kill"))

-- Toggle Waybar
hl.bind("ALT + SHIFT + U", hl.dsp.exec_cmd("pkill -SIGUSR1 waybar"))
-- Reload Waybar
hl.bind("ALT + SHIFT + I", hl.dsp.exec_cmd("pkill -SIGUSR2 waybar"))

-- Wallpaper selector
hl.bind("SUPER + ALT + W", hl.dsp.exec_cmd(scriptsDir .. "/wall-select"))

-- Network Manager
hl.bind("SUPER + ALT + N", hl.dsp.exec_cmd(scriptsDir .. "/open-apps --netmanager"))

-- Audio Mixer
hl.bind("SUPER + ALT + M", hl.dsp.exec_cmd(scriptsDir .. "/open-apps --mixer"))

-- Clipboard
hl.bind("ALT + V", hl.dsp.exec_cmd(scriptsDir .. "/open-apps --clipboard"))

-- Screenshot
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd(scriptsDir .. "/open-apps --screenshot"))

-- Bluetooth
hl.bind("SUPER + ALT + B", hl.dsp.exec_cmd(scriptsDir .. "/open-apps --bluetooth"))

-- PowerMenu
hl.bind("SUPER + backspace", hl.dsp.exec_cmd(scriptsDir .. "/open-apps --powermenu"))

-- Keybindings help
hl.bind("SUPER + ALT + slash", hl.dsp.exec_cmd(scriptsDir .. "/open-apps --keybindings"))

-- Emoji selector
hl.bind("ALT + SHIFT + O", hl.dsp.exec_cmd(scriptsDir .. "/open-apps --emoji"))

-- |||----- Media Keys -----|||#

-- Volume up
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(scriptsDir .. "/volume --inc"), { locked = true, repeating = true })
-- Volume down
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(scriptsDir .. "/volume --dec"), { locked = true, repeating = true })
-- Mute
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(scriptsDir .. "/volume --toggle"), { locked = true, repeating = true })

-- Play/Pause
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
-- Next track
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
-- Previous track
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
-- Stop
hl.bind("XF86AudioStop", hl.dsp.exec_cmd("playerctl stop"), { locked = true })

-- Brightness up
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(scriptsDir .. "/brightness up"), { locked = true, repeating = true })
-- Brightness down
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(scriptsDir .. "/brightness down"), { locked = true, repeating = true })

-- |||----- Window Management -----|||#

-- Reload Hyprland
hl.bind("SUPER + ALT + R", hl.dsp.exec_cmd("hyprctl reload"))

-- Close windows
hl.bind("SUPER + q", hl.dsp.window.close())

-- Toggle floating
hl.bind("SUPER + s", hl.dsp.window.float({ action = "toggle" }))

-- Toggle fullscreen
hl.bind("SUPER + f", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

-- Tile back (force untile)
hl.bind("SUPER + t", hl.dsp.window.float({ action = "unset" }))

-- Toggle layout
-- hl.bind("SUPER + ALT + m", hl.dsp.layout("togglesplit"))

-- Focus left
hl.bind("SUPER + left", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + h", hl.dsp.focus({ direction = "left" }))
-- Focus down
hl.bind("SUPER + down", hl.dsp.focus({ direction = "down" }))
hl.bind("SUPER + j", hl.dsp.focus({ direction = "down" }))
-- Focus up
hl.bind("SUPER + up", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + k", hl.dsp.focus({ direction = "up" }))
-- Focus right
hl.bind("SUPER + right", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + l", hl.dsp.focus({ direction = "right" }))

-- Swap left
hl.bind("SUPER + CTRL + left", hl.dsp.window.move({ direction = "left" }))
hl.bind("SUPER + CTRL + h", hl.dsp.window.move({ direction = "left" }))
-- Swap down
hl.bind("SUPER + CTRL + down", hl.dsp.window.move({ direction = "down" }))
hl.bind("SUPER + CTRL + j", hl.dsp.window.move({ direction = "down" }))
-- Swap up
hl.bind("SUPER + CTRL + up", hl.dsp.window.move({ direction = "up" }))
hl.bind("SUPER + CTRL + k", hl.dsp.window.move({ direction = "up" }))
-- Swap right
hl.bind("SUPER + CTRL + right", hl.dsp.window.move({ direction = "right" }))
hl.bind("SUPER + CTRL + l", hl.dsp.window.move({ direction = "right" }))

-- Resize left
hl.bind("CTRL + ALT + left", hl.dsp.exec_cmd("hyprctl dispatch resizeactive -40 0"))
hl.bind("CTRL + ALT + H", hl.dsp.exec_cmd("hyprctl dispatch resizeactive -40 0"))
-- Resize right
hl.bind("CTRL + ALT + right", hl.dsp.exec_cmd("hyprctl dispatch resizeactive 40 0"))
hl.bind("CTRL + ALT + L", hl.dsp.exec_cmd("hyprctl dispatch resizeactive 40 0"))
-- Resize up
hl.bind("CTRL + ALT + up", hl.dsp.exec_cmd("hyprctl dispatch resizeactive 0 -40"))
hl.bind("CTRL + ALT + K", hl.dsp.exec_cmd("hyprctl dispatch resizeactive 0 -40"))
-- Resize down
hl.bind("CTRL + ALT + down", hl.dsp.exec_cmd("hyprctl dispatch resizeactive 0 40"))
hl.bind("CTRL + ALT + J", hl.dsp.exec_cmd("hyprctl dispatch resizeactive 0 40"))

-- Contract left
hl.bind("CTRL + SHIFT + ALT + left", hl.dsp.exec_cmd("hyprctl dispatch resizeactive 40 0"))
-- Contract right
hl.bind("CTRL + SHIFT + ALT + right", hl.dsp.exec_cmd("hyprctl dispatch resizeactive -40 0"))
-- Contract up
hl.bind("CTRL + SHIFT + ALT + up", hl.dsp.exec_cmd("hyprctl dispatch resizeactive 0 40"))
-- Contract down
hl.bind("CTRL + SHIFT + ALT + down", hl.dsp.exec_cmd("hyprctl dispatch resizeactive 0 -40"))

-- |||----- Workspace Switching -----|||#

-- Switch to workspace 1-10
for i = 1, 10 do
    local key = i % 10
    hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind("SUPER + ALT + " .. key, hl.dsp.window.move({ workspace = tostring(i) }))
end

-- Switch to workspace 1
hl.bind("SUPER + y", hl.dsp.focus({ workspace = 1 }))
-- Switch to workspace 2
hl.bind("SUPER + u", hl.dsp.focus({ workspace = 2 }))
-- Switch to workspace 3
hl.bind("SUPER + i", hl.dsp.focus({ workspace = 3 }))
-- Switch to workspace 4
hl.bind("SUPER + o", hl.dsp.focus({ workspace = 4 }))
-- Switch to workspace 5
hl.bind("SUPER + p", hl.dsp.focus({ workspace = 5 }))
-- Switch to workspace 6
hl.bind("SUPER + bracketleft", hl.dsp.focus({ workspace = 6 }))

-- Next workspace
hl.bind("SUPER + period", hl.dsp.focus({ workspace = "+1" }))
-- Previous workspace
hl.bind("SUPER + comma", hl.dsp.focus({ workspace = "-1" }))

-- Move window to workspace 1
hl.bind("SUPER + ALT + y", hl.dsp.window.move({ workspace = "1" }))
-- Move window to workspace 2
hl.bind("SUPER + ALT + u", hl.dsp.window.move({ workspace = "2" }))
-- Move window to workspace 3
hl.bind("SUPER + ALT + i", hl.dsp.window.move({ workspace = "3" }))
-- Move window to workspace 4
hl.bind("SUPER + ALT + o", hl.dsp.window.move({ workspace = "4" }))
-- Move window to workspace 5
hl.bind("SUPER + ALT + p", hl.dsp.window.move({ workspace = "5" }))
-- Move window to workspace 6
hl.bind("SUPER + ALT + bracketleft", hl.dsp.window.move({ workspace = "6" }))

-- Move to prev/next workspace
hl.bind("SUPER + ALT + h", hl.dsp.window.move({ workspace = "e-1" }))
hl.bind("SUPER + ALT + l", hl.dsp.window.move({ workspace = "e+1" }))

-- Scroll workspaces
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }), { mouse = true })
hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e-1" }), { mouse = true })

-- |||----- Mouse Bindings -----|||#

-- Move/resize windows with mouse
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + ALT + mouse:272", hl.dsp.window.resize(), { mouse = true })
