{ config, pkgs, lib, ... }:

{

    programs.plasma = {
        enable = true;
        workspace = {
          colorScheme = "Gray";
          iconTheme = "Papirus-Dark";
        };

        configFile = {
            "kdeglobals"."KDE"."widgetStyle" = "Darkly";
        }
    };
}
