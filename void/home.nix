{ inputs, outputs, lib, config, pkgs, pkgs-unstable, information, ... }:

{
  targets.genericLinux.enable = true;
  # You can import other home-manager modules here
  imports = [
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  home = {
    username = information.hostName;
    homeDirectory = "/home/${information.hostName}";
  };

  home.packages = with pkgs-unstable; [
    # Fonts for Daily Use
    libre-baskerville
    iosevka-comfy.comfy-wide
    noto-fonts-color-emoji

    # Programs
    rsync

    # Languages
    smlnj
    
    # LSPs
    nixd
    basedpyright
  ];
  
# =================================
# Terminal
# =================================

  home.file.".config/fish".source = (
    config.lib.file.mkOutOfStoreSymlink "/home/${information.hostName}/nixos-jrrom/dotfiles/fish"
  );
  home.file.".config/nix" = {
    source = ../dotfiles/nix;
    recursive = true;
  };

  home.file.".config/python" = {
    source = ../dotfiles/python;
    recursive = true;
  };

  home.file.".config/ncmpcpp" = {
    source = ../dotfiles/ncmpcpp;
    recursive = true;
  };

  home.file.".config/mpd".source = (
    config.lib.file.mkOutOfStoreSymlink "/home/${information.hostName}/nixos-jrrom/dotfiles/mpd"
  );

# =================================
# Applications
# =================================

  home.file.".config/emacs/init.el".source = (
    config.lib.file.mkOutOfStoreSymlink "/home/${information.hostName}/nixos-jrrom/dotfiles/emacs/init.el"
  );
  home.file.".config/zathura" = {
    source = ../dotfiles/zathura;
    recursive = true;
  };
  home.file.".config/fuzzel" = {
    source = ../dotfiles/fuzzel;
    recursive = true;
  };
  home.file.".config/wezterm" = {
    source = ../dotfiles/wezterm;
    recursive = true;
  };
  
# =================================
# WM
# =================================

  home.file.".config/swaylock" = {
    source = ../dotfiles/swaylock;
    recursive = true;
  };
  home.file.".config/sway" = {
    source = ../dotfiles/sway;
    recursive = true;
  };
  home.file.".config/waybar".source = (
    config.lib.file.mkOutOfStoreSymlink "/home/${information.hostName}/nixos-jrrom/dotfiles/waybar"
  );
  home.file.".config/mako" = {
    source = ../dotfiles/mako;
    recursive = true;
  };

# =================================
# GTK
# =================================
  
  home.file.".config/gtk-3.0" = {
    source = ../dotfiles/gtk-3.0;
    recursive = true;
  };
  home.file.".config/gtk-4.0" = {
    source = ../dotfiles/gtk-4.0;
    recursive = true;
  };
  home.file.".gtkrc-2.0" = {
    source = ../dotfiles/.gtkrc-2.0;
  };
  home.file.".themes" = {
    source = ../dotfiles/.themes;
    recursive = true;
  };
  home.file.".config/xsettingsd" = {
    source = ../dotfiles/xsettingsd;
    recursive = true;
  };
  # home.file.".local/share/flatpak/overrides/global".source = (
  #   config.lib.file.mkOutOfStoreSymlink "/home/${information.hostName}/nixos-jrrom/dotfiles/flatpak/overrides/global"
  # );
  

# =================================
  
  # Enable home-manager and git
  programs.home-manager.enable = true;

  home.stateVersion = "24.11";
}
