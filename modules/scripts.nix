{ config, pkgs, pkgs-unstable, lib, inputs, ... }:

{
  environment.systemPackages = [
    (pkgs.writeScriptBin "workpod" (builtins.readFile ../assets/scripts/workpod.sh))
    (pkgs.writeScriptBin "webp2png" (builtins.readFile ../assets/scripts/webp2png.sh))
  ];
}
