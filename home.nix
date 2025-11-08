{ config, pkgs, ... }:

{
  home.username = "jrrom";
  home.homeDirectory = "/home/jrrom";

  # Cosmic Manager
  # Thank you to https://github.com/HeitorAugustoLN/nix-config/
  wayland.desktopManager.cosmic.appearance = {
    apply_theme_global = true;
    theme = {
      dark = importRON "./misc/Gruvbox Dark.ron";
      mode = "dark";
    };

    toolkit = {
      apply_theme_global = true;

      interface_font = {
        family = "Fira Sans";
        # stretch = mkRON "enum" "Normal";
        # style = mkRON "enum" "Normal";
        # weight = mkRON "enum" "Normal";
      };

      # monospace_font = {
      #   family = "JetBrains Mono";
      #   stretch = mkRON "enum" "Normal";
      #   style = mkRON "enum" "Normal";
      #   weight = mkRON "enum" "Normal";
      # };
    };
  }
  
  home.stateVersion = "25.05";
}
