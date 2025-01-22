# Packages!
{ config, lib, pkgs, modulesPath, ... }:

{
  environment.systemPackages = with pkgs; [
    # Basic Utils
    wget
    git
    htop
    fzf
    jq
    mg

    # NixOS Helpers
    nix-output-monitor
    nix-tree
    nh
    nvd
  ];
}
