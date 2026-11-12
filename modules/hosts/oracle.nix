{ inputs, self, config, ... }: {

  flake.nixosConfigurations.oracle = inputs.nixpkgs.lib.nixosSystem {
    modules = (with self.nixosModules; [
      lix

      diskoOracle
      n8n
      openssh
      uptime-kuma
      gotify
      homepage-dashboard
      karakeep
      serverDefaults
      stirling-pdf
      
      oracleModule
    ]);
  };

  flake.nixosModules.oracleModule = { pkgs, lib, ... }: {
    imports = [ ./_hardware/hardwareOracle.nix ];
    
    nixpkgs.config.allowUnfree = true;

    networking.hostName = config.constants.server.hostName;
    networking.useDHCP = lib.mkDefault true;

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    security.sudo.wheelNeedsPassword = false;

    users.mutableUsers = false;
    users.users.root = {
      openssh.authorizedKeys.keys = config.constants.server.authorizedKeys;
    };

    time.timeZone = config.constants.server.timeZone;
    i18n = {
      defaultLocale = config.constants.server.defaultLocale;
      extraLocales = config.constants.server.extraLocales;
    };

    users.users.${config.constants.server.username} = {
      isNormalUser = true;
      extraGroups = [
        "wheel" "networkmanager" "floppy" "audio" "cdrom" "video"
        "usb" "users" "plugdev" "pipewire" "docker" "libvirt"
        "scanner" "lp"
      ];
    };

    # Networking
    networking.firewall = {
      trustedInterfaces = [ "tailscale0" ];
      checkReversePath  = "loose";
      allowedTCPPorts   = config.constants.server.allowedPorts;
    };

    # Services
    services.tailscale = {
      enable = true;
      useRoutingFeatures = "server";
    };

    system.stateVersion = "25.05";
  };
}

