-- Autostart Applications
local home = os.getenv("HOME")

hl.on("hyprland.start", function()
    -- Cursor theme
    hl.dispatch(hl.dsp.exec_cmd("hyprctl setcursor Qogir-dark 24"))

    -- Environment setup
    hl.dispatch(hl.dsp.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_CLASS XDG_SESSION_TYPE"))
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

    -- Tmux session setup
    hl.dispatch(hl.dsp.exec_cmd("bash -c 'if ! tmux has-session -t Kitty 2>/dev/null; then tmux new-session -d -s Kitty -n Term; tmux new-window -t Kitty -n nvim; tmux send-keys -t Kitty:nvim \"lnt && nvim\" C-m; fi'"))
    hl.dispatch(hl.dsp.exec_cmd("bash -c 'tmux select-window -t Kitty:Term'"))
    hl.dispatch(hl.dsp.exec_cmd("bash -c 'if ! tmux has-session -t Home 2>/dev/null; then tmux new-session -d -s Home -n Yazi; tmux send-keys -t Home:Yazi \"yazi\" C-m; fi'"))

    -- Kitty on workspace 3
    hl.dispatch(hl.dsp.exec_cmd("kitty sh -c 'tmux attach-session -t Kitty'", { workspace = "3 silent" }))

    -- Nautilus on workspace 5
    hl.dispatch(hl.dsp.exec_cmd("nautilus", { workspace = "5 silent" }))

    -- Return to workspace 1 after delay
    hl.timer(function()
        hl.dispatch(hl.dsp.exec_cmd("hyprctl dispatch workspace 1"))
        os.execute("notify-send 'Welcome back' 'All set. You are ready to go.'")
    end, { timeout = 2000, type = "oneshot" })
end)
