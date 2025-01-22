{ pkgs, ... }:

let
  emacs = pkgs.emacs30-pgtk;
in
{
  programs.emacs = {
    enable = true;
    package = emacs;
  };

  services.emacs = {
    enable = true;
    package = emacs;
    # defaultEditor = true;
  };
}
