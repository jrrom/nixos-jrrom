{ inputs, self, ... }: {

  flake.nixosConfigurations.laptop = inputs.nixpkgs.lib.nixosSystem {
    modules = (with self.nixosModules; [
      applications
      auth
      connection
      cosmic
      defaults
      diskoLaptop
      emacs
      font
      home-manager
      impermanence
      input
	  keyd
      lix
      printing
      shell
      virtualisation
      xdg

      laptopModule
    ]);
  };

  flake.nixosModules.laptopModule = { pkgs, ... }: {
    imports = [ ../parts/hardwareLaptop.nix ];
    
    time.timeZone = "Asia/Kolkata";
    i18n = {
      defaultLocale = "en_IN";
      extraLocales = [ "en_US.UTF-8/UTF-8" ];
    };
    users.users.jrrom = {
      hashedPasswordFile = "/persistence/passwords/jrrom";
      isNormalUser = true;
      extraGroups = [
        "wheel" "networkmanager" "floppy" "audio" "cdrom" "video"
        "usb" "users" "plugdev" "pipewire" "docker" "libvirt"
        "scanner" "lp"
      ];
    };

    system.stateVersion = "25.05";

    home-manager.users.jrrom = {
      imports = with self.homeModules; [
        emacs
        cosmic
      ];
    };
  };
}
