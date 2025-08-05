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

    # panels = [
    #   # Windows-like panel at the bottom
    #   {
    #     location = "bottom";
    #     widgets = [
    #       "org.kde.plasma.kickoff"
    #       "org.kde.plasma.icontasks"
    #       "org.kde.plasma.marginsseparator"
    #       "org.kde.plasma.systemtray"
    #       "org.kde.plasma.digitalclock"
    #     ];
    #   }
    #   # Global menu at the top
    #   {
    #     location = "top";
    #     height = 26;
    #     widgets = [ "org.kde.plasma.appmenu" ];
    #   }
    # ];

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
