{ inputs, ... }: {
  flake.nixosModules.impermanence = { pkgs, ... }: {
    # Boot
    #  boot.zfs.devNodes = "/dev/"; uncomment for VirtIO disk
    boot = {
      loader.systemd-boot.enable = true;
      loader.efi.canTouchEfiVariables = true;

      zfs.requestEncryptionCredentials = true;   
      zfs.forceImportRoot = false;
      supportedFilesystems = [ "zfs" ];
      
      initrd.supportedFilesystems = [ "zfs" ];
      initrd.systemd.enable = true;
    };
    
    services.zfs.autoScrub = {
      enable = true;
      interval = "monthly";
    };

    # Impermanence
    fileSystems."/persistence".neededForBoot = true;
    boot.initrd.systemd.services.rollback = {
      description = "Rollback root filesystem to a pristine state on boot";
      wantedBy = [ "initrd.target" ];
      after = [ "zfs-import-zroot.service" ];  # Change "zroot" to match your pool name!
      before = [ "sysroot.mount" ];
      path = with pkgs; [ zfs ];
      unitConfig.DefaultDependencies = "no";
      serviceConfig.Type = "oneshot";
      script = ''
      zfs rollback -r zroot/root@blank && echo "rollback complete"
    '';
    };
    
    environment.persistence."/persistence" = {
      enable = true;
      hideMounts = true;
      directories = [
        "/var/log"
        "/var/db/sudo"
        "/var/lib/bluetooth"
        "/var/lib/docker"
        "/var/lib/nixos"
        "/var/lib/flatpak"
        "/var/lib/systemd/coredump"
        "/etc/NetworkManager/system-connections"
      ];
      files = [
        "/etc/machine-id"
      ];
    };

  };
}
