{ inputs, ... }: {
  flake.nixosModules.auth = { pkgs, ... }: {
    programs.gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-gtk2;
    };
  };
}

