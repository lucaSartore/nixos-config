{ config, pkgs, lib, inputs, ... }:

{

  # environment.systemPackages = with pkgs; [ pkgs.docker ];

  environment.systemPackages = with pkgs; [
    docker-compose 
    devpod-desktop
  ];

  virtualisation.docker = {
    enable = true;
    # do not start on boot. prefer starting it manually if needed
    enableOnBoot = false;
    # Set up resource limits
    daemon.settings = {
      experimental = true;
      default-address-pools = [{
        base = "172.30.0.0/16";
        size = 24;
      }];
    };
  };

  users.users.lucas.extraGroups = [ "docker" ];
}
