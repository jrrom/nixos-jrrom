{ inputs, config, ... }: {
  flake.nixosModules.serverDefaults = { pkgs, ... }: {
    nix.gc = { automatic = true; dates = "weekly"; options = "--delete-older-than 14d"; };
    nix.settings.auto-optimise-store = true;
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    boot.loader.systemd-boot.configurationLimit = 5;
  };
}
