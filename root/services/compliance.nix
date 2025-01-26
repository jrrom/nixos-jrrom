{ pkgs, ... }:

{
  services.envfs.enable = true;

  programs.nix-ld = {
    enable = true;
  };
}
