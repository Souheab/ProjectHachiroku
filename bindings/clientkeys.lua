-- Standard Awesome library
local gears = require("gears")
local awful = require("awful")
local naughty = require("naughty")

-- Custom Local Library
-- local titlebar = require("anybox.titlebar")

local _M = {}
local modkey = RC.vars.modkey

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function _M.get()
  local clientkeys = gears.table.join(
    awful.key({ modkey,           }, "f",
      function (c)
        c.fullscreen = not c.fullscreen
        c:raise()
        -- local polybar = function (c) return awful.rules.match(c, {instance = "polybar"}) end
        -- local temp
        -- for c in awful.client.iterate(polybar) do
        --   temp = c
        -- end 
        -- temp.minimized = true
        -- temp:raise()

      end,
      {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey,    }, "q",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
      function (c)
        -- The client currently has the input focus, so it cannot be
        -- minimized, since minimized clients can't have the focus.
        c.minimized = true
      end ,
      {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
      function (c)
        if (c.fullscreen)
        then
          c.fullscreen = not c.fullscreen
		  c.maximized = false
        end
        c.maximized = not c.maximized
        c:raise()
      end ,
      {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "m",
      function (c)
        c.maximized_vertical = not c.maximized_vertical
        c:raise()
      end ,
      {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift"   }, "m",
      function (c)
        c.maximized_horizontal = not c.maximized_horizontal
        c:raise()
      end ,
      {description = "(un)maximize horizontally", group = "client"}),
    awful.key({ modkey, "Shift" }, "b",
      awful.titlebar.toggle,
      {description = "toggle title bar", group = "client"}),

    awful.key({modkey, "Control"    }, "k",     function () awful.client.incwfact( 0.05)    end , 
      {description = "increase master height factor", group = "client"}),
    awful.key({modkey, "Control"    }, "j",     function () awful.client.incwfact(-0.05)    end,
 {description = "increase master height factor", group = "client"})
  )

  return clientkeys
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

return setmetatable({}, { __call = function(_, ...) return _M.get(...) end })
