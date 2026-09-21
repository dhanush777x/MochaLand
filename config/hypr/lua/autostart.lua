-- Autostart Applications
local home = os.getenv("HOME")

hl.on("hyprland.start", function()
    -- Cursor theme
    hl.dispatch(hl.dsp.exec_cmd("hyprctl setcursor Qogir-dark 24"))

    -- Environment setup
    hl.dispatch(hl.dsp.exec_cmd(
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_CLASS XDG_SESSION_TYPE"))
    hl.dispatch(hl.dsp.exec_cmd("systemctl --user restart xdg-desktop-portal-hyprland"))
    hl.dispatch(hl.dsp.exec_cmd("systemctl --user restart xdg-desktop-portal"))

    -- Core services
    hl.dispatch(hl.dsp.exec_cmd("waybar"))
    hl.dispatch(hl.dsp.exec_cmd("dunst -config " .. home .. "/.config/hypr/dunstrc"))
    hl.dispatch(hl.dsp.exec_cmd("hyprpaper"))
    hl.dispatch(hl.dsp.exec_cmd("clipcatd --replace"))
    hl.dispatch(hl.dsp.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1"))
    hl.dispatch(hl.dsp.exec_cmd("pypr"))
    hl.dispatch(hl.dsp.exec_cmd(home .. "/.config/hypr/scripts/apply-theme"))

    -- Launch apps on specific workspaces
    hl.dispatch(hl.dsp.exec_cmd("brave-origin-beta", { workspace = "1 silent" }))

    -- Kitty with Herdr on workspace 3
    hl.dispatch(hl.dsp.exec_cmd("kitty -e herdr", {
        workspace = "3 silent"
    }))

    -- Nautilus on workspace 5
    hl.dispatch(hl.dsp.exec_cmd("nautilus", { workspace = "5 silent" }))

    -- Return to workspace 1 after delay
    hl.timer(function()
        hl.dispatch(hl.dsp.exec_cmd("hyprctl dispatch workspace 1"))
        os.execute("notify-send 'Welcome back' 'All set. You are ready to go.'")
    end, { timeout = 2000, type = "oneshot" })
end)
