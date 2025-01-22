{ config, pkgs, stylix, ... }:

{ 
  fonts.packages = with pkgs; [
    terminus-nerdfont
    font-awesome
  ];
  
  stylix.enable = true;
  stylix.image  = ./nixos.png;
  stylix.polarity = "dark";
  
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";

  stylix.fonts = {
    serif = {
      package = pkgs.libre-baskerville;
      name = "Libre Baskerville";
    };

    sansSerif = {
      package = pkgs.ibm-plex;
      name = "IBM Plex Sans";
    };

    monospace = {
      package = pkgs.iosevka-comfy.comfy-wide;
      name = "Iosevka Comfy Wide";
    };

    emoji = {
      package = pkgs.noto-fonts-emoji;
      name = "Noto Color Emoji";
    };
  };

  stylix.fonts.sizes = {
    applications = 13;
    terminal = 15;
    desktop  = 10;
    popups   = 12;
  };
  
  stylix.cursor.package = pkgs.phinger-cursors;
  stylix.cursor.name = "phinger-cursors-light";
  stylix.cursor.size = 32;
}
