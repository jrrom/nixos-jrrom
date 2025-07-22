{
  description = "jrrom";

  inputs =
  {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs:
    let
      information = {
        system = "x86_64-linux";
        hostName = "jrrom";
      };

      args = {
        inherit inputs;
        pkgs-unstable = import nixpkgs-unstable {
          system = information.system;
          config.allowUnfree = true;
        };
        inherit information;
      };
    in
    {
      homeConfigurations.void = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = information.system;
          config.allowUnfree = true;
        };
        extraSpecialArgs = args;
        modules = [
          ./void/home.nix
        ];
      };
    };
}

