{ config, pkgs, lib, ... }:

{
  #Note: this comment return the entire list of options, so that you can discover the syntax and then set it manually
  #nix run github:nix-community/plasma-manager

  programs.plasma = {
    enable = true;
    # this is useful when testing to remove all previous settings and just use this configuration's one
    overrideConfig = true;
    workspace = {
      colorScheme = "Darkly";
      iconTheme = "Papirus-Dark";
    };

    panels = [
      {
        location = "bottom";
        widgets = [
          #command reminder to find the widgets names (set them with the UI first)
          #grep "plugin=" ~/.config/plasma-org.kde.plasma.desktop-appletsrc 
          {
            name = "org.kde.plasma.kickoff";
            config = {
              General = {
                icon = "nix-snowflake-white";
                alphaSort = true;
              };
            };
          }
          {
            name = "org.kde.plasma.icontasks";
            config = {
              General = {
                # to list all of hte available applications, run
                # cd /run/current-system/sw/share/applications/ && ls
                launchers = [
                  "applications:org.kde.dolphin.desktop"
                  "applications:google-chrome.desktop"
                  "applications:code.desktop"
                  "applications:com.mitchellh.ghostty.desktop"
                ];
              };
            };
          }
          "org.kde.plasma.marginsseparator"
          "org.kde.plasma.systemmonitor.net"
          "org.kde.plasma.systemmonitor.cpucore"
          "org.kde.plasma.systemmonitor.memory"
          "org.kde.plasma.systemtray"
          "org.kde.plasma.digitalclock"
          "org.kde.plasma.showdesktop"
        ];
      }
    ];

    configFile = {
      # global application themes
      "kdeglobals"."KDE"."widgetStyle" = "Darkly";
      # scale of fonts/ui elements
      "kwinrc"."Xwayland"."Scale" = 1.5;
      # 3 virtual desktop in one single row
      "kwinrc"."Desktops"."Number" = 3;
      "kwinrc"."Desktops"."Rows" = 1;
      # Speed up animations compared to normal
      "kdeglobals"."KDE"."AnimationDurationFactor" = 0.35355339059327373;
      # Enabling krohnkite (the tiling window manager) 
      "kwinrc"."Plugins"."krohnkiteEnabled" = true;
      # do not re-open old window when re-booting
      "ksmserverrc"."General"."loginMode" = "emptySession";
      # This disable the (annoying) feature that allow you to show all virtual desktops
      # when moving the mouse to the top-left corner of the screen
      "kwinrc"."Effect-overview"."BorderActivate" = 9;
    };

    shortcuts = {
          ksmserver = {
            "Lock Session" = [
              "Screensaver"
              "Meta+Ctrl+Alt+L"
            ];
          };

          kwin = {
              # Manage Krohnkite layouts
              "KrohnkiteIncrease" = "Meta+I";
              "KrohnkiteDecrease" = "Meta+Shift+I";
              "KrohnkiteFocusNext" = "Meta+Shift+\\";
              "KrohnkiteFocusPrev" = "Meta+\\";

              # 3 most useful layouts
              "KrohnkiteTileLayout" = "Meta+Shift+T";
              "KrohnkiteTreeColumnLayout" = "Meta+Shift+C";
              "KrohnkiteBTreeLayout" = "Meta+Shift+B";

              # Move in and out float layout
              "KrohnkiteFloatAll" = "Meta+T";

              # Window management
              "Expose" = "Meta+,";
              "Window Close" = "Meta+Q";
              "Window Minimize" = "Meta+M";
              "Window Fullscreen" = "Meta+F";

              # move between windows
              "KrohnkiteFocusLeft" = "Meta+H";
              "KrohnkiteFocusDown" = "Meta+J";
              "KrohnkiteFocusUp" = "Meta+K";
              "KrohnkiteFocusRight" = "Meta+L";

              # Mve windows around
              "KrohnkiteShiftLeft" = "Meta+Shift+H";
              "KrohnkiteShiftDown" = "Meta+Shift+J";
              "KrohnkiteShiftUp" = "Meta+Shift+K";
              "KrohnkiteShiftRight" = "Meta+Shift+L";

              # set of options to resize the windows
              "KrohnkiteShrinkWidth" = "Meta+Ctrl+H";
              "KrohnkiteGrowHeight" = "Meta+Ctrl+J";
              "KrohnkiteShrinkHeight" = "Meta+Ctrl+K";
              "KrohnkitegrowWidth" = "Meta+Ctrl+L";
          };

        };
      };
}
