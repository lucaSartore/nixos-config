{
  description = "Minimal dual‑host NixOS + home‑manager flake";

  inputs = {
    self.submodules = true;

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvim-config = {
      url = "path:./submodules/nvim";
      flake = false;
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    # nix-matlab = {
    #   inputs.nixpkgs.follows = "nixpkgs";
    #   url = "gitlab:doronbehar/nix-matlab";
    # };

    # Optional overlay for bleeding‑edge packages
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, plasma-manager, ... }:
    let 
      system = "x86_64-linux";
      pkgs-unstable = import nixpkgs-unstable { inherit system; };
    in {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          # specialArgs = { inherit inputs; flake-overlays=flake-overlays; };
          specialArgs = { inherit inputs pkgs-unstable; };
          modules = [
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.lucas = ./hosts/desktop/home.nix;
              home-manager.sharedModules =
                [ plasma-manager.homeManagerModules.plasma-manager ];
              home-manager.extraSpecialArgs = { inherit inputs pkgs-unstable; };
            }
            ./modules/all.nix
            ./hosts/desktop
          ];
        };

        laptop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs pkgs-unstable; };
          modules = [
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.lucas = ./hosts/laptop/home.nix;
              home-manager.sharedModules =
                [ plasma-manager.homeManagerModules.plasma-manager ];
              home-manager.extraSpecialArgs = { inherit inputs pkgs-unstable; };
            }
            ./modules/all.nix
            ./hosts/laptop
          ];
        };

        laptop-quindi = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs pkgs-unstable; };
          modules = [
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.lucas = ./hosts/laptop-quindi/home.nix;
              home-manager.sharedModules =
                [ plasma-manager.homeManagerModules.plasma-manager ];
              home-manager.extraSpecialArgs = { inherit inputs pkgs-unstable; };
            }
            ./modules/all.nix
            ./hosts/laptop-quindi
          ];
        };

      };
    };
}
