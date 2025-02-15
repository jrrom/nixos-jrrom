# Packages!
{ config, lib, pkgs, pkgs-unstable, modulesPath, ... }:

{
  environment.systemPackages = with pkgs; [
    # Basic Utils
    wget
    git
    htop
    fzf
    jq
    trash-cli
    tree
    yazi
    glow
    tldr
    ripgrep
    usbutils
    pandoc
    gh
    xorg.xeyes

    # Yeah
    gcc
    clang
    gnumake
    
    # Wayland
    clipman
    mako
    grim
    slurp
    swappy

    # Programs
    blender
    aseprite
    keepassxc
    pavucontrol
    thunderbird
    nicotine-plus
    xfce.thunar
    vlc
    
    # IDES
    jetbrains.idea-ultimate
    jetbrains.ruby-mine
    jetbrains.datagrip
  ];
}
