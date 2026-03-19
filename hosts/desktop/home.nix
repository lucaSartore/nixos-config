{ config, pkgs, inputs, lib, ... }: {
  imports = [ 
    ../../modules/home.nix
    ../../modules/hyprland.home.panels.desktop.nix
  ];
}
