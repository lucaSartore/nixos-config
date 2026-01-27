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
    # menu
    rofi

    # packages for screen sharing
    # adding this brake screen sharing in KDE... uncomment them when fully switch to hyperland
    # pkgs.pipewire
    # pkgs.wireplumber

    # handel app request fore elevated permissions
    hyprpolkitagent

    # used for blue-light
    hyprsunset

    #wallpaper utility
    pkgs-unstable.hyprpaper

    # custom alias that run a shell with the network manager tui
    (pkgs.writeShellScriptBin "calias-network-manager" ''
        #!/bin/sh
        ghostty --class=float.custom -e "sleep 0.1 && nmtui"
      '')
    # custom alias that run a b-top shell
    (pkgs.writeShellScriptBin "calias-btop-shell" ''
        #!/bin/sh
        ghostty --class=float.custom -e "sleep 0.1 && btop"
      '')

  ];



  # Optional, hint Electron apps to use Wayland:
  # need to try this again in the future... currently
  # it does not work on some crucial apps such as vscode
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
