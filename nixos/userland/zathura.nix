{ pkgs, ... }:

{
  programs.zathura = {
    enable = true;
    options = {
      font = "monospace normal 13";
      recolor = true;
      recolor-keephue = true;
    };
  };
}
