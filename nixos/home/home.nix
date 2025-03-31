{ config, pkgs-unstable, inputs, lib, information, jrromlib, ... }:

{
  home.username = information.hostName;
  home.homeDirectory = "/home/${information.hostName}";

  # This value determines the Home Manager release that your configuration is
  # compatible with. You should not change this value.
  home.stateVersion = "24.11";

  # Shared home packages
  home.packages = with pkgs-unstable; [
    # NixOS Helpers
    nix-output-monitor
    nix-tree
    nh
    nvd
    steam-run

    # Utils
    clang-tools
    gdb
    shellcheck
    devenv

    # LSPs
    vscode-langservers-extracted
    gopls
    lua-language-server
    basedpyright
    bash-language-server
    nixd
  ];
  
  imports = jrromlib.importDir ./programs;

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file.".emacs.d".source = config.lib.file.mkOutOfStoreSymlink "/home/${information.hostName}/nixos-jrrom/dotfiles/emacs";

  xdg.enable = true;

  home.sessionVariables = {
    TERMINAL = "wezterm";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  
  # Systemd reload when switching
  systemd.user.startServices = "sd-switch";
}
