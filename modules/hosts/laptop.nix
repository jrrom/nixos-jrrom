{ inputs, self, config, ... }: {

  flake.nixosConfigurations.laptop = inputs.nixpkgs.lib.nixosSystem {
    modules = (with self.nixosModules; [
      # Meta
      defaults
      home-manager
      lix
      nur

      # Security
      auth
      connection

      # Desktop
      emacs
      kDrive
      obs
      packages

      # System
      diskoLaptop
      font
      impermanence
      input
      keyd
      printing
      shell
      virtualisation
      xdg

      # Noctalia
      noctalia-greeter
      umbriel
      noctalia

      laptopModule
    ]);
  };

  flake.nixosModules.laptopModule = { pkgs, ... }: {
    imports = [ ./_hardware/hardwareLaptop.nix ];

    time.timeZone = config.constants.admin.timeZone;
    i18n = {
      defaultLocale = config.constants.admin.defaultLocale;
      extraLocales = config.constants.admin.extraLocales;
    };
    users.users.${config.constants.admin.username} = {
      hashedPasswordFile = "/persistence/passwords/${config.constants.admin.username}";
      isNormalUser = true;
      extraGroups = [
        "wheel" "networkmanager" "floppy" "audio" "cdrom" "video"
        "usb" "users" "plugdev" "pipewire" "docker" "libvirt"
        "scanner" "lp"
      ];
    };

    system.stateVersion = "25.05";

    home-manager.users.${config.constants.admin.username} = {
      home.stateVersion = "25.05";
      imports = with self.homeModules; [
        firefox

        # Noctalia
        umbriel
        noctalia
        gui
      ];
    };
  };
}
