# Emacs
{ inputs, ... }: {
  flake.nixosModules.emacs = { pkgs, ... }: {
    nixpkgs.overlays = [ inputs.emacs-overlay.overlay ];
    environment.systemPackages = with pkgs; [
      # Dependencies
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
      pandoc

      # Environment
      devenv

      # For Nix editing
      nixd
      nixfmt

      # For C editing
      clang-tools
      clang

      # Graphs
      plantuml-c4
      graphviz # Dependency for plantuml rendering

      # Structured data editing
      miller

      # Cloud
      opentofu
      opentofu-ls # ??? dunno
    ]
    ++ [( 
      pkgs.emacsWithPackagesFromUsePackage {
        package = pkgs.emacs-pgtk;
        config = ../parts/emacs.org;
        defaultInitFile = false;
        alwaysTangle = true;
        extraEmacsPackages = epkgs: [
          (epkgs.treesit-grammars.with-all-grammars)
        ];
      })] ++ [
        # Scripting language for scripts
        (pkgs.python3.withPackages (python-pkgs: with python-pkgs; [
          numpy
          pandas
          tkinter
          xlrd # .xls old format
        ]))
        basedpyright
      ];

    environment.sessionVariables = {
      EDITOR = "emacs";
      VISUAL = "emacs";
    };

    programs.nano.enable = false;
  };

  flake.homeModules.emacs = { pkgs, config, ... }: {
    home.file.".config/emacs/init.el".source = config.lib.file.mkOutOfStoreSymlink "/home/jrrom/nixos-jrrom/parts/init.el";
  };
}
