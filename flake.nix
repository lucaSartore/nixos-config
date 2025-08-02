{
  description = "Minimal dual‑host NixOS + home‑manager flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Optional overlay for bleeding‑edge packages
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
    {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
                ./modules/all.nix
                #./modules/home.nix
                ./hosts/desktop
            ];
        };
      };
    };
}
