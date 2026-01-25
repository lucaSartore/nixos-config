{ config, pkgs, inputs, lib, ... }: {
  imports = [ 
    ../../modules/home.nix
    ../../modules/hyprpanel.desktop.nix
  ];
}
