{ inputs, ... }: {
  flake.nixosModules.auth = { pkgs, ... }: {
    programs.gnupg = {
      enable = true;
      agent = pkgs.pinentry-gtk2;
    };
  };
}

