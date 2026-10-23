{ inputs, ... }: {
  flake.nixosModules.applications = { pkgs, ... }: {
    imports = [
      inputs.kDrive.nixosModules.default
    ];
    
    nixpkgs.overlays = [ inputs.emacs-overlay.overlay ];
    environment.systemPackages = with pkgs; [
      aseprite
      blender
      foliate
      godot
      jetbrains.datagrip
      jetbrains.idea
      keepassxc
      livecaptions
      nicotine-plus
      qbittorrent
      strawberry
      tenacity
      vlc
      zathura
<<<<<<< HEAD
=======
      zulip
      libreoffice
>>>>>>> 09d5942d (Syncing again)
    ];

    programs.firefox.enable = true;
    programs.kDrive.enable = true;
    programs.obs-studio.enable = true;


  };
}
