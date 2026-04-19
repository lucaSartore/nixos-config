{ config, pkgs, lib, ... }:

{
  imports = [ 
    ../../modules/home.nix
    ../../modules/hyprland.home.panels.laptop.nix
  ];
}
