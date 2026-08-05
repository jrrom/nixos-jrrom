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
      jetbrains.datagrip
      jetbrains.idea
      keepassxc
      livecaptions
      nicotine-plus
      qbittorrent
      strawberry
      tenacity
      vlc
    ];

    programs.firefox.enable = true;
    programs.kDrive.enable = true;
    programs.obs-studio.enable = true;


  };
}
