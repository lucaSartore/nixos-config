{
  description = "Minimal dual‑host NixOS + home‑manager flake";

  inputs = {
    self.submodules = true;

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvim-config = {
      url = "path:./submodules/nvim";
      flake = false;
    };

    sops-nix.url = "github:Mic92/sops-nix";

    # nix-matlab = {
    #   inputs.nixpkgs.follows = "nixpkgs";
    #   url = "gitlab:doronbehar/nix-matlab";
    # };

    # Optional overlay for bleeding‑edge packages
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, ... }:
    let 
      system = "x86_64-linux";
      pkgs-unstable = import nixpkgs-unstable { inherit system; };
    in {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          # specialArgs = { inherit inputs; flake-overlays=flake-overlays; };
          specialArgs = { inherit inputs pkgs-unstable; configName = "desktop"; };
          modules = [
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.lucas = ./hosts/desktop/home.nix;
              home-manager.extraSpecialArgs = { inherit inputs pkgs-unstable; configName="desktop"; };
            }
            ./modules/all.nix
            ./hosts/desktop
          ];
        };

        laptop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs pkgs-unstable; configName = "laptop"; };
          modules = [
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.lucas = ./hosts/laptop/home.nix;
              home-manager.extraSpecialArgs = { inherit inputs pkgs-unstable; configName="laptop"; };
            }
            ./modules/all.nix
            ./hosts/laptop
          ];
        };

        laptop-quindi = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs pkgs-unstable; configName = "laptop-quindi"; };
          modules = [
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.lucas = ./hosts/laptop-quindi/home.nix;
              home-manager.extraSpecialArgs = { inherit inputs pkgs-unstable; configName = "laptop-quindi"; };
            }
            ./modules/all.nix
            ./hosts/laptop-quindi
          ];
        };

      };
    };
}
