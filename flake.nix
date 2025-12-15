{
  description = "A template that shows all standard flake outputs";

  inputs.pkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  inputs.home-manager.url = "github:nix-community/home-manager/release-25.11";
  outputs = all@{ self, pkgs, home-manager, ... }: {
    nixosConfigurations.markbook = pkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        ./configuration.nix
	home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.marky = import ./home.nix;
          }
      ];
    };
  };
} 
