{ inputs, ... }: {
  flake.nixosModules.n8n = { pkgs, ... }: {
    services.n8n = {
      enable = true;
      environment = {
        N8N_PORT = 5678;
        N8N_SECURE_COOKIE = "false";
        N8N_EDITOR_BASE_URL = "https://n8n.oracle";
        WEBHOOK_URL = "https://n8n.oracle";
      };
    };
  };
}
