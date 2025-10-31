{ config, pkgs, inputs, lib, pkgs-unstable, ... }: {
  programs.hyprland.enable = true; # enable Hyprland

  # kwallet: the kde software to store passwords
  security.pam.services.lucas.kwallet = {
    enable = true;
    package = pkgs.kdePackages.kwallet-pam;
  };

  # font for the OS
  fonts.packages = [
    pkgs.jetbrains-mono
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.twitter-color-emoji
  ];

  environment.systemPackages = with pkgs; [
    # ... other packages

    # menu
    rofi-wayland
    # packages for screen sharing
    # adding this brake screen sharing in KDE... uncomment them when fully switch to hyperland
    # pkgs.pipewire
    # pkgs.wireplumber

    # handel app request fore elevated permissions
    hyprpolkitagent

    # status bar
    pkgs-unstable.ashell

  ];

  # Optional, hint Electron apps to use Wayland:
  # need to try this again in the future... currently
  # it does not work on some crucial apps such as vscode
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
