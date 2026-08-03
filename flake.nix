{
  inputs = {
    cosmic-manager.inputs.home-manager.follows = "home-manager";
    cosmic-manager.inputs.nixpkgs.follows = "nixpkgs";
    cosmic-manager.url = "github:HeitorAugustoLN/cosmic-manager";
    
    disko.inputs.nixpkgs.follows = "nixpkgs";
    disko.url = "github:nix-community/disko";
    
    emacs-overlay.inputs.nixpkgs.follows = "nixpkgs";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    
    flake-parts.url = "github:hercules-ci/flake-parts";
    
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    
    impermanence.inputs.nixpkgs.follows = "nixpkgs";
    impermanence.url = "github:nix-community/impermanence";
    
    import-tree.url = "github:vic/import-tree";
    
    kDrive.inputs.nixpkgs.follows = "nixpkgs";
    kDrive.url = "github:jrrom/desktop-kDrive-flake";
    
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; }
      (inputs.import-tree [ ./modules ./hosts ]);
}
