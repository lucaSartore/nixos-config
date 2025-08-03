{ config, pkgs, lib, ... }:

{

  environment.systemPackages = with pkgs; [
    pkgs.ghostty
  ];

}
