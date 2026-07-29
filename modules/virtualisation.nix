{ inputs, ... }: {
  flake.nixosModules.virtualisation = { pkgs, ... }: {
    # Virtualisation & Docker
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;
    virtualisation.docker.enable = true;

    # Flatpak
    services.flatpak.enable = true;

    # AppImage
    programs.appimage = {
      enable = true;
      binfmt = true;
    };

    # Steam Run
    environment.systemPackages = with pkgs; [
      (steam.override {
        extraPkgs = p: with p; [ libGLU ];
      }).run
    ];
  };
}
