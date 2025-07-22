{
  description = "jrrom";

  inputs =
    {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    
    # disko = {
    #  url = "github:nix-community/disko";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix/release-25.05";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, disko, stylix, ... }@inputs:
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
        jrromlib = import ./common/jrromlib.nix;
      };
    in
    {
      nixosConfigurations.jrrom = nixpkgs.lib.nixosSystem {
        system = information.system;
        specialArgs = args;
        modules = [
          ./nixos/configuration.nix
          disko.nixosModules.disko
          home-manager.nixosModules.home-manager {
            home-manager.extraSpecialArgs = args;
            home-manager.useGlobalPkgs = true;
            home-manager.users."${information.hostName}" = import ./nixos/home/home.nix;
          }
          ./nixos/stylix/styles.nix
          stylix.nixosModules.stylix
        ];
      };

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

