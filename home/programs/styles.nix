{ pkgs, stylix, ... }:

{
  stylix.iconTheme = {
    enable = true;
    package = pkgs.papirus-icon-theme;
  }
}
