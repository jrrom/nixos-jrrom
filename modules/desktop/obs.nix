{ inputs, ... }: {
  flake.nixosModules.obs = { pkgs, ... }: {
    programs.obs-studio.enable = true;
  };
}
