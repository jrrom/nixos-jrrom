{ inputs, ... }: {
  flake.nixosModules.virtualisation = { pkgs, ... }: {
    # Virtualisation & Docker
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;
    virtualisation.docker.enable = true;

    # Flatpak
    # services.flatpak.enable = true;

    # AppImage
    programs.appimage = {
      enable = true;
      binfmt = true;
    };
  };
}
