{ config, pkgs, lib, ... }:

{
    programs.plasma = {
        enable = true;
        workspace = {
          lookAndFeel = "org.kde.breezedark.desktop";
        };
    };
}
