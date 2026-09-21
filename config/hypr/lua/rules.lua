-- Layer Rules
hl.layer_rule({ name = "blur-rofi", match = { namespace = "rofi" }, blur = true, ignore_alpha = 0.1 })
hl.layer_rule({ name = "blur-notif", match = { namespace = "notifications" }, blur = true, ignore_alpha = 0.2 })

-- Window Rules
hl.window_rule({ name = "rofi-anim", match = { class = "^Rofi$" }, animation = "popin" })

hl.window_rule({ name = "float-floaterm", match = { class = "^FloaTerm$" }, float = true, center = true, size = { 696, 399 } })
hl.window_rule({ name = "float-updating", match = { class = "^Updating$" }, float = true, pin = true, center = true, size = { 390, 405 } })
hl.window_rule({ name = "float-scratch", match = { class = "^Scratch$" }, float = true, pin = true })
hl.window_rule({ name = "float-mpv", match = { class = "^mpv$" }, float = true, center = true, size = { 723, 407 } })
hl.window_rule({ name = "float-viewnior", match = { class = "^Viewnior$" }, float = true, center = true })
hl.window_rule({ name = "float-pavucontrol", match = { class = "^pavucontrol$" }, float = true, center = true })
hl.window_rule({ name = "float-yazi", match = { class = "^YaziTerm$" }, float = true, center = true, size = { 900, 342 } })
hl.window_rule({ name = "float-music", match = { class = "^MusicTerm$" }, float = true, center = true, size = { 656, 343 } })
hl.window_rule({ name = "float-fetch", match = { class = "^FetchTerm$" }, float = true, center = true, size = { 369, 601 } })
hl.window_rule({ name = "float-ffscratch", match = { class = "^scratch-firefox$" }, float = true, size = "75% 85%" })

-- Workspace Rules
hl.window_rule({ name = "ws4-telegram", match = { class = "^TelegramDesktop$" }, workspace = "4" })
hl.window_rule({ name = "ws5-thunar", match = { class = "^Thunar$" }, workspace = "5" })
hl.window_rule({ name = "ws3-firefox", match = { class = "^firefox$" }, workspace = "3" })
hl.window_rule({ name = "ws3-navigator", match = { class = "^Navigator$" }, workspace = "3" })
