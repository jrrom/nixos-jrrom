# Defaults for every NixOS
{ inputs, config, ... }: {
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
        trusted-users = [ "root" config.constants.admin.username ];
      };

      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 14d";
      };

      optimise.automatic = true;
    };

    programs.dconf.enable = true;
    environment.sessionVariables.XDG_DATA_DIRS = [
      "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}"
    ];
  };
}
