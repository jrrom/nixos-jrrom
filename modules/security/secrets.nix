{ inputs, ... }: {
  flake.nixosModules.secrets = { pkgs, ... }: {
    imports = [ inputs.sops-nix.nixosModules.sops ];

    # how to do?
  };
}
