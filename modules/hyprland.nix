{ config, pkgs, inputs, lib, ... }: {
  programs.hyprland.enable = true; # enable Hyprland

  environment.systemPackages = [
    # ... other packages

    # menu
    pkgs.rofi-wayland
    # packages for screen sharing
    # adding this brake screen sharing in KDE... uncomment them when fully switch to hyperland
    # pkgs.pipewire
    # pkgs.wireplumber
    # handel app authentication
    pkgs.hyprpolkitagent
  ];

  # Optional, hint Electron apps to use Wayland:
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
