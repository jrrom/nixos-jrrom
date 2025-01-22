{ pkgs, ... }:

{
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = ./nixos.png;
        padding.right = 2;
        padding.left  = 2;
        padding.top   = 1;
        padding.bottom = 1;
        # width = 16;
        # height = 16;
      };
      modules = [
        "Break"
        "Title"
        "Break"
        "OS"
        "Packages"
        "Btrfs"
        "Memory"
      ];
    };
  };
}
