{ inputs, self, ... }: {

  flake.nixosConfigurations.oracle = inputs.nixpkgs.lib.nixosSystem {
    modules = (with self.nixosModules; [
      lix

      aristillus
      diskoOracle
      n8n
      openssh
      uptime-kuma
      
      oracleModule
    ]);
  };

  flake.nixosModules.oracleModule = { pkgs, lib, ... }: {
    imports = [ ../parts/hardwareOracle.nix ];
    
    nixpkgs.hostPlatform = "aarch64-linux";
    nixpkgs.config.allowUnfree = true;

    networking.hostName = "oracle";
    networking.useDHCP = lib.mkDefault true;

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    security.sudo.wheelNeedsPassword = false;

    users.mutableUsers = false;
    users.users.root = {
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFO1kn/983377PaE6JQO9UoiJ67ZZWNZxyouUVkhJYKd maintainer@jrrom.com"
      ];
    };

    # Networking
    networking.firewall = {
      trustedInterfaces = [ "tailscale0" ];
      checkReversePath  = "loose";
      allowedTCPPorts   = [ 22 ];
    };

    # Services
    services.tailscale = {
      enable = true;
      useRoutingFeatures = "server";
    };

    system.stateVersion = "25.05";
  };
}

