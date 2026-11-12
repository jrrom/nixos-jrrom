{ inputs, config, ... }: {
  flake.nixosModules.karakeep = { pkgs, ... }: {
    services.karakeep = {
      enable = true;
      extraEnvironment = {
        PORT = config.constants.ports.karakeep;
      };
    };
  };
}
