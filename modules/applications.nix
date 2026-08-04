{ inputs, ... }: {
  flake.nixosModules.applications = { pkgs, ... }: {
    imports = [
      inputs.kDrive.nixosModules.default
    ];
    
    nixpkgs.overlays = [ inputs.emacs-overlay.overlay ];
    environment.systemPackages = with pkgs; [
      # Desktop
      aseprite
      blender
      foliate
      jetbrains.datagrip
      jetbrains.idea
      keepassxc
      livecaptions
      nicotine-plus
      qbittorrent
      strawberry
      tenacity
      vlc

      # CLI
      curl
	    exercism # for practice and stuff
      ffmpeg
      gh
      jq
      man-pages
      man-pages-posix
      ncgopher
      pandoc
      texliveFull
      tree
      unrar
      unrtf
      unzip
      wget
      wl-clipboard
      xdg-ninja
    ];

    programs.firefox.enable = true;
    programs.kDrive.enable = true;
    programs.obs-studio.enable = true;

    programs.git = {
      enable = true;
      config = {
        user = {
          email = "77691121+jrrom@users.noreply.github.com";
          name = "jrrom";
        };
      };
    };
  };
}
