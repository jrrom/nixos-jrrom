{ inputs, ... }: {
  flake.nixosModules.printing = { pkgs, ... }: {
    services.printing = {
      enable = true;
      drivers = [ pkgs.hplip ];
    };
    
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    hardware.sane = {
      enable = true;
      extraBackends = [ pkgs.hplipWithPlugin ];
    };

    # Utilities
    environment.systemPackages = with pkgs; [
      ghostscript
      simple-scan
    ];
  };
}
