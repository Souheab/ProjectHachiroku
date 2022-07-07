local awful = require("awful")
local gears = require("gears")
local hotkeys_popup = require("awful.hotkeys_popup")
local modkey = RC.vars.modkey
local altkey = RC.vars.altkey
local terminal = RC.vars.terminal
local polybar_status = true



local _M = {}

function _M.get()
  
    local globalkeys = gears.table.join(
-- Show help
awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
    {description="show help", group="awesome"}),

-- Tag browsing
awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
    {description = "view previous", group = "tag"}),
awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
    {description = "view next", group = "tag"}),
awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
    {description = "go back", group = "tag"}),

-- Default client focus
awful.key({ altkey,           }, "j",
function ()
  awful.client.focus.byidx( 1)
end,
{description = "focus next by index", group = "client"}
),
awful.key({ altkey,           }, "k",
function ()
  awful.client.focus.byidx(-1)
end,
{description = "focus previous by index", group = "client"}
),

-- By-direction client focus
awful.key({ modkey }, "j",
function()
  awful.client.focus.global_bydirection("down")
  if client.focus then client.focus:raise() end
end,
{description = "focus down", group = "client"}),
awful.key({ modkey }, "k",
function()
  awful.client.focus.global_bydirection("up")
  if client.focus then client.focus:raise() end
end,
{description = "focus up", group = "client"}),
awful.key({ modkey }, "h",
function()
  awful.client.focus.global_bydirection("left")
  if client.focus then client.focus:raise() end
end,
{description = "focus left", group = "client"}),
awful.key({ modkey }, "l",
function()
  awful.client.focus.global_bydirection("right")
  if client.focus then client.focus:raise() end
end,
{description = "focus right", group = "client"}),

-- Menu
awful.key({ modkey,           }, "w", function () RC.mainmenu:show() end,
    {description = "show main menu", group = "awesome"}),

-- Layout manipulation
awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.global_bydirection("down")    end,
    {description = "swap with the client below", group = "client"}),
awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.global_bydirection("up")    end,
    {description = "swap with the client above", group = "client"}),
awful.key({ modkey, "Shift"   }, "h", function () awful.client.swap.global_bydirection("left")    end,
    {description = "swap with the client to the left", group = "client"}),
awful.key({ modkey, "Shift"   }, "l", function () awful.client.swap.global_bydirection("right")    end,
    {description = "swap with the client to the right", group = "client"}),

awful.key({ altkey, "Shift"   }, "j", function () awful.client.swap.byidx( 1)    end,
    {description = "swap with previous client by index", group = "client"}),
awful.key({ altkey, "Shift"   }, "k", function () awful.client.swap.byidx(-1)    end,
    {description = "swap with next client by index", group = "client"}),

awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
    {description = "focus the next screen", group = "screen"}),
awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
    {description = "focus the previous screen", group = "screen"}),
awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
    {description = "jump to urgent client", group = "client"}),
awful.key({ modkey,           }, "Tab",
function ()
  if cycle_prev then
      awful.client.focus.history.previous()
  else
      awful.client.focus.byidx(-1)
  end
  if client.focus then
      client.focus:raise()
  end
end,
{description = "cycle with previous/go back", group = "client"}),

awful.key({modkey, "Control" }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
awful.key({ modkey, "Control"    }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),

awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
{description = "select next", group = "layout"}),
awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
{description = "select previous", group = "layout"}),

-- Show/hide polybar 
awful.key({ modkey }, "b", function ()
    os.execute("killall polybar")
    if(polybar_status) then
      polybar_status=false
    else
    awful.spawn("polybar")
	  polybar_status=true
    end
end,
{description = "toggle polybar", group = "awesome"}),



-- Standard program
awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
    {description = "open a terminal", group = "launcher"}),
awful.key({ modkey, "Control" }, "r", awesome.restart,
    {description = "reload awesome", group = "awesome"}),
awful.key({ modkey, "Shift"   }, "q", awesome.quit,
    {description = "quit awesome", group = "awesome"}),

awful.key({ modkey, "Control" }, "n", function ()
local c = awful.client.restore()
-- Focus restored client
if c then
  c:emit_signal("request::activate", "key.unminimize", {raise = true})
end
end, {description = "restore minimized", group = "client"}),
-- Volume
awful.key({ }, "XF86AudioMute", function () 
  os.execute("pactl set-sink-mute @DEFAULT_SINK@ toggle")
end,
    {description = "Mute Volume", group = "hotkeys"}),
-- Volume Lower 
awful.key({ }, "XF86AudioLowerVolume", function () 
  os.execute("pactl -- set-sink-volume 0 -1%")
end,
    {description = "Lower Volume", group = "hotkeys"}),
-- Volume Raise
awful.key({ }, "XF86AudioRaiseVolume", function () 
  os.execute("pactl -- set-sink-volume 0 +1%")
end,
    {description = "Raise Volume", group = "hotkeys"}),
-- Mic Mute
awful.key({ }, "XF86AudioMicMute", function () 
  os.execute("amixer set Capture toggle")
end,
    {description = "Mute Mic", group = "hotkeys"}),
-- Screen brightness
awful.key({ }, "XF86MonBrightnessUp", function () 
  os.execute("xbacklight -inc 10")
end,
    {description = "+10%", group = "hotkeys"}),
awful.key({ }, "XF86MonBrightnessDown", function () 
    os.execute("xbacklight -dec 10") end,
    {description = "-10%", group = "hotkeys"}),

    -- rofi
  awful.key({ modkey }, "p", function ()
    os.execute(string.format("rofi -show %s",
    'drun -drun-display-format {name}'))
  end,
  {description = "show rofi", group = "launcher"}),

  -- rofi emoji

  awful.key({ modkey }, ".", function ()
    os.execute(string.format("rofi -show %s",
    'emoji'))
  end,
  {description = "show rofi emoji menu", group = "launcher"}),

  --rofi window switch

  awful.key({ modkey, "Shift" }, "Tab", function ()
    os.execute(string.format("rofi -show %s",
    'windowcd'))
  end,
  {description = "show rofi window menu", group = "launcher"}),
  --]]

-- Lock Screen
awful.key({altkey, "Shift" }, "l", function () 
  os.execute("light-locker-command -l")
end,
    {description = "Lock Screen", group = "hotkeys"}),

-- Clipboard
awful.key({ modkey }, "c", function ()
	os.execute("copyq menu")
end,
	{description = "Show clipboard", group = "hotkeys"})

  --]]
          
          )

          
      return globalkeys

end

return setmetatable({}, { __call = function(_, ...) return _M.get(...) end })

