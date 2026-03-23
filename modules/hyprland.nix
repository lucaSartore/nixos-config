{ config, pkgs, inputs, lib, pkgs-unstable, ... }: 
let 
  custom_sddm_astronaut = pkgs.sddm-astronaut.override {
    # embeddedTheme = "hyprland_kath";
    themeConfig = {
      Background = "${../assets/dotconfig/hypr/wallpapers/od_abstract.png}";
    };
  };
in
{
  imports = [
    ./hyprland.apps.nix
  ];

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
  
  # to sleep/wake up properly
  powerManagement.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };

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

    # to resize, move and disable multiple display
    pkgs.nwg-displays

    # simple vim-like keybindings with UI to launch stuff
    pkgs.wlr-which-key

    # theming for ssdm
    custom_sddm_astronaut
  ];


  # to handle the log in with multiple desktops (kde & hyprland)
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "sddm-astronaut-theme";
    extraPackages = [ custom_sddm_astronaut ];
    settings = {
      Theme = {
        Current = "sddm-astronaut-theme";
      };
    };
  };

  # Optional, hint Electron apps to use Wayland:
  # need to try this again in the future... currently
  # it does not work on some crucial apps such as vscode
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
