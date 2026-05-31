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
    # Documentation
    man-pages
    man-pages-posix
    nixfmt-rfc-style

    # Everyday
    aider-chat-full
    curl
    ffmpeg
    file
    findutils
    gh
    htop
    imagemagick
    mediainfo
    pandoc
    poppler
    texliveFull
    trash-cli
    tree
    unzip
    vips
    vipsdisp
    wget
    wl-clipboard
    xdg-ninja

    # Dev
    clang-tools
    gcc
    nixd
    tinymist
    typst
    kubernetes
    (google-cloud-sdk.withExtraComponents [google-cloud-sdk.components.gke-gcloud-auth-plugin])

    # GUI
    adwaita-qt
    adwaita-qt6
    aseprite
    blender
    foliate
    inkscape
    jetbrains.datagrip
    jetbrains.idea
    keepassxc
    nicotine-plus
    qbittorrent
    strawberry

    # Maintainer Programs
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
