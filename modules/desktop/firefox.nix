{ inputs, config, lib, ... }: {
  flake.homeModules.firefox = { pkgs, ... }: {
    programs.firefox = {
      enable = true;
      package = pkgs.firefox;
      languagePacks = config.constants.firefox.pack;
      configPath = config.constants.firefox.path;

      nativeMessagingHosts = [ pkgs.tridactyl-native ];

      profiles.${config.constants.admin.username} = {
        isDefault = true;
        search = {
          order = config.constants.firefox.search;
          default = config.constants.firefox.default;
          force = true;
        };
        settings = {
          "browser.startup.homepage" = config.constants.firefox.page;
          "browser.newtab.url" = "about:blank";
          "browser.newtabpage.enabled" = false;
          
          "widget.gtk.global-menu.wayland.enabled" = true;
          "widget.wayland.coordinates-scale.enabled" = true;
          "widget.wayland.native-data-session" = true;
        };
      };
      globalExtensions =  with pkgs.nur.repos.rycee.firefox-addons; [
        karakeep
        pywalfox
        tridactyl
        {
          package = ublock-origin;
          settings.private_browsing = true;
        }
      ];
      policies = {
        DisableFirefoxAccounts = true;
        DisableTelemetry = true;

        "uBlock@raymondhill.net".default_area = "navbar";
        "addon@karakeep.app".default_area = "navbar";
      };
    };
  };
}
