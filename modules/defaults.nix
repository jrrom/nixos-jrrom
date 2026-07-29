{ inputs, ... }: {
  flake.nixosModules.defaults = { pkgs, ... }: {
    nixpkgs.config.allowUnfree = true;
    # Nix
    nix = {
      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
          "pipe-operators"
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
