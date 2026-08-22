local function ensure_file(name, default_content)
    local dir = (debug.getinfo(1, "S").source:match("@(.*/)")) or "./"
    local path = dir .. name .. ".lua"

    local f = io.open(path, "r")
    if f then
        f:close()
    else
        local out = io.open(path, "w")
        if out then
            out:write(default_content)
            out:close()
        end
    end
end

ensure_file("monitors", "-- auto-generated placeholder, will be overwritten by nwg-displays\nreturn {}\n")
ensure_file("workspaces", "-- auto-generated placeholder, will be overwritten by nwg-displays\nreturn {}\n")

require("monitors")
require("workspaces")
