
-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
hl.on("hyprland.start", function()
    -- handle authentication
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("hyprpanel")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("udiskie")
    hl.exec_cmd("/run/current-system/sw/libexec/polkit-kde-authentication-agent-1")
    -- currently set in here, as it does not scale properly if setted otherwise
    hl.exec_cmd("hyprctl setcursor Bibata-Modern-Classic 16")
end)
