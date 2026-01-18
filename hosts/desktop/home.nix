{ config, pkgs, inputs, lib, ... }:
{
  imports = [ ../../modules/home.nix ];

  # override to remove bluetooth and battery
  programs.hyprpanel.settings.bar.layouts.right = [
    "media"
    "clock"

    "separator" #########

    "volume"
    "network"
    # "bluetooth"
    # "battery"
     
    "separator" #########

    "hyprsunset"
    "systray"
    "notifications"
    "power"
  ];
}
