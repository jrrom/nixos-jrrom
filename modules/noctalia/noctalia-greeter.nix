{ config, inputs, ... }: {
  flake.nixosModules.noctalia-greeter = { pkgs, ... }: {
    imports = [ inputs.noctalia-greeter.nixosModules.default ];

    services.displayManager.noctalia-greeter = {
      enable = true;
      passwordless-sync-users = [ config.constants.admin.username ];
      settings = {
        cursor = {
          theme = config.constants.cursor.name;
          size = config.constants.cursor.size;
          path = pkgs.${config.constants.cursor.pkg};
        };

        user.default = config.constants.admin.username;
        appearance.scheme = "Gruvbox";
        theme_mode = "dark";
      };
    };
  };
}

