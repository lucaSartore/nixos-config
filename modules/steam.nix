{ config, pkgs, lib, ... }: {

  environment.systemPackages = with pkgs; [ 

    # launcher for GOG, epic and amazon games
    pkgs.heroic

    pkgs.steam-run


    # utility command to put in the lauch args of steam
    # example: gamemode-run <game>
    (pkgs.writeShellScriptBin "gamemode-run" ''
      gamescope -f -W 3440 -H 1440 -r 159.96 -- "$@"
    '')
  ];

  programs.steam = {
    enable = true;
    # Open ports in the firewall for Steam Remote Play
    # remotePlay.openFirewall = true;
    # Open ports in the firewall for Source Dedicated Server
    # dedicatedServer.openFirewall = true;
  };

  programs.gamescope = {
    enable = true;
    capSysNice = true; # Allows Gamescope to use high-priority scheduling
  };

  programs.steam.extraCompatPackages = with pkgs; [
    proton-ge-bin
  ];


}
