{
  description = "jrrom";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix/release-24.11";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, disko, stylix, ... }@inputs:
    let
      system = "x86_64-linux";
      information = {
        hostName = "jrrom";
      };
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
      jrromlib = import ./common/jrromlib.nix;
    in
    {
      nixosConfigurations.jrrom = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
          inherit pkgs-unstable;
          inherit information;
          inherit jrromlib;
        };
        modules = [
          ./nixos/configuration.nix
          disko.nixosModules.disko
          home-manager.nixosModules.home-manager {
            home-manager.extraSpecialArgs = {
              inherit inputs;
              inherit pkgs-unstable;
              inherit information;
              inherit jrromlib;
            };
            home-manager.useGlobalPkgs = true;
            home-manager.users."${information.hostName}" = import ./home/home.nix;
          }
          ./common/styles.nix
          stylix.nixosModules.stylix
        ];
      };
    };
}
