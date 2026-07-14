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
    catdoc
    chafa
    clang-tools
    curl
    devenv
    dtach
    epub-thumbnailer
    fd
    ffmpeg
    ffmpegthumbnailer
    file
    findutils
    foliate
    gcc
    gh
    ghostscript
    hledger
    htop
    imagemagick
    inkscape
    jetbrains.datagrip
    jetbrains.idea
    jq
    keepassxc
    man-pages
    man-pages-posix
    mediainfo
    mpv
    nicotine-plus
    nixd
    nixfmt
    pandoc
    poppler
    poppler-utils
    qbittorrent
    ripgrep
    simple-scan
    (steam.override {
      extraPkgs = p: with p; [ libGLU ];
    }).run
    strawberry
    texliveFull
    tinymist
    trash-cli
    tree
    typst
    unrar
    unrtf
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

  services.teamviewer.enable = true;
}
