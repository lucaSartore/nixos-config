{ config, pkgs, lib, inputs, ... }: {

  nixpkgs.overlays = let
    nix-matlab = import (builtins.fetchTarball {
      url =
        "https://gitlab.com/doronbehar/nix-matlab/-/archive/master/nix-matlab-master.tar.gz";
    });
  in [
    nix-matlab.overlay
    (final: prev:
      {
        # Your own overlays...
      })
  ];
  # default os packages
  environment.systemPackages = with pkgs;
    [
      pkgs.matlab

    ];
}
