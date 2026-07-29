{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  nixpkgs.hostPlatform = "x86_64-linux";
  
  imports = [
    # Hardware
    ./hardware-configuration.nix
    ./programs.nix
    ./disko-config.nix
  ];

  # Nix
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
      "pipe-operators"
    ];
    auto-optimise-store = true;
    trusted-users = [ "root" "jrrom" ];
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
  #  boot.zfs.devNodes = "/dev/"; uncomment for VirtIO disk
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.zfs.requestEncryptionCredentials = true;
  boot.zfs.forceImportRoot = false;
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

  # System
  services.fwupd.enable = true;
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
      "scanner"
      "lp"
    ];
  };

  # Environment
  environment.sessionVariables = rec {
    XDG_CACHE_HOME  = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME   = "$HOME/.local/share";
    XDG_STATE_HOME  = "$HOME/.local/state";
    QT_QPA_PLATFORM = "wayland";

    ANDROID_USER_HOME = "${XDG_DATA_HOME}/android";
    ANDROID_AVD_HOME  = "${XDG_DATA_HOME}/android/avd";
    HISTFILE          = "$HOME/.local/state/bash/history";
    PYTHON_HISTORY    = "${XDG_STATE_HOME}/python_history";
    
    _JAVA_OPTIONS     = "-Djava.util.prefs.userRoot=${XDG_CONFIG_HOME}/java -Djavafx.cachedir=${XDG_CACHE_HOME}/openjfx";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    GRADLE_USER_HOME="${XDG_DATA_HOME}/gradle";

    DOTNET_CLI_HOME        = "${XDG_DATA_HOME}/dotnet";
    NPM_CONFIG_INIT_MODULE = "${XDG_CONFIG_HOME}/npm/config/npm-init.js";
    NPM_CONFIG_CACHE       = "${XDG_CACHE_HOME}/npm";
    NPM_CONFIG_TMP         = "$XDG_RUNTIME_DIR/npm";
    
    AIDER_CONFIG_FILE = "${XDG_CONFIG_HOME}/aider/config.yml";
    AIDER_DARK_MODE   = "true";
  };

  environment.variables = rec {
    EDITOR = "nvim";
    VISUAL = "nvim";
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

  # Flatpak
  services.flatpak.enable = true;

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
    localConf = ''
    <?xml version="1.0"?>
    <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
    <fontconfig>
      <match target="pattern">
         <edit name="dpi" mode="assign">
            <double>142</double>
         </edit>
      </match>
    </fontconfig>
    '';
  };

  # Printing & Scanning
  services.printing = {
    enable = true;
    drivers = [ pkgs.hplip ];
  };
  
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.hplipWithPlugin ];
  };
  
  # see https://nixos.org/manual/nixos/stable/#sec-upgrading
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  system.stateVersion = "25.05";
}
