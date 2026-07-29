{ inputs, self, ... }: {

  flake.nixosConfigurations.laptop = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.applications
      self.nixosModules.cosmic
      self.nixosModules.emacs
      self.nixosModules.impermanence
      self.nixosModules.printing
      self.nixosModules.virtualisation
      self.nixosModules.connection
      self.nixosModules.defaults
      self.nixosModules.font
      self.nixosModules.input
      self.nixosModules.shell
      self.nixosModules.xdg

      self.nixosModules.laptopModule
    ];
  };

  flake.nixosModules.laptopModule = { pkgs, ... }: {
    imports = [
      inputs.disko.flakeModules.disko
      
      # Hardware
      ../parts/hardware-laptop.nix
      ../parts/disko-laptop.nix
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
}
