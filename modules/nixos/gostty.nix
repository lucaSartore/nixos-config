{ config, pkgs, lib, ... }:

{

  environment.systemPackages = with pkgs; [
    pkgs.ghostty
    pkgs.atuin # cool bash history
  ];

  services.atuin.enable = true;

}
