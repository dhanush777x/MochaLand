-- Decoration Settings
hl.config({
    decoration = {
        rounding       = 12,
        active_opacity   = 0.90,
        inactive_opacity = 0.85,

        blur = {
            enabled            = true,
            size               = 8,
            passes             = 3,
            ignore_opacity     = true,
            new_optimizations  = true,
            xray               = false,
            popups             = true,
        },

        shadow = {
            enabled      = true,
            range        = 12,
            render_power = 3,
            color        = 0xee000000,
        },
    },
})
