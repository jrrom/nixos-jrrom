{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./disk-config.nix
      ./packages.nix
      ./styles.nix
      ./services/greetd.nix
      ./services/laptop.nix
      ./services/bluetooth.nix
      ./services/sync.nix
      ./services/protonmail.nix
      ./services/tmpfs.nix
      ./services/android.nix
    ];

  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "jrrom"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  networking.networkmanager.wifi.backend = "wpa_supplicant";
  # Doesn't work for me

  # Set your time zone.
  time.timeZone = "Asia/Calcutta";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  # Enable CUPS to print documents.
  services.printing.enable = true;
  
  # Power Management
  powerManagement.enable = true;  
  
  # Security
  security.polkit.enable = true;

  # Graphics
  hardware.graphics.enable = true;

  # Let there be
  programs.light.enable = true;

  # Audio 'n' more.
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;
  
  # Fishy business
  programs.fish.enable = true;
  users.users.jrrom = {
    isNormalUser = true;
    shell = pkgs.fish;
    
    extraGroups = [ "wheel" "input" "network-manager" "light" "audio" "video" "adbusers" ];
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" "pipe-operators" ];
  
  # Clean up Nix
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  nix.optimise.automatic = true;

  # Trusting cachix and devenv
  nix.extraOptions = ''
    trusted-users = root jrrom
  '';
  
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  system.stateVersion = "24.11"; # Did you read the comment?
}

