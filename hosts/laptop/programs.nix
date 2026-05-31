{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  # Editors
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
  programs.nano.enable = false;

  # Development tools
  programs.git = {
    enable = true;
    config = {
      user = {
        email = "77691121+jrrom@users.noreply.github.com";
        name = "jrrom";
      };
    };
  };
  programs.direnv = {
    enable = true;
    enableFishIntegration = true;
  };

  # Applications
  programs.firefox.enable = true;
  programs.obs-studio.enable = true;
  programs.appimage = {
    enable = true;
    binfmt = true;
  };
  programs.kDrive.enable = true;

  # System packages
  environment.systemPackages = with pkgs; [
    adwaita-qt
    adwaita-qt6
    aider-chat-full
    aseprite
    blender
    clang-tools
    curl
    ffmpeg
    ghostscript
    mpv
    fd
    file
    findutils
    foliate
    gcc
    gh
    htop
    imagemagick
    inkscape
    jetbrains.datagrip
    jetbrains.idea
    keepassxc
    man-pages
    man-pages-posix
    mediainfo
    nicotine-plus
    nixd
    nixfmt
    pandoc
    poppler
    qbittorrent
    strawberry
    texliveFull
    tinymist
    trash-cli
    tree
    typst
    unzip
    vips
    vipsdisp
    wget
    wl-clipboard
    xdg-ninja

    ncgopher
  ] ++ [(
    pkgs.emacsWithPackagesFromUsePackage {
      package = pkgs.emacs-pgtk;
      config = ./emacs.org;
      defaultInitFile = false;
      alwaysTangle = true;
      extraEmacsPackages = epkgs: [
        (epkgs.treesit-grammars.with-all-grammars)
      ];
    }
  )];

  services.emacs.package = pkgs.emacs-unstable;
  services.emacs.enable = true;
}
