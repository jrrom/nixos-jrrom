{ lib, pkgs, ... }: {
  options.constants = lib.mkOption {
    type = lib.types.attrs;
    default = rec {
      # --- Personal ---
      admin = rec {
        username = "jrrom";
        gitEmail = "77691121+jrrom@users.noreply.github.com";
        gitName  = "${username}";
        # Hostname is kept the same as username
        hostId   = "ede53986";
        website  = "https://jrrom.com";

        timeZone = "Europe/Paris";
        defaultLocale = "en_IN";
        extraLocales = [ "en_US.UTF-8/UTF-8" ];
      };

      # --- Paths ---
      homeDir     = "/home/${admin.username}";
      configPath  = "${homeDir}/nixos-jrrom";
      cloudPath   = "${homeDir}/kDrive";
      configHome  = "${homeDir}/.config";
      wallpapers  = "${configPath}/modules/noctalia/wallpapers";
      screenshots = "${homeDir}/Screenshots";

      # --- Emacs ---
      denotePath = "${cloudPath}/Denote";

      theme = {
        gap = 16;
        mode = "dark";
        builtinSource = "Gruvbox";
      };

      cursor = {
        size = 24;
        name = "Bibata-Modern-Ice";
        pkg = "bibata-cursors"; # nixpkg name
      };
      
      font = {
        mono = "Maple Mono";
        sans = "Alegreya Sans";
        console = "Lat2-Terminus16"; # in kbd
        symbols = "Symbols Nerd Font Mono";
        dpi = "142";
      };

      # --- Selfhosted ---
      server = {
        username = "aristillus";
        hostName = "oracle";

        timeZone = "Asia/Kolkata";
        defaultLocale = "en_IN";
        extraLocales = [ "en_US.UTF-8/UTF-8" ];
        authorizedKeys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFO1kn/983377PaE6JQO9UoiJ67ZZWNZxyouUVkhJYKd maintainer@jrrom.com"
        ];
        allowedPorts = [ 22 ];
      };

      homepage-dashboard = 8082;
      ports = {
        gotify       = 8070;
        karakeep     = 7778;
        n8n          = 5678;
        stirling-pdf = 8123;
        uptime-kuma  = 3001;
      };

      # --- Firefox ---
      firefox = {
        path = "${homeDir}/.config/mozilla/firefox";
        page = "http://${server.hostName}:${toString homepage-dashboard}";
        pack = [ "en-GB" ];
        search = ["qwant" "ddg" "wikipedia"];
        default = "qwant";
      };
    };
  };
}
