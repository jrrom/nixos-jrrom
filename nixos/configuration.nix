{ config, lib, pkgs, inputs, information, jrromlib, ... }:

{
    imports =
      [
        ./hardware-configuration.nix
        ./disk-config.nix
        ./packages.nix
      ] ++ (jrromlib.importDir ./root);

  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = information.hostName; # Define your hostname.
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "wpa_supplicant";

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

  # Required?
  programs.dconf.enable = true;
  
  # Audio 'n' more.
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;
  
  # Fishy business
  programs.fish.enable = true;
  users.users."${information.hostName}" = {
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
    trusted-users = root ${information.hostName}
  '';

  system.stateVersion = "24.11"; # Did you read the comment?
}

