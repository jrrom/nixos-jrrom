{ config, inputs, ... }: {
  flake.nixosModules.noctalia = { pkgs, ... }: {
    imports = [ inputs.noctalia.nixosModules.default ];

    programs.noctalia = {
      enable = true;
      systemd.enable = true;
      recommendedServices.enable = true; # NM, Bluetooth, UPower
    };
  };

  flake.homeModules.noctalia = { pkgs, ... }: {
    imports = [ inputs.noctalia.homeModules.default ];

    programs.noctalia.enable = true;
    programs.noctalia.settings = {
      shell.launch_apps_as_systemd_services = true;
      shell.greeter_sync.auto_sync = true;
      shell.font_family = config.constants.font.sans;
      shell.panel.control_center_placement = "floating";

      shell.screenshot = {
        save_to_file         = true;
        directory            = config.constants.screenshots;
        format               = "png";
        copy_to_clipboard    = true;
        freeze_screen        = true;
        confirm_region       = true;
        remember_last_region = true;
        region_modifier      = "none";
        show_region_hint     = true;
        show_region_dimensions = true;
        show_cursor          = false;
        annotate             = true;
        skip_annotate_on_copy_save = false;
        close_on_copy        = true;
        close_on_save        = true;
        copy_on_close        = false;
      };
      
      theme = {
        mode = config.constants.theme.mode;
        shell_mode = "follow";
        source = "builtin";
        builtin = config.constants.theme.builtinSource;
        sync_color_scheme = true;

        templates = {
          enable_builtin_templates = true;
          enable_community_templates = true;
          builtin_ids = [ "umbriel" "gtk3" "gtk4" "qt" "emacs"];
          community_ids = [ "bat" "glow" "fzf" "gruvbox-plus-icons" "pywalfox"];
        };
      };

      wallpaper = {
        enabled = true;
        fill_mode = "crop";
        directory = config.constants.wallpapers;
        transition = [ "fade" ];
        automation = {
          enabled = true;
          interval_seconds = 1800;
          order = "random";
        };
      };

      widget.clock.vertical_format = "{:%H}\n{:%M}";

      bar = {
        order = [ "default" ];
        
        default = {
          position           = "left";
          enabled            = true;
          auto_hide          = false;
          auto_hide_delay_ms = 0;
          smart_auto_hide    = false;
          reserve_space      = true;
          layer              = "top";

          thickness          = 34;
          background_opacity = 0.00;
          compositor_blur    = false;
          border             = "surface_container";
          border_width       = 0;
          shadow             = true;
          contact_shadow     = true;
          panel_overlap      = 1;
          radius             = 12;
          radius_top_left    = 12;
          radius_top_right   = 12;
          radius_bottom_left = 12;
          radius_bottom_right = 12;
          concave_edge_corners = false;
          margin_ends        = 12;         # was 100; removes the huge gap
          margin_edge        = 0;
          margin_opposite_edge = 0;
          padding            = 14;
          widget_spacing     = 0;
          hover_highlight    = true;
          show_tooltip       = true;
          scale              = 1.0;
          font_scale         = 1.0;
          font_weight        = 500;
          font_family        = config.constants.font.sans;

          capsule_group = [
            {
              enabled = true;
              accordion = true;
              id = "top";
              members = [ "clock" "control-center" "notifications" "media"  ];
              border = "secondary";
              fill = "surface_container";
              border_width = 1.0;
              widget_spacing = 6;
              opacity = 1.0;
            }
            {
              enabled = true;
              accordion = true;
              id = "bottom";
              members = [ "workspaces" "tray" "screenshot" "network" "clipboard" "volume" "brightness" "battery" ];
              border = "secondary";
              fill = "surface_container";
              border_width = 1.0;
              widget_spacing = 6;
              opacity = 1.0;
            }
          ];

          capsule            = true;
          capsule_fill       = "surface_container";
          capsule_thickness  = 0.77;
          capsule_radius     = 8.0;
          capsule_opacity    = 1.0;

          start  = [ "group:top" ];
          center = [ ];
          end    = [ "group:bottom" ];
        };
      };
    };
  };
}

