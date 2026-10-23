{ inputs, ... }: {
  flake.nixosModules.uptime-kuma = { pkgs, ... }: {
    services.uptime-kuma = {
      enable = true;
      settings = {
        UPTIME_KUMA_HOST = "0.0.0.0";
        UPTIME_KUMA_PORT = "3001";
      };
    };
  };
}
