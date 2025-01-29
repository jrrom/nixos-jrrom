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
    trash-cli
    tree
    yazi
    glow
    tldr
    ripgrep
    steam-run
    usbutils

    # Yeah
    gcc
    clang
    
    # Wayland
    clipman

    # NixOS Helpers
    nix-output-monitor
    nix-tree
    nh
    nvd
  ];
}
