{ config, pkgs, pkgs-unstable, lib, inputs, ... }:

{
  environment.systemPackages = [
    (pkgs.writeScriptBin "workpod" (builtins.readFile ../assets/scripts/workpod.sh))
  ];
}
