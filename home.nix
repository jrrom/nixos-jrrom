{ config, pkgs, lib, ... }:

{
  home.username = "jrrom";
  home.homeDirectory = "/home/jrrom";

  # Cosmic Manager
  # Thank you to https://github.com/HeitorAugustoLN/nix-config/
  # He is the creator
  wayland.desktopManager.cosmic = {
    enable = true;     # cosmic-manager CLI
    resetFiles = true; # Keep it impermanent
    
    appearance = {
      theme = {
        dark = lib.cosmic.importRON "./misc/Gruvbox Dark.ron";
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
    };
  };
  
  home.stateVersion = "25.05";
}
