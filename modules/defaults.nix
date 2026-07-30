# Defaults for every NixOS
{ inputs, ... }: {
  flake.nixosModules.defaults = { pkgs, ... }: {
    # System
    services.fwupd.enable = true;
    system.stateVersion = "25.05";

    nixpkgs.config.allowUnfree = true;
    # Nix
    nix = {
      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        auto-optimise-store = true;
        trusted-users = [ "root" "jrrom" ];
      };

      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 14d";
      };

      optimise.automatic = true;
    };
  };
}
