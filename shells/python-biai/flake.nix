{
  description = "A Python 3.13 environment for the BioInspired AI course";

  # Define inputs (like Python and other Nix dependencies)
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05"; # Adjust to your preferred nixpkgs version
    flake-utils.url = "github:numtide/flake-utils";
  };

  # Outputs: the flake defines an environment and packages
  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachSystem ["x86_64-linux"] (system: let
      pkgs = import nixpkgs {
        inherit system;
      };
      pythonEnv = pkgs.python3.withPackages (pythonPackages: [
        pythonPackages.numpy
      ]);
    in {
      # Define a development shell
      devShell = pkgs.mkShell {
        buildInputs = [ pythonEnv ];
        shellHook = ''
          echo "Welcome to the Python environment for BioInspired AI LAB"
        '';
      };
    });
}
