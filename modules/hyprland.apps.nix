{ config, pkgs, inputs, lib, pkgs-unstable, ... }: {
  
  # https://github.com/NixOS/nixpkgs/issues/409986
  # may need to run kbuildsycoca6 for changes to take effect
  environment.etc."xdg/menus/applications.menu".source = "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";


  environment.systemPackages =  [
    # taken from KDE
    pkgs.kdePackages.dolphin
    pkgs.kdePackages.kservice
    pkgs.kdePackages.plasma-workspace
    pkgs.kdePackages.ark
    pkgs.kdePackages.okular
    # video
    pkgs.mpv
    pkgs.vlc
    # images
    pkgs.loupe
    pkgs.ksnip
  ];
}
