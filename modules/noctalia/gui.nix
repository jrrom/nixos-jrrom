{ inputs, config, lib, ... }:
let
  constants = config.constants;
in
{
  flake.homeModules.gui = { config, pkgs, ... }: {
    gtk = {
      enable = true;
      theme = null;
      gtk4.theme = null;
      iconTheme = {
        name = "Gruvbox-Plus-Dark";
        package = pkgs.gruvbox-plus-icons;
      };
    };
    home.packages = [ pkgs.adw-gtk3 ];

    dconf.settings."org/gnome/desktop/interface" = {
      gtk-theme    = "adw-gtk3-dark";
      color-scheme = "prefer-dark";
      icon-theme   = "Gruvbox-Plus-Dark";
    };
    
    # Noctalia must be able to write these
    xdg.configFile."gtk-3.0/gtk.css".enable = lib.mkForce false;
    xdg.configFile."gtk-4.0/gtk.css".enable = lib.mkForce false;

    qt = { enable = true; platformTheme.name = "qt6ct"; };

    home.pointerCursor = {
      enable = true;
      name = constants.cursor.name;
      package = pkgs.${constants.cursor.pkg};
      size = constants.cursor.size;
      gtk.enable = true;
    };
  };
}
