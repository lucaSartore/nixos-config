local g = require("global");
local layouts = {"dwindle",  "master", "monocle"}

local function unbind_all()
  hl.unbind(g.mainMod .. " + H")
  hl.unbind(g.mainMod .. " + L")
  hl.unbind(g.mainMod .. " + K")
  hl.unbind(g.mainMod .. " + J")
end

local function set_normal_keybindings ()
  unbind_all()
  hl.bind(g.mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
  hl.bind(g.mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
  hl.bind(g.mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
  hl.bind(g.mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
end

local function set_monocle_keybindings ()
  unbind_all()
  hl.bind(g.mainMod .. " + H", hl.dsp.layout("cycleprev"))
  hl.bind(g.mainMod .. " + L", hl.dsp.layout("cyclenext"))
  hl.bind(g.mainMod .. " + K", hl.dsp.layout("cycleprev"))
  hl.bind(g.mainMod .. " + J", hl.dsp.layout("cyclenext"))
end

local function set_keybindings(layout_index)
  local layout = layouts[layout_index]
  if layout == "monocle" then
    set_monocle_keybindings()
  else
    set_normal_keybindings()
  end
end

local function get_workspace()
	if hl.get_active_special_workspace() then
		return hl.get_active_special_workspace()
	end
  return hl.get_active_workspace()
end

-- source https://wiki.hypr.land/Configuring/Advanced-and-Cool/Uncommon-tips-and-tricks/#cycle-layout-for-current-workspace
local function get_current_layout_index()
  local workspace = get_workspace()

  if not workspace then
    return 1
  end

  for i = 1, #layouts do
    if layouts[i] == workspace.tiled_layout then
      return i
    end
  end

  return 1
end

local function set_layout(layout_index)
  local layout = layouts[layout_index]

  local workspace = get_workspace()

  if not workspace then
    return
  end

	if workspace.special then
		hl.workspace_rule({ workspace = tostring(workspace.name), layout = layout })
	else
		hl.workspace_rule({ workspace = tostring(workspace.id), layout = layout })
	end
end

local function layout_next()
  local l = get_current_layout_index() + 1;
  if l == #layouts + 1 then l = 1 end
  set_layout(l)
  set_keybindings(l)
end

local function layout_prev()
  local l = get_current_layout_index() - 1;
  if l == 0 then l = #layouts end
  set_layout(l)
  set_keybindings(l)
end

hl.bind("SUPER + BRACKETLEFT", layout_prev)
hl.bind("SUPER + BRACKETRIGHT", layout_next)


-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/
hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/
hl.config({
    master = {
        new_status = "master",
    },
})
