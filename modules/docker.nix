{ config, pkgs, lib, inputs, ... }:

{

  # environment.systemPackages = with pkgs; [ pkgs.docker ];

  virtualisation.docker = {
    enable = true;
    # Set up resource limits
    daemon.settings = {
      experimental = true;
      default-address-pools = [{
        base = "172.30.0.0/16";
        size = 24;
      }];
    };
  };

  virtualisation.docker.enable = true;

  users.users.lucas.extraGroups = [ "docker" ];

}
