{
  description = "A template that shows all standard flake outputs";

  inputs.pkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  # Work-in-progress: refer to parent/sibling flakes in the same repository
  outputs = all@{ self, pkgs, ... }: {
    nixosConfigurations.markbook = pkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        ./configuration.nix
      ];
    };
  };
} 
