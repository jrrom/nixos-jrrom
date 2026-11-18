{ inputs, ... }: {
  flake.nixosModules.auth = { pkgs, ... }: {
    programs.gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-gnome3;
    };

    services.gnome.gnome-keyring.enable = true;
    programs.seahorse.enable = true; # optional GUI

    # Auto-unlock the keyring at login
    # noctalia-greeter uses greetd
    security.pam.services.greetd.enableGnomeKeyring = true;
  };
}

