# Emacs
{ inputs, ... }: {
  flake.nixosModules.emacs = { pkgs, ... }: {
    nixpkgs.overlays = [ inputs.emacs-overlay.overlay ];
    environment.systemPackages = with pkgs; [
      catdoc # Display Word files
      dtach # "Concurrency" for those programmes below
      epub-thumbnailer # Get ePub thumbnails
      fd # User friendly find
      ffmpegthumbnailer # Get video thumbnails
      file # File data
      hledger # For ledgers
      imagemagick # Get image thumbnails
      inkscape # Get SVG thumbnails
      mediainfo # Get multimedia metadata
      poppler
      poppler-utils # Everything PDF
      ripgrep # Superfast search
      trash-cli # Garbage
      vips
      vipsdisp # Image processing

      # For Nix editing
      nixd
      nixfmt

      # For C editing
      clang-tools
      clang

      # Environments
      devenv
    ]
      ++ ( 
      pkgs.emacsWithPackagesFromUsePackage {
        package = pkgs.emacs-pgtk;
        config = ../parts/emacs.org;
        defaultInitFile = false;
        alwaysTangle = true;
        extraEmacsPackages = epkgs: [
          (epkgs.treesit-grammars.with-all-grammars)
        ];
      });

    environment.sessionVariables = {
      EDITOR = "emacs";
      VISUAL = "emacs";
    };

    programs.nano.enable = false;

    # Environment
    
    programs.direnv = {
      enable = true;
      enableFishIntegration = true;
    };

    # Home
    home.file.".config/emacs/init.el".source = config.lib.file.mkOutOfStoreSymlink "/home/jrrom/nixos-jrrom/hosts/laptop/init.el";
  };

  imports = [
    inputs.home-manager.flakeModules.home-manager
  ];
}
