{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  networking.hostName = "desktop-luca";
}
