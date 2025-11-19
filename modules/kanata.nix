{ config, pkgs, lib, ... }:
{

  environment.systemPackages = with pkgs; [
    pkgs.kanata
  ];

  services.kanata.enable = true;
  services.kanata.keyboards.main-keyboard.configFile = lib.mkDefault "/home/lucas/.config/kanata/kanata.kbd";

  # override the def config to allow access to the config file
  systemd.services.kanata-main-keyboard.serviceConfig = {
    ProtectHome = lib.mkForce "tmpfs";
    BindReadOnlyPaths = [ 
      "/home/lucas/.config/kanata/kanata.kbd"
    ];
  };
}
