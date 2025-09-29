{ config, pkgs, inputs, lib, ... }: {
  programs.hyprland.enable = true; # enable Hyprland

  environment.systemPackages = [
    # ... other packages

    # menu
    pkgs.wofi
    # packages for screen sharing
    pkgs.pipewire
    pkgs.wireplumber
  ];

  # Optional, hint Electron apps to use Wayland:
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
