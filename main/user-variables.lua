-- {{{ Global Variable Definitions
-- moved here in module as local variable
-- }}}



local home = os.getenv("HOME")

local _M = {
  terminal = "kitty",
  modkey = "Mod4",

  wallpaper = home .. "/.config/awesome/wall.png",

  altkey = "Mod1"
  
}

return _M

