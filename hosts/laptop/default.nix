{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = "laptop-luca";

  boot.loader.grub.efiSupport = true;

  # Enable OpenGL
  hardware.graphics = { enable = true; };

  environment.systemPackages = [ pkgs.kdePackages.wacomtablet ];
}
