{
  description = "ROS development environment for the course \"Optimization and learning for robot control\"";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        python = pkgs.python3;
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            python
            pkgs.colcon-core
            pkgs.rosPackages.noetic.ros-core
          ];
        };
      });
}
