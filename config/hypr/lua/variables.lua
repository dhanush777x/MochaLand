-- App Variables
local terminal    = "kitty"
local fileManager = "pcmanfm"
local browser     = "brave-origin-beta"
local menu        = "rofi -show drun -theme " .. os.getenv("HOME") .. "/.config/hypr/rofi/style-1.rasi"
local scriptsDir  = os.getenv("HOME") .. "/.config/hypr/scripts"

return {
    terminal    = terminal,
    fileManager = fileManager,
    browser     = browser,
    menu        = menu,
    scriptsDir  = scriptsDir,
}
