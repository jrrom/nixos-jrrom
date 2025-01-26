{ pkgs, ... }:

{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "wezterm -e";
        icon-theme = "Papirus-Dark";
      };
    };
  };
}
