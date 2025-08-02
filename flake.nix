{
  description = "Minimal dual‑host NixOS + home‑manager flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvim-config = {
      url = "path:./submodules/nvim";
      flake = false;
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
                home-manager.nixosModules.home-manager{
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.users.lucas = ./modules/home.nix;
                  home-manager.extraSpecialArgs = {
                    inherit inputs;
                  };
                }
                ./modules/all.nix
                #./modules/home.nix
                ./hosts/desktop
            ];
        };
      };
    };
}
