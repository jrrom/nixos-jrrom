{ inputs, ... }: {
  flake.nixosModules.aristillus = { pkgs, ... }: {
    time.timeZone = "Asia/Kolkata";
    i18n = {
      defaultLocale = "en_IN";
      extraLocales = [ "en_US.UTF-8/UTF-8" ];
    };

    users.users.aristillus = {
      isNormalUser = true;
      extraGroups = [
        "wheel" "networkmanager" "floppy" "audio" "cdrom" "video"
        "usb" "users" "plugdev" "pipewire" "docker" "libvirt"
        "scanner" "lp"
      ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFO1kn/983377PaE6JQO9UoiJ67ZZWNZxyouUVkhJYKd maintainer@jrrom.com"
      ];
    };
  };
}
