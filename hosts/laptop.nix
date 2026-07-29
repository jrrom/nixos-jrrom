{ inputs, self, ... }: {

  flake.nixosConfigurations.laptop = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      applications
      connection
      cosmic
      defaults
      diskoLaptop
      emacs
      font
      impermanence
      input
      homeManager
      printing
      shell
      virtualisation
      xdg

      laptopModule
    ];
  };

  flake.nixosModules.laptopModule = { pkgs, ... }: {
    imports = [
      # Hardware
      ../parts/hardwareLaptop.nix
    ];

    # System
    time.timeZone = "Asia/Kolkata";
    i18n = {
      defaultLocale = "en_IN";
      # See wiki.nixos.org/wiki/Locales
      extraLocales = [ "en_US.UTF-8/UTF-8" ];
    };
    users.users.root.hashedPasswordFile = "/persistence/passwords/root";
    users.users.jrrom = {
      hashedPasswordFile = "/persistence/passwords/jrrom";
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "networkmanager"
        "floppy"
        "audio"
        "cdrom"
        "video"
        "usb"
        "users"
        "plugdev"
        "pipewire"
        "docker"
        "libvirt"
        "scanner"
        "lp"
      ];
    };

    system.stateVersion = "25.05";
  };

  flake.homeConfigurations.jrrom = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
    modules = [
      self.homeModules.emacs
      self.homeModules.cosmic
    ];
  };
}
