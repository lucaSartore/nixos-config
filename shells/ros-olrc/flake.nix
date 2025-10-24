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
        adam-robotics = pkgs.python3Packages.buildPythonPackage rec {
          pname = "adam_robotics";
          version = "0.3.4";

          src = pkgs.python3Packages.fetchPypi {
            inherit pname version;
            # found here: https://pypi.org/project/adam-robotics/#adam_robotics-0.3.4.tar.gz
            sha256 =
              "e473f8b672b30df2592aebfbe16f45d68ebe0c28deea4cc9de6f8cb2554e23fd";
          };

          doCheck = false; # disable tests if not needed
          propagatedBuildInputs = [ ]; # example dep
        };

      in {
        devShells.default = pkgs.mkShell {
          name = "Example project";
          packages = [
            # non-ros packages
            pkgs.curl
            pkgs.python312

            # building the ros environment
            (with pkgs.rosPackages;
              with pkgs;
              noetic.buildEnv {
                paths = [
                  # python packages
                  python312Packages.scipy
                  python312Packages.numpy
                  python312Packages.matplotlib
                  python312Packages.example-robot-data
                  python312Packages.gepetto-viewer-corba
                  python312Packages.quadprog
                  python312Packages.tsid
                  python312Packages.coal
                  python312Packages.meshcat
                  python312Packages.ipykernel
                  # this package is custom built, as is not present in the nix store
                  adam-robotics

                  # ros packages
                  noetic.pinocchio
                  noetic.urdfdom-py

                  # example of other ros components that can be install
                  # source: https://github.com/lopsided98/nix-ros-overlay/tree/develop/examples
                  # noetic.rosbash
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
