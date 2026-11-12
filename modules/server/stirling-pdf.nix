{ inputs, config, ... }: {
  flake.nixosModules.stirling-pdf = { pkgs, ... }: {
    services.stirling-pdf = {
      enable = true;
      environment = {
        SERVER_PORT = config.constants.ports.stirling-pdf;
      };
    };
  };
}
