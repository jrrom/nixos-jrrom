{ config, pkgs, inputs, lib, ... }:

{
  home.username = "jrrom";
  home.homeDirectory = "/home/jrrom";

  # This value determines the Home Manager release that your configuration is
  # compatible with. You should not change this value.
  home.stateVersion = "24.11";

  # The home.packages option allows you to install Nix packages into your
  # environment.

  imports = [
     # WM
    ./programs/sway.nix
    ./programs/waybar.nix
    ./programs/styles.nix

    # Terminal
    ./programs/fish.nix
    ./programs/fastfetch.nix

    # Programs
    ./programs/firefox.nix
    ./programs/wezterm.nix
    ./programs/fuzzel.nix
    ./programs/gammastep.nix
    ./programs/flameshot.nix
    ./programs/networkmanagerapplet.nix
    ./programs/zathura.nix
    ./programs/music.nix
    ./programs/bluetooth.nix
    ./programs/emacs.nix

    # Development
    ./development.nix
  ];

  home.packages = with pkgs; [
    mako
    clipman
    grim
    slurp
    swappy
    
    # Commandline
    yazi
    tree
    pandoc
    tldr
    glow
    ripgrep
    gh
    xorg.xeyes

    # Programs
    blender
    aseprite
    keepassxc
    pavucontrol
    thunderbird
    nicotine-plus
    xfce.thunar

    # JetBrains
    jetbrains.idea-ultimate
    jetbrains.ruby-mine
    jetbrains.datagrip
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file.".emacs.d".source = config.lib.file.mkOutOfStoreSymlink "/home/jrrom/nixos-jrrom/home/dotfiles/emacs";

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/root/etc/profile.d/hm-session-vars.sh
  #

  xdg.enable = true;

  home.sessionVariables = {
    TERMINAL = "wezterm";
  };

  

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  
  # Systemd reload when switching
  systemd.user.startServices = "sd-switch";

  # Weird fix for syncthingtray
  systemd.user.services.syncthingtray = {
      Service.ExecStart = lib.mkForce "${pkgs.syncthingtray}/bin/syncthingtray --wait";
  };
}
