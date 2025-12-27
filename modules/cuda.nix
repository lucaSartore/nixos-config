{ config, pkgs, lib, inputs, ... }:

# source:
# https://wiki.nixos.org/wiki/CUDA

let
 nvidiaPackage = pkgs.linuxPackages.nvidiaPackages.stable;
in
{

  # environment.systemPackages = with pkgs; [ pkgs.docker ];

  environment.systemPackages = with pkgs; [
    cudatoolkit
    nvidiaPackage
    nvidia-container-toolkit
  ];

  nix.settings = {
    substituters = [
      "https://cuda-maintainers.cachix.org"
    ];
    trusted-public-keys = [
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
    ];
  };

  hardware.nvidia-container-toolkit.enable = true;


  environment.sessionVariables = {
    CUDA_PATH="${pkgs.cudatoolkit}";
    # LD_LIBRARY_PATH=${pkgs.nvidiaPackage}/lib
    # EXTRA_LDFLAGS="-L/lib -L${nvidiaPackage}/lib"
    # EXTRA_CCFLAGS="-I/usr/include"
  };

}
