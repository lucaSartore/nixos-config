local g = require("global");
local layouts = {"dwindle",  "master", "monocle"}



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
end

local function layout_prev()
  local l = get_current_layout_index() - 1;
  if l == 0 then l = #layouts end
  set_layout(l)
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


-- default layout
hl.config({
    general = {
        layout = "dwindle",
    }
})
