{
  inputs = {
    # Package sets
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Pre-commit hooks
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Impermanence
    impermanence = {
      url = "github:nix-community/impermanence";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

    # kDrive
    kDrive = {
      url = "github:jrrom/desktop-kDrive-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    inputs@{
      self,
      nixpkgs,
      pre-commit-hooks,
      impermanence,
      cosmic-manager,
      home-manager,
      ...
    }:
    {
      checks.x86_64-linux = {
        pre-commit-check = pre-commit-hooks.lib.x86_64-linux.run {
          src = ./.;
          hooks = {
            nixfmt-rfc-style = {
              enable = true;
              files = "\\.nix$";
            };
            statix = {
              enable = true;
              settings.format = "stderr";
            };
          };
        };
      };

      devShells.x86_64-linux.default = nixpkgs.legacyPackages.x86_64-linux.mkShell {
        inherit (self.checks.x86_64-linux.pre-commit-check) shellHook;
        buildInputs = self.checks.x86_64-linux.pre-commit-check.enabledPackages;
      };

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-tree;
      
      nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inputs = inputs;
        };

        modules = [
          inputs.disko.nixosModules.disko
          impermanence.nixosModules.impermanence
          ./hosts/laptop/configuration.nix
          inputs.kDrive.nixosModules.default

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              inherit cosmic-manager;
              inherit inputs;
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
