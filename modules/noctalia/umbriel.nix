{ inputs, config, ... }: {
  flake.nixosModules.umbriel = { pkgs, ... }: {
    imports = [ inputs.umbriel.nixosModules.default ];
    
    programs.umbriel.enable = true;
  };

  flake.homeModules.umbriel = { pkgs, ... }: {
    imports = [ inputs.umbriel.homeModules.default ];

    programs.umbriel.enable = true;
    programs.umbriel.settings = {
      general = {
        autostart = [ "emacs" ];
        xwayland  = true;
        xwayland_native_resolution = true;
        xwayland_xsettings = true; # Umbriel manages X
        nvidia_sync_workaround = false;
        attach_modal_dialogs = true;
        show_cheatsheet = false;
      };

      include.optional.files = [
        "${config.constants.configHome}/umbriel/noctalia.toml"
      ];
        
      appearance = {
        blur.radius = 3;
        title_bar.mode = "off";
      };

      layout = {
        gap = config.constants.theme.gap;
        mode = "scrolling";
        extent_presets = [0.25 0.333 0.5 0.667 0.75 ];
        scrolling.default_extent_fraction = 0.667;
      };

      keybinds = {
        # Applications
        "Mod+Return" = { action = "spawn emacs"; repeat = false; };
        "Mod" = "spawn noctalia msg panel-toggle launcher";
        "Mod+Q" = { action = "window-close"; repeat = false; };
        "Mod+Escape" = "session-quit";
        "Mod+Shift+Escape" = { action = "shortcuts-inhibit-toggle"; allow_when_inhibited = true; repeat = false; };

        # Media
        "XF86AudioRaiseVolume" = { action = "spawn noctalia msg volume-up"; allow_when_locked = true; };
        "XF86AudioLowerVolume" = { action = "spawn noctalia msg volume-down"; allow_when_locked = true; };
        "XF86AudioMute" = { action = "spawn noctalia msg volume-mute"; allow_when_locked = true; repeat = false; };
        "XF86AudioPlay" = { action = "spawn noctalia msg media toggle"; allow_when_locked = true; repeat = false; };
        "XF86AudioNext" = { action = "spawn noctalia msg media next"; allow_when_locked = true; };
        "XF86AudioPrev" = { action = "spawn noctalia msg media previous"; allow_when_locked = true; };
        "XF86MonBrightnessUp" = { action = "spawn noctalia msg brightness-up"; allow_when_locked = true; };
        "XF86MonBrightnessDown" = { action = "spawn noctalia msg brightness-down"; allow_when_locked = true; };

        # Focus and movement
        "Mod+B" = "window-focus-left";
        "Mod+N" = "window-focus-down";
        "Mod+P" = "window-focus-up";
        "Mod+F" = "window-focus-right";
        "Mod+Shift+B" = "column-move-left";
        "Mod+Shift+N" = "window-move-down";
        "Mod+Shift+P" = "window-move-up";
        "Mod+Shift+F" = "column-move-right";

        # Window state and layout
        "Mod+T" = { action = "window-toggle-floating"; repeat = false; };
        "Mod+Shift+T" = { action = "window-toggle-pinned"; repeat = false; };
        "Mod+M" = { action = "window-toggle-maximize"; repeat = false; };
        "Mod+Shift+M" = { action = "window-toggle-fullscreen"; repeat = false; };
        "Mod+R" = "window-cycle-primary-extent";
        
        "Mod+Shift+R" = "window-cycle-primary-extent-back";
        "Mod+Minus" = "window-modify-primary-extent -0.02";
        "Mod+Equal" = "window-modify-primary-extent +0.02";
        "Mod+Ctrl+Minus" = "window-modify-secondary-extent -0.02";
        "Mod+Ctrl+Equal" = "window-modify-secondary-extent +0.02";
        
        "Mod+Comma" = "window-consume-left";
        "Mod+Period" = "window-consume-right";
        "Mod+Ctrl+Comma" = "window-consume-from-left";
        "Mod+Ctrl+Period" = "window-consume-from-right";
        # Needs layout.mode = "dwindle".
        # "Mod+Alt+T" = "layout-toggle-split"
        "Mod+W" = { action = "column-toggle-tabbed"; repeat = false; };
        "Mod+Alt+Right" = "column-focus-tab-next";
        "Mod+Alt+Left" = "column-focus-tab-previous";
        "Mod+WheelUp" = "window-focus-left";
        "Mod+WheelDown" = "window-focus-right";
        "Mod+O" = { action = "overview-toggle"; repeat = false; };

        # Workspaces
        "Mod+1" = "workspace-switch 1";
        "Mod+2" = "workspace-switch 2";
        "Mod+3" = "workspace-switch 3";
        "Mod+4" = "workspace-switch 4";
        "Mod+5" = "workspace-switch 5";
        "Mod+6" = "workspace-switch 6";
        "Mod+7" = "workspace-switch 7";
        "Mod+8" = "workspace-switch 8";
        "Mod+9" = "workspace-switch 9";
        "Mod+Shift+1" = "window-move-to-workspace 1";
        "Mod+Shift+2" = "window-move-to-workspace 2";
        "Mod+Shift+3" = "window-move-to-workspace 3";
        "Mod+Shift+4" = "window-move-to-workspace 4";
        "Mod+Shift+5" = "window-move-to-workspace 5";
        "Mod+Shift+6" = "window-move-to-workspace 6";
        "Mod+Shift+7" = "window-move-to-workspace 7";
        "Mod+Shift+8" = "window-move-to-workspace 8";
        "Mod+Shift+9" = "window-move-to-workspace 9";
      };
    };
  };
}

