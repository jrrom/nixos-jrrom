{ inputs, ... }: {
  flake.nixosModules.nur = { pkgs, ... }: {
    nixpkgs.overlays = [
      inputs.nur.overlays.default
    ];
  };
}
