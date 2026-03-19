{ config, pkgs, inputs, lib, pkgs-unstable, ... }: {
  
  # https://github.com/NixOS/nixpkgs/issues/409986
  environment.etc."xdg/menus/applications.menu".source = ./dolphin.menu;


  environment.systemPackages =  [
    # file manager
    pkgs.kdePackages.dolphin
  ];
}
