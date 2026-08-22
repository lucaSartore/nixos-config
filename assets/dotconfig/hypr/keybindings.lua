local g = require("global")

hl.bind(g.mainMod .. " + T", hl.dsp.exec_cmd(g.terminal))
hl.bind(g.mainMod .. " + S", hl.dsp.exec_cmd(g.menu))
hl.bind(g.mainMod .. " + E", hl.dsp.exec_cmd(g.fileManager))
hl.bind(g.mainMod .. " + B", hl.dsp.exec_cmd(g.browser))
hl.bind(g.mainMod .. " + ESCAPE", hl.dsp.window.close())

hl.bind("SUPER + SUPER_L", hl.dsp.exec_cmd(g.start), { release = true })
hl.bind("SUPER + SUPER_R", hl.dsp.exec_cmd(g.start), { release = true })

hl.bind(g.mainMod .. " + W", hl.dsp.window.float({ action = "toggle" }))
hl.bind(g.mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))

-- NOTE: the following keybindings:
--  - mainMod + H
--  - mainMod + L
--  - mainMod + K
--  - mainMod + J
-- are defined in layouts.lua, as their behavior is dependent on the layout we are currently in


-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(g.mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(g.mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(g.mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(g.mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(g.mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(g.mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Resizing windows with the keyboard (submap)
hl.bind(g.mainMod .. " + R", hl.dsp.submap("resize"))
hl.define_submap("resize", function()
    hl.bind("L", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { repeating = true })
    hl.bind("H", hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { repeating = true })
    hl.bind("K", hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { repeating = true })
    hl.bind("J", hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true })
    hl.bind("ESCAPE", hl.dsp.submap("reset"))
end)

-- moving windows around
hl.bind(g.mainMod .. " + SHIFT + H", hl.dsp.window.swap({ direction = "left" }))
hl.bind(g.mainMod .. " + SHIFT + H", hl.dsp.window.move({ x = -50, y = 0, relative = true }), { repeating = true })
hl.bind(g.mainMod .. " + SHIFT + L", hl.dsp.window.swap({ direction = "right" }))
hl.bind(g.mainMod .. " + SHIFT + L", hl.dsp.window.move({ x = 50, y = 0, relative = true }), { repeating = true })
hl.bind(g.mainMod .. " + SHIFT + K", hl.dsp.window.swap({ direction = "up" }))
hl.bind(g.mainMod .. " + SHIFT + K", hl.dsp.window.move({ x = 0, y = -50, relative = true }), { repeating = true })
hl.bind(g.mainMod .. " + SHIFT + J", hl.dsp.window.swap({ direction = "down" }))
hl.bind(g.mainMod .. " + SHIFT + J", hl.dsp.window.move({ x = 0, y = 50, relative = true }), { repeating = true })

-- Moving windows with the keyboard
-- NOTE: hl.dsp.window.swap() and the "move by pixels while staying floating"
-- dispatcher weren't fully confirmed for the Lua API — double-check the
-- exact function names/args on the wiki's dispatcher reference before use.

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
