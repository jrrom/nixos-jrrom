{ inputs, config, lib, ... }: {
  flake.nixosModules.homepage-dashboard = { pkgs, ... }: {
    services.homepage-dashboard = {
      enable = true;
      listenPort = toString config.constants.homepage-dashboard;
      allowedHosts = "${config.constants.server.hostName}:${toString config.constants.homepage-dashboard}";
      services = [
        {
          "Services" = [
            { "website" = { description = "Website"; href = config.constants.admin.website; }; }
          ] 
          ++ lib.mapAttrsToList (name: value: {
            "${name}" = { href = "http://${config.constants.server.hostName}:${toString value}"; icon = "${name}"; };
          }) config.constants.ports;
        }
      ];
      
      widgets = [
        {
          resources = {
            cpu = true;
            memory = true;
            disk = "/";
            uptime = true;
          };
        }
      ];
      
    };
  };
}
