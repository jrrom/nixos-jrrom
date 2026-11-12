{ inputs, config, ... }: {
  flake.nixosModules.n8n = { pkgs, ... }: {
    services.n8n = {
      enable = true;
      environment = {
        N8N_PORT = config.constants.ports.n8n;
        N8N_SECURE_COOKIE = "false";
      };
    };
  };
}
