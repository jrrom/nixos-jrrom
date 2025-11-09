{
  inputs = {
    # Package sets
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Impermanence
    impermanence.url = "github:nix-community/impermanence";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Cosmic Manager
    cosmic-manager = {
      url = "github:HeitorAugustoLN/cosmic-manager";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    # Disko
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    # Emacs
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    inputs@{
      self,
      nixpkgs,
      impermanence,
      cosmic-manager,
      home-manager,
      ...
    }:
    let
      system = "x86_64-linux";
    in
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-tree;

      nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inputs = inputs;
        };

        modules = [
          inputs.disko.nixosModules.disko
          impermanence.nixosModules.impermanence
          ./hosts/laptop/configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              inherit cosmic-manager; # So much pain to find this...
            };
            home-manager.users.jrrom = {
              imports = [
                cosmic-manager.homeManagerModules.cosmic-manager
                ./hosts/laptop/home.nix
              ];
            };
          }
        ];
      };
    };
}
