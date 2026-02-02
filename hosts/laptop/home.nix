{
  config,
  pkgs,
  cosmicLib,
  inputs,
  ...
}:

{
  home.username = "jrrom";
  home.homeDirectory = "/home/jrrom";

  # Programs
  programs.fish = {
    enable = true;
    shellInit = "function fish_greeting\n\nend";
  };

  # Cursor
  home.pointerCursor = {
    enable = true;
    package = pkgs.bibata-cursors;
    size = 32;
    name = "Bibata-Modern-Ice";
  };
  
  # GTK
  gtk = {
    enable = true;
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
    cursorTheme = {
      package = pkgs.bibata-cursors;
      size = 32;
      name = "Bibata-Modern-Ice";
    };
  };
  
  # Emacs
  home.file.".config/emacs/init.el".source = config.lib.file.mkOutOfStoreSymlink "/home/jrrom/nixos-jrrom/hosts/laptop/init.el";

  # Cosmic Manager
  # Thank you to https://github.com/HeitorAugustoLN/nix-config/
  # He is the creator of cosmic-manager
  wayland.desktopManager.cosmic = {
    enable = true; # cosmic-manager CLI
    resetFiles = false; # Keep it impermanent or nah

    compositor = {
      autotile = true;
      autotile_behavior = cosmicLib.cosmic.mkRON "enum" "PerWorkspace";
      focus_follows_cursor = false;

      workspaces = {
        workspace_layout = cosmicLib.cosmic.mkRON "enum" "Horizontal";
        workspace_mode   = cosmicLib.cosmic.mkRON "enum" "OutputBound";
      };
    };
    
    compositor.xkb_config = {
      layout = "us";
      model = "pc104";
      repeat_delay = 500;
      repeat_rate = 25;
      rules = "";
      variant = "";
      options = cosmicLib.cosmic.mkRON "optional" "ctrl:swapcaps";
    };

    appearance = {
      theme = {
        dark = cosmicLib.cosmic.importRON ../../misc/GruvboxMatDark.ron;
        mode = "dark";
      };

      toolkit = {
        apply_theme_global = true;

        interface_font = {
          family = "Fira Sans";
          stretch = cosmicLib.cosmic.mkRON "enum" "Normal";
          style = cosmicLib.cosmic.mkRON "enum" "Normal";
          weight = cosmicLib.cosmic.mkRON "enum" "Semibold";
        };

        monospace_font = {
          family = "Maple Mono";
          stretch = cosmicLib.cosmic.mkRON "enum" "Normal";
          style = cosmicLib.cosmic.mkRON "enum" "Normal";
          weight = cosmicLib.cosmic.mkRON "enum" "Normal";
        };
      };
    };

    panels = [
      {
        anchor_gap = false;
        anchor = cosmicLib.cosmic.mkRON "enum" "Top";
        name = "Panel";
        margin = 0;
        opacity = 1.0;
        expand_to_edges = true;
        plugins_center = cosmicLib.cosmic.mkRON "optional" [
          "com.system76.CosmicAppletTime"
        ];
        plugins_wings = cosmicLib.cosmic.mkRON "optional" (
          cosmicLib.cosmic.mkRON "tuple" [
            [
              "com.system76.CosmicAppletWorkspaces"
              "com.system76.CosmicAppletMinimize"
            ]
            [
              "com.system76.CosmicAppletStatusArea"
              "com.system76.CosmicAppletTiling"
              "com.system76.CosmicAppletAudio"
              "com.system76.CosmicAppletNetwork"
              "com.system76.CosmicAppletBattery"
              "com.system76.CosmicAppletNotifications"
              "com.system76.CosmicAppletBluetooth"
              "com.system76.CosmicAppletPower"
            ]
          ]
        );
        size = cosmicLib.cosmic.mkRON "enum" "XS";
      }
    ];

    wallpapers = [
      {
        filter_by_theme = false;
        filter_method = cosmicLib.cosmic.mkRON "enum" "Lanczos";
        output = "all";
        rotation_frequency = 300;
        sampling_method = cosmicLib.cosmic.mkRON "enum" "Alphanumeric";
        scaling_mode = cosmicLib.cosmic.mkRON "enum" "Zoom";

        source = cosmicLib.cosmic.mkRON "enum" {
          variant = "Path";
          value = [ "/home/jrrom/nixos-jrrom/wallpapers/blue-lake-1920x1200.png" ];
        };
      }
    ];

    shortcuts = [
      {
        action = cosmicLib.cosmic.mkRON "enum" "Fullscreen";
        key = "Super+grave"; # Super + `
      }
    ];
  };

  programs.cosmic-edit = {
    enable = true;

    settings = {
      font_name = "Maple Mono";
      font_size = 16;
    };
  };
  
  programs.cosmic-term = {
    enable = true;
    profiles = [
      {
        command = "fish";
        hold = false;
        is_default = true;
        name = "Default";
        syntax_theme_dark = "COSMIC Dark";
        syntax_theme_light = "COSMIC Light";
        tab_title = "jrrom@jrrom";
        working_directory = "/home/jrrom";
      }
    ];
    settings = {
      font_name = "Maple Mono";
      font_size = 16;
    };
  };

  xdg.autostart = {
    enable = true;
    entries = [
      "${inputs.kDrive.packages.x86_64-linux.default}/share/applications/kDrive.desktop"
    ];
  };
  
  home.stateVersion = "25.05";
}
