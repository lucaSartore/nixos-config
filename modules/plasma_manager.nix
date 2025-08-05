{ config, pkgs, lib, ... }:

{

  programs.plasma = {
    enable = true;
    # this is useful when testing to remove all previous settings and just use this configuration's one
    overrideConfig = true;
    workspace = {
      colorScheme = "Darkly";
      iconTheme = "Papirus-Dark";
    };

    panels = [
      # Windows-like panel at the bottom
      {
        location = "bottom";
        widgets = [
          #command reminder to find the widgets names (set them with the UI first)
          #grep "plugin=" ~/.config/plasma-org.kde.plasma.desktop-appletsrc 
          "org.kde.plasma.kickoff"
          "org.kde.plasma.icontasks"
          "org.kde.plasma.marginsseparator"
          "org.kde.plasma.systemmonitor.net"
          "org.kde.plasma.systemmonitor.cpucore"
          "org.kde.plasma.systemmonitor.memory"
          "org.kde.plasma.systemtray"
          "org.kde.plasma.showdesktop"
        ];
      }
    ];

    configFile = {
      # global application themes
      "kdeglobals"."KDE"."widgetStyle" = "Darkly";
      # scale of fonts/ui elements
      "kwinrc"."Xwayland"."Scale" = 1.5;
      # number of virtual desktops
      "kwinrc"."Desktops"."Number" = 3;
      # Speed up animations compared to normal
      "kdeglobals"."KDE"."AnimationDurationFactor" = 0.35355339059327373;
    };
  };
}
