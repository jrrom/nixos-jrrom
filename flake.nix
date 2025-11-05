{
  inputs = {
    # Determinate Nix
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/3";

    # Package sets
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Disko
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = inputs@{ self, nixpkgs, determinate, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        determinate.nixosModules.default
        inputs.disko.nixosModules.disko
        
        ./configuration.nix
      ];
    };
  };
}
