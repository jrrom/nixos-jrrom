{ config, pkgs, ... }:

{
  wayland.windowManager.sway = {
    enable = true;
    systemd = {
      enable = true;
    };
    package = pkgs.sway;
    config = rec {
      menu = "fuzzel";
      terminal = "wezterm";
      modifier = "Mod4";
      input = {
        "*" = {
          "xkb_layout" = "us";
          "xkb_options" = "ctrl:swapcaps";
        };
      };
      floating.criteria = [
        { window_type = "dialog"; }
        { window_role = "dialog"; }
      ];
      gaps.inner = 20;
      bars = [ { command = "waybar"; } ];
    };
    extraConfig = ''
      # Brightness controls
      bindsym --locked XF86MonBrightnessUp exec --no-startup-id light -A 10
      bindsym --locked XF86MonBrightnessDown exec --no-startup-id light -U 10
      
      # Run launcher
      unbindsym Mod4+d
      unbindsym Mod4+r
      bindsym Mod4+r exec fuzzel

      for_window [shell="xwayland"] title format "[XWayland] %title"

      # Remove titlebars
      default_border pixel 4
    '';
  };
}
