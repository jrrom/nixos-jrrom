{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    # Hardware
    ./hardware-configuration.nix
    ./disko-config.nix
  ];

  # Nix
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
      "pipe-operators"
    ];
  };
  nixpkgs.config.allowUnfree = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };
  nix.optimise.automatic = true;
  nixpkgs.overlays = [ inputs.emacs-overlay.overlay ];

  # Boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  #  boot.zfs.devNodes = "/dev/"; uncomment for VirtIO disk
  boot.zfs.requestEncryptionCredentials = true;
  boot.supportedFilesystems = [ "zfs" ];
  boot.initrd.supportedFilesystems = [ "zfs" ];
  services.zfs.autoScrub = {
    enable = true;
    interval = "monthly";
  };

  # Impermanence
  fileSystems."/persistence".neededForBoot = true;
  boot.initrd.systemd.enable = true;
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
      "/var/lib/nixos"
      "/var/lib/flatpak"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
    ];
    files = [
      "/etc/machine-id"
    ];
  };

  # System
  time.timeZone = "Asia/Kolkata";
  i18n = {
    defaultLocale = "en_IN";
    # See wiki.nixos.org/wiki/Locales
    extraLocales = [ "en_US.UTF-8/UTF-8" ];
  };
  users.users.root.hashedPasswordFile = "/persistence/passwords/root";
  users.users.jrrom = {
    hashedPasswordFile = "/persistence/passwords/jrrom";
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "floppy"
      "audio"
      "cdrom"
      "video"
      "usb"
      "users"
      "plugdev"
      "pipewire"
      "docker"
      "libvirt"
    ];
  };

  # Environment
  environment.sessionVariables = rec {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";

    # Ruby
    BUNDLE_USER_CONFIG ="${XDG_CONFIG_HOME}/bundle";
    BUNDLE_USER_CACHE  ="${XDG_CACHE_HOME}/bundle";
    BUNDLE_USER_PLUGIN ="${XDG_DATA_HOME}/bundle";
      
    _JAVA_OPTIONS = "-Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java";
    HISTFILE = "$HOME/.local/state/bash/history";

    QT_QPA_PLATFORM = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };

  # Networking
  networking.hostName = "jrrom"; # Define your hostname.
  networking.hostId = "ede53986";
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = true;
  networking.firewall.enable = true;

  # Pipewire
  security.rtkit.enable = true; # Realtime scheduler
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Input
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkb.options in tty.
  };
  services.libinput.enable = true; # Touchpad
  services.xserver = {
    xkb.layout = "us";
    xkb.options = "ctrl:swapcaps";
  };
  hardware.bluetooth.powerOnBoot = false;

  # Desktop
  services.displayManager.cosmic-greeter.enable = true;
  services.desktopManager.cosmic.enable = true;
  services.desktopManager.cosmic.xwayland.enable = true;
  environment.cosmic.excludePackages = with pkgs; [
    cosmic-store
  ];

  # Virtualisation & Docker
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  virtualisation.docker.enable = true;

  # Applications
  programs.git = {
    enable = true;
    config = {
      user = {
        email = "77691121+jrrom@users.noreply.github.com";
        name = "jrrom";
      };
    };
  };
  programs.firefox.enable = true;
  programs.obs-studio.enable = true;
  services.flatpak.enable = true;
  programs.direnv = {
    enable = true;
    enableFishIntegration = true;
  };
  programs.appimage = {
    enable = true;
    binfmt = true;
  };
  programs.kDrive.enable = true;

  # Programs
  environment.systemPackages = with pkgs; [
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

    # GUI
    adwaita-qt
    adwaita-qt6
    aseprite
    blender
    foliate
    inkscape
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

  # Appearance
  fonts.packages = with pkgs; [
    maple-mono.truetype
    nerd-fonts.symbols-only
  ];
  fonts.fontconfig = {
    enable = true;
    antialias = true;
    hinting = {
      enable = true;
      style = "slight";
    };
    subpixel = {
      rgba = "rgb";  # try "rgb" first, or "bgr" if that looks worse
      lcdfilter = "default";
    };
  };

  # see https://nixos.org/manual/nixos/stable/#sec-upgrading
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  system.stateVersion = "25.05";
}
