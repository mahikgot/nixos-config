{
  description = "A template that shows all standard flake outputs";

  inputs.pkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  inputs.home-manager.url = "github:nix-community/home-manager/release-25.11";
  inputs.nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
  outputs = all@{ self, pkgs, home-manager, nixos-wsl, ... }: {
    nixosConfigurations.markbook = pkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        ./configuration.nix
        ./hardware/markbook.nix
        home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.marky = import ./home.nix;
          }
      ];
    };
    nixosConfigurations.nixos = pkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        nixos-wsl.nixosModules.default {
          wsl.enable = true;
          wsl.defaultUser = "marky";
        }
        ./configuration.nix
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.marky = import ./home.nix;
        }
      ]
    }
  };
} 
