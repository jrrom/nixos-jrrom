{ inputs, config, ... }: {
  flake.nixosModules.gotify = { pkgs, ... }: {
    services.gotify = {
      enable = true;
      environment = {
        GOTIFY_DATABASE_DIALECT = "sqlite3";
        GOTIFY_SERVER_PORT = config.constants.ports.gotify;
      };
    };
  };
}
