-- General Settings
local colors = require("lua/colors")

hl.config({
    general = {
        gaps_in    = 5,
        gaps_out   = 5,
        border_size = 1,

        col = {
            active_border         = "rgb(" .. colors.magenta .. ")",
            inactive_border       = "rgb(" .. colors.inactive .. ")",
            nogroup_border        = "rgb(" .. colors.magenta .. ")",
            nogroup_border_active = "rgb(" .. colors.magenta .. ")",
        },

        resize_on_border   = true,
        allow_tearing      = false,
        layout             = "dwindle",
        no_focus_fallback  = false,
    },
})
