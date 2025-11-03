{
  inputs = {
    nix-ros-overlay.url = "github:lopsided98/nix-ros-overlay/master";
    nixpkgs.follows = "nix-ros-overlay/nixpkgs"; # IMPORTANT!!!
  };
  outputs = { self, nix-ros-overlay, nixpkgs }:
    nix-ros-overlay.inputs.flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ nix-ros-overlay.overlays.default ];
        };
      in {
        devShells.default = pkgs.mkShell {
          name = "Ros RobotPlanning";
          packages = [
            # non related ros dependency
            pkgs.gnupg
            pkgs.sudo
            pkgs.wget
            pkgs.git
            pkgs.curl
            pkgs.gcc
            pkgs.gnumake
            pkgs.binutils
            pkgs.glibc

            # building the ros environment
            (with pkgs.rosPackages;
              with pkgs;
              noetic.buildEnv {
                paths = [
                  noetic.urdfdom-py
                  noetic.srdfdom
                  noetic.joint-state-publisher
                  noetic.joint-state-publisher-gui
                  noetic.joint-state-controller 
                  noetic.gazebo-msgs
                  noetic.control-toolbox
                  noetic.controller-manager
                  # example of other ros components that can be install
                  # source: https://github.com/lopsided98/nix-ros-overlay/tree/develop/examples
                  noetic.rosbash
                ];
              })
          ];

          shellHook = ''
            abs_path="$(realpath "$PWD/..")"
            export PYTHONPATH="$abs_path:$PYTHONPATH"
            echo -e "\033[0;31mAdded $abs_path to PYTHONPATH\033[0m"
            echo -e "\033[0;31mIf this is not the folder containing the \"orc\" repo, the code will not work\033[0m"
          '';

        };
      });
  nixConfig = {
    extra-substituters = [ "https://ros.cachix.org" ];
    extra-trusted-public-keys =
      [ "ros.cachix.org-1:dSyZxI8geDCJrwgvCOHDoAfOm5sV1wCPjBkKL+38Rvo=" ];
  };
}
